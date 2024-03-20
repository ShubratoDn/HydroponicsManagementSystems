package com.hydroponics.management.system.controllers;


import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.hydroponics.management.system.DTO.UserDTO;
import com.hydroponics.management.system.annotation.PreAuthorized;
import com.hydroponics.management.system.configs.Constants;
import com.hydroponics.management.system.entities.Notification;
import com.hydroponics.management.system.entities.User;
import com.hydroponics.management.system.entities.enums.NotificationType;
import com.hydroponics.management.system.enums.UserRole;
import com.hydroponics.management.system.payloads.LoginRequest;
import com.hydroponics.management.system.payloads.ServerMessage;
import com.hydroponics.management.system.services.FileServices;
import com.hydroponics.management.system.services.NotificationServices;
import com.hydroponics.management.system.services.SmsServices;
import com.hydroponics.management.system.services.UserServices;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

@Controller
public class AuthController {
	
	
	@Autowired
	private UserServices userServices;
	
	@Autowired
	private FileServices fileServices;
	
	@Autowired
	private ModelMapper mapper;
	

	
	@PreAuthorized(role = "ADMIN")
	@GetMapping("/add-user")
	public String registerPage(Model model) {
		return "add-user";
	}
	
	@PostMapping("/login")
	public String loginUser(@ModelAttribute LoginRequest loginRequest, Model model, HttpSession session) {
		model.addAttribute("loginInfo", loginRequest);	
		UserDTO user = userServices.getUserByPhoneOrEmail(loginRequest.getUsername());
		
		if(user == null) {
			System.out.println("User Not Found");
			model.addAttribute("serverMessage",  new ServerMessage("User not found!", "error", "alert-danger"));
			return "login";
		}
		
		boolean verifyPassword = userServices.verifyPassword(loginRequest.getPassword(), user.getPassword());
		
		if(!verifyPassword) {			
			model.addAttribute("serverMessage",  new ServerMessage("Wrong password!", "error", "alert-danger"));
			return "login";
		}
		
		model.addAttribute("serverMessage",  new ServerMessage("Login successfull", "success", "alert-success"));
		session.setAttribute("loggedUser", user);		
		return "redirect:/home";
	}
	
	
	
	@PreAuthorized(role = "ADMIN")
	@PostMapping("/add-user")
	public String registerUser(@Valid @ModelAttribute UserDTO userDTO,  BindingResult bindingResult, Model model, HttpServletRequest request, RedirectAttributes redirectAttributes) {
		
		//Validating Email and phone
		if(userServices.getUserByEmail(userDTO.getEmail()) != null) {
			bindingResult.addError(new FieldError("userDTO", "email", "Email already exist; try another email"));
		};
		
		if(userServices.getUserByPhone(userDTO.getPhone()) != null) {
			bindingResult.addError(new FieldError("userDTO", "phone", "Phone already exist; try another phone"));
		}
		
		
		// Validate role
        String roleInput = userDTO.getRole(); // Get the role string from the user
        @SuppressWarnings("unused")
		UserRole userRole = null;
        try {
            userRole = UserRole.valueOf(roleInput.toUpperCase()); // Convert string to enum safely
        } catch (IllegalArgumentException e) {
            // Invalid role
            bindingResult.addError(new FieldError("userDTO", "role", "Invalid role"));
        }
        
        
		
		MultipartFile file =  userDTO.getFile();
		
		// Check if the file is present
	    if (file != null && !file.isEmpty()) {
	        // Check if the file is an image
	        if (!file.getContentType().startsWith("image")) {
	            bindingResult.addError(new FieldError("userDTO", "file", "File must be an image"));
	        }

	        // Check file size (10MB limit)
	        if (file.getSize() > 10 * 1024 * 1024) {
	            bindingResult.addError(new FieldError("userDTO", "file", "File size must be under 10MB"));
	        }
	    } else {
	        // File is empty
	        bindingResult.addError(new FieldError("userDTO", "file", "File is required"));
	    }
		
	    // Validate password match
        if (!userDTO.getPassword().equals(userDTO.getConfirmPassword())) {
            bindingResult.addError(new FieldError("userDTO", "password", "Passwords do not match"));
            bindingResult.addError(new FieldError("userDTO", "confirmPassword", "Passwords do not match"));
        }
	    
	    
	    //ERROR CHECK
		if (bindingResult.hasErrors()) {
            // Pass the bindingResult to the model to display errors in the JSP
            model.addAttribute("inputErrors", bindingResult);
            model.addAttribute("userDto", userDTO);
            
            return "add-user"; // Redirect to the form page with errors
        }
		
		
	    
	    //uploading user image
	    String uploadFile = fileServices.uploadFile(file, Constants.UPLOAD_USER_IMAGE_DIRECTORY);	    	    
	    userDTO.setImage(uploadFile);
	    
	    //ADDED BY USER...
	    HttpSession session = request.getSession();
	    UserDTO loggedUser = (UserDTO) session.getAttribute("loggedUser");
	    if(loggedUser == null) {
	    	model.addAttribute("serverMessage", new ServerMessage("User register failed! You must be logged in as an Admin.", "error", "alert-danger"));
	    	return "login";
	    }
	    userDTO.setAddedBy(mapper.map(loggedUser, User.class));
		
		//adding user
		UserDTO addUser = userServices.addUser(userDTO);
		if(addUser == null) {
			redirectAttributes.addFlashAttribute("serverMessage", new ServerMessage("Error! User register failed.", "error", "alert-danger"));
		}else {
			redirectAttributes.addFlashAttribute("serverMessage", new ServerMessage("Congratulation! User added successfully.", "success", "alert-success"));			
			redirectAttributes.addFlashAttribute("userDTO", null);
		}		
		
		return "redirect:/add-user"; 
	}

	
	
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.removeAttribute("loggedUser");
		session.invalidate();
		return "login";
	}
	
	
}
