package com.hydroponics.management.system.controllers;

import java.util.List;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
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
	
	
	
	
	//update land location
	@GetMapping("/location/update/{id}")
	public String updateLocationPage(@PathVariable("id")Long id, Model model) {
		Location locationById = locationService.getLocationById(id);
		if(locationById == null) {
			return "404";
		}
		
		LocationDTO locationDTO = modelMapper.map(locationById, LocationDTO.class);
		locationDTO.setIsAvailable(locationById.isAvailable());
		
		model.addAttribute("locationDTO", locationDTO );
		
		return "locationDirectory/update-location";
	}
	
	
	//updating location
	@PreAuthorized(roles = {"admin", "owner"})
	@PostMapping("/location/update/{id}")
	public String updateLocation(@PathVariable("id")Long id, @Valid @ModelAttribute LocationDTO locationDTO, BindingResult bindingResult, Model model, RedirectAttributes redirectAttributes) {
		
		if(locationDTO.getIsAvailable() == null) {
			locationDTO.setIsAvailable(false);		
		}
		
		if(bindingResult.hasErrors()) {		
			model.addAttribute("inputErrors", bindingResult);
			model.addAttribute("locationDTO", locationDTO);
			return "add-location";
		}
		
		Location location = modelMapper.map(locationDTO, Location.class);
		location.setId(id);
		Location updateLocation = locationService.updateLocation(location);

		
		if (updateLocation == null) {
	        redirectAttributes.addFlashAttribute("serverMessage", new ServerMessage("Failed to Update location", "error", "alert-danger"));
	    } else {
	        redirectAttributes.addFlashAttribute("serverMessage", new ServerMessage("Successfully Updated location", "success", "alert-success"));
	        redirectAttributes.addFlashAttribute("locationDTO", null);
	    }
				
		return "redirect:/location/update/"+id;
	}
	
	
	
	//finding location page
	@GetMapping("/location/search")
	public String findLocationPage() {
		return "locationDirectory/find-locations";
	}
	
	
	@PostMapping("/api/location/search")
    public ResponseEntity<?> searchLocations(
            @RequestParam(name = "search_query", required = false, defaultValue = "") String searchQuery,
            @RequestParam(name = "is_available", required = false) Boolean isAvailable) {

        // Call your service method to perform the search
        List<Location> searchResults = locationService.searchLocations(searchQuery, isAvailable);

        // Return the search results as a ResponseEntity
        return ResponseEntity.ok(searchResults);
    }
}

