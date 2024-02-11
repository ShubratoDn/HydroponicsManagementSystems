package com.hydroponics.management.system.controllers;

import java.util.List;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

import com.hydroponics.management.system.DTO.UserDTO;
import com.hydroponics.management.system.annotation.LoginRequired;
import com.hydroponics.management.system.annotation.PreAuthorized;
import com.hydroponics.management.system.entities.Environment;
import com.hydroponics.management.system.entities.User;
import com.hydroponics.management.system.services.EnvironmentServices;
import com.hydroponics.management.system.services.UserServices;
import com.hydroponics.management.system.servicesImple.HelperServices;

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

}
