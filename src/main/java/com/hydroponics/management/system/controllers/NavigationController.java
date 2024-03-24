package com.hydroponics.management.system.controllers;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.hydroponics.management.system.annotation.LoginRequired;
import com.hydroponics.management.system.annotation.PreAuthorized;
import com.hydroponics.management.system.entities.Environment;
import com.hydroponics.management.system.entities.User;
import com.hydroponics.management.system.payloads.AdminHomePageData;
import com.hydroponics.management.system.payloads.EnvAndFieldData;
import com.hydroponics.management.system.payloads.UserHomePageData;
import com.hydroponics.management.system.services.EnvironmentServices;
import com.hydroponics.management.system.services.NotificationServices;
import com.hydroponics.management.system.servicesImple.HelperServices;
import com.hydroponics.management.system.servicesImple.ReportServices;


@Controller
public class NavigationController {
	
	@Autowired
	private HelperServices helperServices;
	
	@Autowired
	private ReportServices reportServices;
	
	@Autowired
	private EnvironmentServices environmentServices;
	
	@Autowired
	private NotificationServices notificationServices;
	
	@LoginRequired
	@GetMapping(value = {"/home","/"})
	public String home(Model model) {
		
		//getting the user role
		String role = helperServices.getLoggedUser().getRole();
		User loggedUser = helperServices.getLoggedUser();
		
		
		//if the user is admin
		if(role.equalsIgnoreCase("admin") || role.equalsIgnoreCase("owner")) {
			
			AdminHomePageData data = new AdminHomePageData();
			
			data.setActiveEnvironment(reportServices.countActiveEnvironment());
			data.setActiveUsers(reportServices.countActiveUsers());
			data.setTotalLocation(reportServices.countTotalLocation());
			data.setAvailableLocation(reportServices.countAvailableLocation());
			data.setAssignedLocation(reportServices.countAssignedLocation());
			data.setUsersRegisterToday(reportServices.getUsersRegisteredToday());
			data.setUserWithMostAddedUser(reportServices.getUserWithMostAddedUsers());
			data.setUsersWithEnvironmentCount(reportServices.getUserEnvironmentCountMap());
			
			model.addAttribute("reportData", data);
			
			return "indexAdmin";
		}else {
			
			List<Environment> allEnvironmentsByUser = environmentServices.getAllEnvironmentsByUser(loggedUser);
			
			UserHomePageData  userHomeData = new UserHomePageData();
			userHomeData.setAllEnvironmentsByUser(allEnvironmentsByUser);
			
			List<EnvAndFieldData> fieldDataMultipleList = new ArrayList<>();
			for(Environment env : allEnvironmentsByUser) {
				EnvAndFieldData lastNFieldDataByEnvironmentAndFieldData = reportServices.getLastNFieldDataByEnvironmentAndFieldData(env, 5);
				fieldDataMultipleList.add(lastNFieldDataByEnvironmentAndFieldData);
			}
			
			userHomeData.setFieldDataMultipleList(fieldDataMultipleList);
			
			userHomeData.setUnreadNotifications(notificationServices.getUnreadNotifications(loggedUser));
			
			model.addAttribute("reportData", userHomeData);
			return "index";
		}
		
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
