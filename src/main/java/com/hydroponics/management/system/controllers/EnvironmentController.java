package com.hydroponics.management.system.controllers;

import java.sql.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.hydroponics.management.system.DTO.EnvironmentDTO;
import com.hydroponics.management.system.DTO.UserDTO;
import com.hydroponics.management.system.annotation.PreAuthorized;
import com.hydroponics.management.system.entities.Environment;
import com.hydroponics.management.system.entities.Mineral;
import com.hydroponics.management.system.payloads.ServerMessage;
import com.hydroponics.management.system.services.EnvironmentServices;
import com.hydroponics.management.system.services.LocationService;
import com.hydroponics.management.system.services.UserServices;

import jakarta.validation.Valid;

@Controller
public class EnvironmentController {

	@Autowired
	private UserServices userServices;

	@Autowired
	private LocationService locationService;
	
	@Autowired
	private EnvironmentServices environmentServices;
	
	
	//get environment page
	@PreAuthorized(role = "admin")
	@GetMapping("/add-environment")
	public String getEnvironmentPage(Model model) {
		model.addAttribute("userList", userServices.getAllUser());
		model.addAttribute("locationList", locationService.getAllUnusedLocation());
		return "add-environment";
	}

//	add Environment	
	@PreAuthorized(role = "admin")
	@PostMapping("/add-environment")
	public String uploadEnvironment(@Valid @ModelAttribute EnvironmentDTO environment, BindingResult bindingResult,
			RedirectAttributes redirectAttributes) {
		
		redirectAttributes.addFlashAttribute("environmentDTO", environment);

		if (environment.getOwnedBy() != null) {
			UserDTO userById = userServices.getUserById(environment.getOwnedBy().getId());
			if (userById == null) {
				bindingResult.addError(new FieldError("environment", "ownedBy", "Select a valid user from the list."));
			} 
		}
		
		//removing minerals if they are empty
		environment.getMinerals().removeIf(mineral -> mineral.getMineralAmount()==null || mineral.getMineralName()== null ||mineral.getMineralUnit()== null);
		
		if (bindingResult.hasErrors()) {
			redirectAttributes.addFlashAttribute("inputErrors", bindingResult);			
			return "redirect:/add-environment";
		}

		
		Environment addEnvironment = environmentServices.addEnvironment(environment);
		
		if (addEnvironment == null) {
	        redirectAttributes.addFlashAttribute("serverMessage", new ServerMessage("Failed to set new Environment!", "error", "alert-danger"));
	    } else {
	        redirectAttributes.addFlashAttribute("serverMessage", new ServerMessage("Successfully added new Environment", "success", "alert-success"));
	        redirectAttributes.addFlashAttribute("environmentDTO", null);
	    }
		
		return "redirect:/add-environment";
	}
	
	
	@PreAuthorized(roles = { "Admin", "user"})
	@GetMapping("/find-environments")
	public String searchEnv(Model model) {	    
		return "find-environments";
	}
	
	
	@PostMapping("/find-environments")
    public String searchEnvironments(
            @RequestParam(required = false) Long environmentId,
            @RequestParam(required = false) String plantName,
            @RequestParam(required = false) Integer ownedByUserId,
            @RequestParam(required = false) String ownedByUserFirstName,
            @RequestParam(required = false) String ownedByUserPhone,
            @RequestParam(required = false) String ownedByUserEmail,
            @RequestParam(required = false) Long locationId,
            @RequestParam(required = false) String locationName,
            @RequestParam(required = false) String locationAddress,
            @RequestParam(required = false) Boolean locationAvailable,
            @RequestParam(required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") Date plantDate,
            @RequestParam(required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") Date maturityDate,
            @RequestParam(required = false) Integer lightDuration,
            @RequestParam(required = false) Double waterPH,
            @RequestParam(required = false) Double temperatureC,
            @RequestParam(required = false) Double humidity,
            @RequestParam(required = false) Integer addedByUserId,
            @RequestParam(required = false) String addedByUserFirstName,
            @RequestParam(required = false) String addedByUserPhone,
            @RequestParam(required = false) String addedByUserEmail,
            @RequestParam(required = false) String addedByUserRole,
            Model model,
            RedirectAttributes redirectAttributes
    ) {
        
		List<Environment> searchResult = environmentServices.searchEnvironments(environmentId, plantName, ownedByUserId, ownedByUserFirstName, ownedByUserPhone, ownedByUserEmail, locationId, locationName, locationAddress, locationAvailable, plantDate, maturityDate, lightDuration, waterPH, temperatureC, humidity, addedByUserId, addedByUserFirstName, addedByUserPhone, addedByUserEmail, addedByUserRole);		
		redirectAttributes.addFlashAttribute("searchResult", searchResult);
	    return "redirect:/find-environments";
    }

	
	
	
	
	
	
	//get environment by id
	@GetMapping("/environment/get/{id}")
	public ResponseEntity<?> getEnvironment(@PathVariable Long id){
		Environment environmentById = environmentServices.getEnvironmentById(id);
		return ResponseEntity.ok(environmentById);
	}
	
	
	@GetMapping("/environment/get-minerals/{id}")
	public ResponseEntity<?> getMineralsOfEnvironment(@PathVariable Long id){
		List<Mineral> mineralsOfEnvironment = environmentServices.getMineralsOfEnvironment(id);
		return ResponseEntity.ok(mineralsOfEnvironment);
	}
	
}
