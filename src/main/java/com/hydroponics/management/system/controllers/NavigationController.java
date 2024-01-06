package com.hydroponics.management.system.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com.hydroponics.management.system.annotation.LoginRequired;
import com.hydroponics.management.system.annotation.PreAuthorized;


@Controller
public class NavigationController {
	
	@LoginRequired
	@GetMapping(value = {"/home","/"})
	public String home() {
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
