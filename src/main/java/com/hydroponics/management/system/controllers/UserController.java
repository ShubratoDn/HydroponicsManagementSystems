package com.hydroponics.management.system.controllers;

import java.util.List;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.hydroponics.management.system.DTO.UserDTO;
import com.hydroponics.management.system.annotation.LoginRequired;
import com.hydroponics.management.system.annotation.PreAuthorized;
import com.hydroponics.management.system.configs.Constants;
import com.hydroponics.management.system.entities.Environment;
import com.hydroponics.management.system.entities.User;
import com.hydroponics.management.system.enums.UserRole;
import com.hydroponics.management.system.payloads.ServerMessage;
import com.hydroponics.management.system.payloads.UpdateUserForm;
import com.hydroponics.management.system.services.EnvironmentServices;
import com.hydroponics.management.system.services.FileServices;
import com.hydroponics.management.system.services.UserServices;
import com.hydroponics.management.system.servicesImple.HelperServices;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

@Controller
public class UserController {

	@Autowired
	private UserServices userServices;

	@Autowired
	private ModelMapper modelMapper;

	@Autowired
	private HelperServices helperServices;

	@Autowired
	private EnvironmentServices environmentServices;
	
	@Autowired
	private FileServices fileServices;
	
	@Autowired
	private ModelMapper mapper;

	// profile page
	@LoginRequired
	@GetMapping("/user/{id}")
	public String profilePage(@PathVariable int id, Model model) {
		UserDTO userById = userServices.getUserById(id);
		User user = null;
		if (userById != null) {
			user = modelMapper.map(userById, User.class);
		} else {
			return "404";
		}

		model.addAttribute("user", user);
		List<Environment> allEnvironmentsByUser = environmentServices.getAllEnvironmentsByUser(user);
		model.addAttribute("envList", allEnvironmentsByUser);

		User loggedUser = helperServices.getLoggedUser();
		if (loggedUser != null) {
			String role = loggedUser.getRole();
			if (role.equalsIgnoreCase("admin") || role.equalsIgnoreCase("staff") || role.equalsIgnoreCase("owner")) {
				model.addAttribute("isAdmin", true);
			} else {
				model.addAttribute("isAdmin", false);
			}

			if (loggedUser.getId() == user.getId()) {
				model.addAttribute("isMyAccount", true);
			} else {
				model.addAttribute("isMyAccount", false);
			}
		}

		return "userDirectory/profile";
	}
	
	
	
	//update profile
	@LoginRequired
	@GetMapping("/user/update/{id}")
	public String updatePage(@PathVariable int id, Model model) {
		
		UserDTO userById = userServices.getUserById(id);
		
		if (userById == null) {		
			return "404";
		}
		userById.setPassword(null);
		model.addAttribute("userDTO", userById);


		User loggedUser = helperServices.getLoggedUser();
		if (loggedUser != null) {
			String role = loggedUser.getRole();
			boolean isAdmin = false;
			boolean isMyAccount = false;
			
			//is admin check
			if (role.equalsIgnoreCase("admin") || role.equalsIgnoreCase("staff") || role.equalsIgnoreCase("owner")) {				
				isAdmin = true;
			} else {				
				isAdmin = false;
			}

			//is my account check
			if (loggedUser.getId() == userById.getId()) {
				isMyAccount = true;				
			} else {
				isMyAccount = false;
			}
			
			if(isMyAccount || isAdmin) {
				model.addAttribute("isAdmin", isAdmin);
				model.addAttribute("isMyAccount", isMyAccount);
			}else {
				return "401";
			}			
			
		}

		
		return "userDirectory/update-profile";
	}
	
	
	
	@PostMapping("/user/update/{id}")
	public String updateUser(@PathVariable int id, @Valid @ModelAttribute UpdateUserForm userDTO,  BindingResult bindingResult, Model model, HttpServletRequest request, RedirectAttributes redirectAttributes) {

			
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
		    }
		    
			
		   if(userDTO.getPassword() != null || !userDTO.getPassword().isBlank()) {
			   // Validate password match
		        if (!userDTO.getPassword().equals(userDTO.getConfirmPassword())) {
		            bindingResult.addError(new FieldError("userDTO", "password", "Passwords do not match"));
		            bindingResult.addError(new FieldError("userDTO", "confirmPassword", "Passwords do not match"));
		        }
		   }
		    
		    
		    //ERROR CHECK
			if (bindingResult.hasErrors()) {
	            // Pass the bindingResult to the model to display errors in the JSP
	            redirectAttributes.addFlashAttribute("inputErrors", bindingResult);
	            redirectAttributes.addFlashAttribute("userDto", userDTO);
	            
	        	return "redirect:/user/update/"+id; // Redirect to the form page with errors
	        }
			
			
			if (file != null && !file.isEmpty()) {				
				//uploading user image
				String uploadFile = fileServices.uploadFile(file, Constants.UPLOAD_USER_IMAGE_DIRECTORY);	    	    
				userDTO.setImage(uploadFile);
			}
		    
			
		    //ADDED BY USER...
		    HttpSession session = request.getSession();
		    UserDTO loggedUser = (UserDTO) session.getAttribute("loggedUser");
		    if(loggedUser == null) {
		    	model.addAttribute("serverMessage", new ServerMessage("User register failed! You must be logged in as an Admin.", "error", "alert-danger"));
		    	return "login";
		    }
		    userDTO.setAddedBy(mapper.map(loggedUser, User.class));
			
		    
		    
		    userDTO.setId(id);
		    
		    //Updating user
			UserDTO addUser = userServices.updateUser(modelMapper.map(userDTO, UserDTO.class));
			if(addUser == null) {
				redirectAttributes.addFlashAttribute("serverMessage", new ServerMessage("Error! User Update failed.", "error", "alert-danger"));
			}else {
				redirectAttributes.addFlashAttribute("serverMessage", new ServerMessage("Successfully update the profile.", "success", "alert-success"));			
				redirectAttributes.addFlashAttribute("userDTO", null);
			}		
		
		
		
		return "redirect:/user/update/"+id;
	}
	
	
	@PreAuthorized(roles = {"admin", "owner", "staff"})
	@GetMapping("/user/all")
	public String showAllUsers(
			@RequestParam(value = "page", defaultValue = "0", required = false) int page,
			@RequestParam(value = "size", defaultValue = "5", required = false) int size,
			@RequestParam(value = "sortBy", defaultValue = "id", required = false) String sortBy,
			@RequestParam(value = "sortDirection", defaultValue = "desc", required = false) String sortDirection,
			Model model
			) {
		
		List<UserDTO> allUser = userServices.getAllUser();
		model.addAttribute("userList", allUser);
		return "userDirectory/all-users";
	}

	
	@PreAuthorized(roles = {"admin", "owner", "staff"})
	@GetMapping("/user/search")
	public String findUsersPage() {
		return "userDirectory/search-user";
	}
	
	
	@PostMapping("/api/user/search/result")
	public ResponseEntity<?> findUserByQuery(@RequestParam(name = "search_query", required = false, defaultValue = "x") String search_query) {
		//List<UserDTO> usersBySearchQuery = userServices.getUsersBySearchQuery(search_query);
		return ResponseEntity.ok(userServices.getUsersBySearchQuery(search_query));
	}
	
}
