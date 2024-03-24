package com.hydroponics.management.system.controllers;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpRequest;
import org.springframework.http.HttpStatus;
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
import com.hydroponics.management.system.annotation.LoginRequired;
import com.hydroponics.management.system.annotation.PreAuthorized;
import com.hydroponics.management.system.entities.Environment;
import com.hydroponics.management.system.entities.Mineral;
import com.hydroponics.management.system.entities.User;
import com.hydroponics.management.system.payloads.EnvAndFieldData;
import com.hydroponics.management.system.payloads.PageableResponse;
import com.hydroponics.management.system.payloads.ServerMessage;
import com.hydroponics.management.system.services.EnvironmentServices;
import com.hydroponics.management.system.services.LocationService;
import com.hydroponics.management.system.services.NotificationServices;
import com.hydroponics.management.system.services.SmsServices;
import com.hydroponics.management.system.services.UserServices;
import com.hydroponics.management.system.servicesImple.HelperServices;
import com.hydroponics.management.system.servicesImple.ReportServices;

import jakarta.validation.Valid;

@Controller
public class EnvironmentController {

	@Autowired
	private UserServices userServices;

	@Autowired
	private LocationService locationService;
	
	@Autowired
	private EnvironmentServices environmentServices;
	
	@Autowired
	private NotificationServices notificationServices;
	
	@Autowired
	private HelperServices helperServices;
	
	@Autowired
	private ReportServices reportServices;
	
	@Autowired
	private ModelMapper modelMapper;
	
	@Autowired
	private SmsServices smsServices;
	
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
	        notificationServices.sendEnvWelcomeNotification(addEnvironment);
	        //sending sms
	        smsServices.sendSms(addEnvironment.getOwnedBy().getPhone(), "Welcome "+addEnvironment.getOwnedBy().getFirstName()+"! Planting "+addEnvironment.getPlantName()+" at "+addEnvironment.getLocation().getFullAddress()+". Get ready for growth and green goodness! Happy Growing!");	        
	    }
		
		return "redirect:/add-environment";
	}
	
	
//	@PreAuthorized(roles = { "Admin", "user"})
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
//            @RequestParam(required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") Date plantDate,
//            @RequestParam(required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") Date maturityDate,
            @RequestParam(required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") String plantDate,
            @RequestParam(required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") String maturityDate,
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
		
		Date plantDateFormatted = null;
		Date maturityDateFormatted = null;
		
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        try {
        	if(plantDate != null) {
        		plantDateFormatted = (Date) dateFormat.parse(plantDate);        		
        	}
        	if(maturityDate != null) {
        		maturityDateFormatted = (Date) dateFormat.parse(maturityDate);        		
        	}
        } catch (Exception e) {
//            e.printStackTrace();
            
        }
		
		
        List<Environment> searchResult = environmentServices.searchEnvironments(environmentId, plantName, ownedByUserId, ownedByUserFirstName, ownedByUserPhone, ownedByUserEmail, locationId, locationName, locationAddress, locationAvailable, plantDateFormatted, maturityDateFormatted, lightDuration, waterPH, temperatureC, humidity, addedByUserId, addedByUserFirstName, addedByUserPhone, addedByUserEmail, addedByUserRole);
		
//		List<Environment> searchResult =  new ArrayList<>();
		redirectAttributes.addFlashAttribute("searchResult", searchResult);
	    return "redirect:/find-environments";
    }
	
	
	
	
	//get environment by id
	@GetMapping("/environment/get/{id}")
	public ResponseEntity<?> getEnvironment(@PathVariable Long id){
		Environment environmentById = environmentServices.getEnvironmentById(id);
		return ResponseEntity.ok(environmentById);
	}
	
	@GetMapping("/environment/fake-data/{id}")
	public ResponseEntity<?> getEnvironmentForFakeData(@PathVariable Long id){
		Environment environmentById = environmentServices.getEnvironmentById(id);
		environmentById.setOwnedBy(null);
		environmentById.setAddedEnvironmentBy(null);		
		return ResponseEntity.ok(environmentById);
	}
	
	
	@GetMapping("/environment/get-minerals/{id}")
	public ResponseEntity<?> getMineralsOfEnvironment(@PathVariable Long id){
		List<Mineral> mineralsOfEnvironment = environmentServices.getMineralsOfEnvironment(id);
		return ResponseEntity.ok(mineralsOfEnvironment);
	}
	
	
	@PreAuthorized(roles = {"admin", "owner"})
	@GetMapping("/environment/delete/{id}")
	public String deleteEnvironment(@RequestParam(name = "url", required = false, defaultValue = "/") String url, @PathVariable Long id, RedirectAttributes redirectAttributes){
		environmentServices.deleteEnvironment(id);
		redirectAttributes.addFlashAttribute("serverMessage", new ServerMessage("Success! Environment deleted with ID : ENV_"+id, "success", "alert-success"));
		return "redirect:"+url;
	}
	
	
	@PostMapping("/api/environments/by-user/{id}")
	public ResponseEntity<?> getUsersEnvironment(@PathVariable int id){
		UserDTO userById = userServices.getUserById(id);
		if(userById == null) {
			return new ResponseEntity<>("User not found",HttpStatus.NOT_FOUND);
		}
		
		User user = new User();
		user.setId(userById.getId());
		
		List<Environment> allEnvironmentsByUser = environmentServices.getAllEnvironmentsByUser(user);
		
		return ResponseEntity.ok(allEnvironmentsByUser);
	}
	
	
	
	@LoginRequired
	@GetMapping("/my-environments")
	public String myEnvironmentsPage(
			@RequestParam(value = "page", defaultValue = "1", required = false) int page,
			@RequestParam(value = "size", defaultValue = "5", required = false) int size,
			@RequestParam(value = "sortBy", defaultValue = "id", required = false) String sortBy,
			@RequestParam(value = "sortDirection", defaultValue = "desc", required = false) String sortDirection,
			Model model) {
		
		if(page != 0) {
			page = page - 1;			
		}
		
		
		User loggedUser = helperServices.getLoggedUser();
		PageableResponse allEnvironmentsByUser = environmentServices.getAllEnvironmentsByUser(loggedUser, page, size, sortBy, sortDirection);
		
		model.addAttribute("environmentList", allEnvironmentsByUser);
		return "environmentDirectory/my-environments";
	}
	
	
	@LoginRequired
	@GetMapping("/environment/{envId}")
	public String environment (@PathVariable Long envId, Model model) {
		
		User loggedUser = helperServices.getLoggedUser();
		
		Environment env = null;
		
		if(loggedUser.getRole().equals("owner") || loggedUser.getRole().equalsIgnoreCase("admin")) {
			env = environmentServices.getEnvironmentById(envId);
		}else {
			env = environmentServices.getEnvironmentByIdAndOwnedBy(envId, loggedUser);
		}
		
		if(env == null) {
			return "404";
		}
		
		EnvAndFieldData envFieldData = reportServices.getLastNFieldDataByEnvironmentAndFieldData(env, 10);
		
		model.addAttribute("environment", env);
		model.addAttribute("envFieldData", envFieldData);
		
		return "environmentDirectory/environment";
	}
	
	
	
	//all environments
	@PreAuthorized(roles = { "Admin", "owner"})
	@GetMapping("/all-environments")
	public String allEnvironmentPage(
			@RequestParam(value = "page", defaultValue = "0", required = false) int page,
			@RequestParam(value = "size", defaultValue = "10", required = false) int size,
			@RequestParam(value = "sortBy", defaultValue = "id", required = false) String sortBy,
			@RequestParam(value = "sortDirection", defaultValue = "desc", required = false) String sortDirection,
			Model model) {
		
		PageableResponse allEnvironmentsPageable = environmentServices.getAllEnvironmentsPageable(page, size, sortBy, sortDirection);
				
		model.addAttribute("envPageList", allEnvironmentsPageable);
		
		return "environmentDirectory/all-environments";
	}
	
	
	
	
	
	//update environment page
	@PreAuthorized(roles = {"admin", "owner"})
	@GetMapping("/environment/update")
	public String updatePage(Model model) {
		Object attribute = model.getAttribute("environmentDTO");
		if(attribute == null) {
			return "404";
		}
		
		return "environmentDirectory/update-environment";
	}
	
	@PreAuthorized(roles = {"admin", "owner"})
	@GetMapping("/environment/update/{environmentId}")
	public String updatePageFirst(@PathVariable(name = "environmentId") Long environmentId,Model model, RedirectAttributes redirectAttributes) {
		Environment environment = environmentServices.getEnvironmentById(environmentId);		
		if(environment == null) {
			return "404";
		}
		
		redirectAttributes.addFlashAttribute("userList", userServices.getAllUser());
		redirectAttributes.addFlashAttribute("locationList", locationService.getEnvironmentLocationAndAllUnusedLocation(environment));
		redirectAttributes.addFlashAttribute("environmentDTO", modelMapper.map(environment, EnvironmentDTO.class));
		
		ServerMessage serverMessage = (ServerMessage) model.getAttribute("serverMessage");
		BindingResult bindingResult = (BindingResult) model.getAttribute("inputErrors");
		if(serverMessage != null) {
			redirectAttributes.addFlashAttribute("serverMessage", serverMessage);
		}
		
		if(bindingResult != null) {
			redirectAttributes.addFlashAttribute("inputErrors", bindingResult);	
		}
		
		return "redirect:/environment/update";
		
	}
	
	
	
	@PostMapping("/update-environment/{envId}")
	public String updateEnvironment(@PathVariable("envId") Long envId, @Valid @ModelAttribute EnvironmentDTO environment, BindingResult bindingResult, RedirectAttributes redirectAttributes) {
		
		Environment environmentById = environmentServices.getEnvironmentById(envId);
		if(environmentById == null) {
			redirectAttributes.addFlashAttribute("serverMessage", new ServerMessage("Failed to Update Environment! Environment Invalid", "error", "alert-danger"));
		}else {
			environment.setId(envId);
		}
		
		//setting the environment ID
		environment.setId(envId);
		
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
			return "redirect:/environment/update/"+envId;
		}

		
		Environment addEnvironment = environmentServices.updateEnvironment(environment);
		
		if (addEnvironment == null) {
	        redirectAttributes.addFlashAttribute("serverMessage", new ServerMessage("Failed to Update new Environment!", "error", "alert-danger"));	        
	    } else {
	        redirectAttributes.addFlashAttribute("serverMessage", new ServerMessage("Envrionment \"ENV_"+envId+"\" updated successfull!", "success", "alert-success"));	        
	        //notificationServices.sendEnvWelcomeNotification(addEnvironment);
	    }
		
		
		return "redirect:/environment/update/"+envId;
	}
	//update Environment Ends
	
	
}
