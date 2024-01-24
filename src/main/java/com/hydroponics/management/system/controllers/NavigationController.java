package com.hydroponics.management.system.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.hydroponics.management.system.annotation.LoginRequired;
import com.hydroponics.management.system.annotation.PreAuthorized;
import com.hydroponics.management.system.payloads.AdminHomePageData;
import com.hydroponics.management.system.servicesImple.HelperServices;
import com.hydroponics.management.system.servicesImple.ReportServices;


@Controller
public class NavigationController {
	
	@Autowired
	private HelperServices helperServices;
	
	@Autowired
	private ReportServices reportServices;
	
	@LoginRequired
	@GetMapping(value = {"/home","/"})
	public String home(Model model) {
		
		//getting the user role
		String role = helperServices.getLoggedUser().getRole();
		
		
		//if the user is admin
		if(role.equalsIgnoreCase("admin") || role.equalsIgnoreCase("owner")) {
			
			AdminHomePageData data = new AdminHomePageData();
			
			data.setActiveEnvironment(reportServices.countActiveEnvironment());
			data.setActiveUsers(reportServices.countActiveUsers());
			data.setTotalLocation(reportServices.countTotalLocation());
			data.setAvailableLocation(reportServices.countAvailableLocation());
			data.setAssignedLocation(reportServices.countAssignedLocation());
			data.setUsersRegisterToday(reportServices.getUsersRegisteredToday());
			
			model.addAttribute("reportData", data);
			
			return "indexAdmin";
		}
		
		return "index";
	}
	
	@GetMapping(value = {"/index2"})
	public String home2() {
		return "index2";
	}
	
	@GetMapping("/login")
	public String loginPage() {
		return "login";
	}
	
	
	
	@GetMapping("/not-found")
	public String notFound() {
		return "404";
	}
	

	@PreAuthorized(role = "ADMIN")
	@GetMapping("/add-location")
	public String addLocation() {
		return "add-location";
	}
	
	
	@GetMapping("/test")
	public String test() {
		return "homeX";
	}
	
}
