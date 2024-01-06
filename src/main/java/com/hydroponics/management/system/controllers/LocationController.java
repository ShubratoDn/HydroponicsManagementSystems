package com.hydroponics.management.system.controllers;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.hydroponics.management.system.DTO.LocationDTO;
import com.hydroponics.management.system.annotation.PreAuthorized;
import com.hydroponics.management.system.entities.Location;
import com.hydroponics.management.system.payloads.ServerMessage;
import com.hydroponics.management.system.services.LocationService;

import jakarta.validation.Valid;

@Controller
public class LocationController {

	@Autowired
	private ModelMapper modelMapper;
	
	@Autowired
	private LocationService locationService;
	
	
	@PreAuthorized(role = "Admin")
	@PostMapping("/add-location")
	public String addLocation(@Valid @ModelAttribute LocationDTO locationDTO, BindingResult bindingResult, Model model, RedirectAttributes redirectAttributes) {
		
		if(locationDTO.getIsAvailable() == null) {
			locationDTO.setIsAvailable(false);		
		}
		
		if(bindingResult.hasErrors()) {
			/*
			 * System.out.println(bindingResult.getErrorCount()); // Iterate through
			 * FieldError instances and print error messages for
			 * (org.springframework.validation.FieldError error :
			 * bindingResult.getFieldErrors()) { System.out.println(error.getField() + ": "
			 * + error.getDefaultMessage()); }
			 * 
			 * 
			 */

//			for(org.springframework.validation.FieldError error :bindingResult.getFieldErrors()) {
//				System.out.println(error.getField() + ": "+ error.getDefaultMessage()); 
//				}
			model.addAttribute("inputErrors", bindingResult);
			model.addAttribute("locationDTO", locationDTO);
			return "add-location";
		}
		
		Location location = modelMapper.map(locationDTO, Location.class);
		Location addLocation = locationService.addLocation(location);
		
		
		if (addLocation == null) {
	        redirectAttributes.addFlashAttribute("serverMessage", new ServerMessage("Failed to add location", "error", "alert-danger"));
	    } else {
	        redirectAttributes.addFlashAttribute("serverMessage", new ServerMessage("Successfully added new location", "success", "alert-success"));
	        redirectAttributes.addFlashAttribute("locationDTO", null);
	    }
				
		return "redirect:/add-location";
	}
	
}
