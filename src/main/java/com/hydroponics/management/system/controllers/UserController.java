package com.hydroponics.management.system.controllers;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import com.hydroponics.management.system.DTO.UserDTO;
import com.hydroponics.management.system.annotation.LoginRequired;
import com.hydroponics.management.system.entities.User;
import com.hydroponics.management.system.services.UserServices;

@Controller
public class UserController {

	@Autowired
	private UserServices userServices;
	
	@Autowired
	private ModelMapper modelMapper;
	
	@LoginRequired
	@GetMapping("/user/{id}")
	public String profilePage(@PathVariable int id, Model model) {
		UserDTO userById = userServices.getUserById(id);
		User user = null;
//		if(userById != null) {
//			user = modelMapper.map(user, User.class);
//		}else {
//			return "404";
//		}
		
		model.addAttribute("user",userById);
		
		return "userDirectory/profile";
	}
	
}
