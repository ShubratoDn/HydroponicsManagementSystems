package com.hydroponics.management.system.controllers;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.hydroponics.management.system.configs.Constants;
import com.hydroponics.management.system.entities.Environment;
import com.hydroponics.management.system.entities.FieldData;
import com.hydroponics.management.system.entities.Mineral;
import com.hydroponics.management.system.entities.MineralData;
import com.hydroponics.management.system.entities.Notification;
import com.hydroponics.management.system.entities.enums.NotificationStatus;
import com.hydroponics.management.system.entities.enums.NotificationType;
import com.hydroponics.management.system.payloads.EnvFormData;
import com.hydroponics.management.system.payloads.EnvMineralData;
import com.hydroponics.management.system.payloads.ServerMessage;
import com.hydroponics.management.system.services.EnvDataServices;
import com.hydroponics.management.system.services.EnvironmentServices;
import com.hydroponics.management.system.services.NotificationServices;
import com.hydroponics.management.system.servicesImple.HelperServices;

@Controller
public class DataGeneratorController {

	@Autowired
	private EnvironmentServices environmentServices;

	@Autowired
	private EnvDataServices envDataServices;

	@Autowired
	private HelperServices helperServices;

	@Autowired
	private NotificationServices notificationServices;

	@GetMapping(value = { "/generate-data/", "/generate-data" })
	public String generateDataPage(Model model) {
		List<Environment> allEnvironments = environmentServices.getAllEnvironments();
		model.addAttribute("environmentList", allEnvironments);
		return "dataGenerate/generate-data";
	}

	// generating fake data using Form
	@PostMapping("/generate-data/")
	public String uploadData(@ModelAttribute EnvFormData formData, RedirectAttributes attributes) {

		Environment environment = environmentServices.getEnvironmentById(formData.getEnvironmentId());

		List<MineralData> mineralDatas = new ArrayList<>();

		for (EnvMineralData envMineralData : formData.getMinerals()) {
			Mineral mineral = new Mineral();
			mineral.setId(envMineralData.getMineralId());

			MineralData md = new MineralData();
			md.setMineral(mineral);
			md.setMineralValue(envMineralData.getMineralAmount());

			mineralDatas.add(md);
		}

		FieldData fieldData = new FieldData();
		fieldData.setEnvironment(environment);
		fieldData.setHumidity(formData.getHumidity());
		fieldData.setLightDuration(formData.getLightDuration());
		fieldData.setTemperatureC(formData.getTemperatureC());
		fieldData.setWaterPH(formData.getWaterPH());
		fieldData.setMineralDataList(mineralDatas);

		FieldData saveData = envDataServices.saveData(fieldData);
		
		if (saveData != null) {
			attributes.addFlashAttribute("serverMessage", new ServerMessage(
					"Added data for environment ENV_" + saveData.getEnvironment().getId(), "success", "alert-success"));
		} else {
			attributes.addFlashAttribute("serverMessage",
					new ServerMessage("Error! Demo data added failed.", "error", "alert-danger"));
		}
		
		
		//validating and notifying if there is any error in field data
		envDataServices.validateLastFieldDataAndNotify(saveData);
				
		return "redirect:/generate-data"; // Adjust success page as per your project
	}
	
	

	// generating Random fake data (JSON)
	@GetMapping("/api/generate-data/random/environment/{envId}")
	public ResponseEntity<?> generateEnvironmentFakedata(@PathVariable Long envId) {
		int percent = Constants.RANDOM_GENERATE_DIFFERENCE_PERCENT;
		Environment environment = environmentServices.getEnvironmentById(envId);
		if (environment == null) {
			return new ResponseEntity<>("Environment Not FOUND", HttpStatus.OK);
		}

		FieldData fieldData = new FieldData();
		fieldData.setEnvironment(environment);
		fieldData.setLightDuration(environment.getLightDuration());
		fieldData.setWaterPH(helperServices.generateRandomValue(environment.getWaterPH(), percent, percent));
		fieldData.setTemperatureC(helperServices.generateRandomValue(environment.getTemperatureC(), percent, percent));
		fieldData.setHumidity(helperServices.generateRandomValue(environment.getHumidity(), percent, percent));

		// creating mineral Data list
		List<MineralData> mineralDataList = new ArrayList<>();
		for (Mineral mineral : environment.getMinerals()) {
			MineralData mineralData = new MineralData();
			mineralData.setFieldData(fieldData);
			mineralData.setMineral(mineral);
			mineralData.setMineralValue(helperServices.generateRandomValue(mineral.getMineralAmount(), percent, percent));
			mineralDataList.add(mineralData);
		}

		fieldData.setMineralDataList(mineralDataList);

		FieldData saveData = envDataServices.saveData(fieldData);
		
		//validating and notifying if there is any error in field data
		envDataServices.validateLastFieldDataAndNotify(saveData);
		
		return ResponseEntity.ok(saveData);
	}
	
	
	
	
	//generate random data for environment Page
	@GetMapping("/generate-data/random/environment")
	public String generateRandomDataPage(Model model) {		
		List<Environment> allEnvironments = environmentServices.getAllEnvironments();
		model.addAttribute("environmentList", allEnvironments);		
		return "dataGenerate/generate-random-data";
	}

	//generate random data for environment
	@PostMapping("/generate-data/random/environment")
	public String generateRandomData(
			@RequestParam(name = "environmentId", required = true) Long environmentId,
			@RequestParam(name = "count", required = false, defaultValue = "1") Integer count,
			@RequestParam(name = "percent", required = false, defaultValue = ""+Constants.MINERAL_ALLOWENCE_PERCENT) double percentDouble,
			RedirectAttributes redirectAttributes) {
		int percent = (int) percentDouble;
		Environment environment = environmentServices.getEnvironmentById(environmentId);
		if (environment == null) {
			redirectAttributes.addFlashAttribute("serverMessage", new ServerMessage("Environment not found!!", "error", "alert-danger"));
			return "redirect:/generate-data/random/environment";
		}
		
		
		for(int i = 0; i<=count; i++) {
			FieldData fieldData = new FieldData();
			fieldData.setEnvironment(environment);
			fieldData.setLightDuration(environment.getLightDuration());
			fieldData.setWaterPH(helperServices.generateRandomValue(environment.getWaterPH(), percent, percent));
			fieldData.setTemperatureC(helperServices.generateRandomValue(environment.getTemperatureC(), percent, percent));
			fieldData.setHumidity(helperServices.generateRandomValue(environment.getHumidity(), percent, percent));

			// creating mineral Data list
			List<MineralData> mineralDataList = new ArrayList<>();
			for (Mineral mineral : environment.getMinerals()) {
				MineralData mineralData = new MineralData();
				mineralData.setFieldData(fieldData);
				mineralData.setMineral(mineral);
				mineralData.setMineralValue(helperServices.generateRandomValue(mineral.getMineralAmount(), percent, percent));
				mineralDataList.add(mineralData);
			}

			fieldData.setMineralDataList(mineralDataList);

			FieldData saveData = envDataServices.saveData(fieldData);
			
			//validating and notifying if there is any error in field data
			envDataServices.validateLastFieldDataAndNotify(saveData);
		}
		
		
		
		
		redirectAttributes.addFlashAttribute("serverMessage", new ServerMessage("Generated value "+count+" times with the variance of "+percent+"% for the Environment ENV_"+environmentId, "success", "alert-success"));
		return "redirect:/generate-data/random/environment";
	}
	
	
	

	// get all fields data
	@GetMapping("/data/getFieldsData")
	public ResponseEntity<?> getFieldsData() {
		List<FieldData> allFieldsData = envDataServices.getAllFieldsData();
		return ResponseEntity.ok(allFieldsData);
	}

	
	
	//MAYBE USE HOCCHENA ETA
	// get all fields data for a Specific Environment
	@GetMapping("/data/getFieldsData/env/{envId}")
	public ResponseEntity<?> getFieldsDataByEnvironment(@PathVariable Long envId) {
		Environment environment = environmentServices.getEnvironmentById(envId);
		if (environment == null) {
			return ResponseEntity.ok("ENVIRONMENT NOT FOUND");
		}

//  		List<FieldData> fieldDataByEnvironment = envDataServices.getFieldDataByEnvironment(environment);

		/// for a single Environment
		List<FieldData> fieldDataList = envDataServices.getFieldDataByEnvironmentAfterGivenHour(environment,
				Constants.NOTIFICATION_TIME_INTERVAL_HOUR);

		for (FieldData fieldData : fieldDataList) {

			checkAndNotifyError(fieldData.getHumidity(), environment.getHumidity(), "humidity",
					NotificationType.INVALID_HUMIDITY_ERROR, environment);
			checkAndNotifyError(fieldData.getWaterPH(), environment.getWaterPH(), "water pH",
					NotificationType.INVALID_WATER_pH_ERROR, environment);
			checkAndNotifyError(fieldData.getTemperatureC(), environment.getTemperatureC(), "temperature",
					NotificationType.INVALID_TEMPERATURE_ERROR, environment);

//  		    if (!helperServices.isValidFieldData(fieldData.getHumidity(), environment.getHumidity(), 4)) {
//  		    	String msg = "Error in humidity for Environment "+environment.getId()+". Actual value is: " + fieldData.getHumidity() +
//  		                " The value should be within " + helperServices.givenPercentIncrease(fieldData.getHumidity(), 4) +
//  		                " and " + helperServices.givenPercentDecrease(fieldData.getHumidity(), 4);
//  		        System.out.println(msg);
//  		        Notification notification = new Notification();
//  		        notification.setNotificationType(NotificationType.INVALID_HUMIDITY_ERROR);
//  		        notification.setMessage(msg);
//  		        notification.setReceiver(environment.getOwnedBy());
//  		        notification.setSender(null);
//  		        notification.setStatus(NotificationStatus.UNREAD);
//  		        
//  		        Notification sendNotification = notificationServices.sendNotificationAfterVerify(notification, Constants.NOTIFICATION_CHECK_DIFFERENCE_TIME_HOUR);
//  		        if(sendNotification != null) {
//  		        	System.out.println("SAVED IN DATABASE");
//  		        }else{
//  		        	System.out.println("FAILED to SAVED IN DATABASE");
//  		        }
//  		        
//  		    }
//
//
//  		    if (!helperServices.isValidFieldData(fieldData.getWaterPH(), environment.getWaterPH(), 4)) {
//  		        System.out.println("Error in water pH. Actual value is: " + fieldData.getWaterPH() +
//  		                " The value should be within " + helperServices.givenPercentIncrease(fieldData.getWaterPH(), 4) +
//  		                " and " + helperServices.givenPercentDecrease(fieldData.getWaterPH(), 4));
//  		    }
//
//  		    if (!helperServices.isValidFieldData(fieldData.getTemperatureC(), environment.getTemperatureC(), 4)) {
//  		        System.out.println("Error in temperature. Actual value is: " + fieldData.getTemperatureC() +
//  		                " The value should be within " + helperServices.givenPercentIncrease(fieldData.getTemperatureC(), 4) +
//  		                " and " + helperServices.givenPercentDecrease(fieldData.getTemperatureC(), 4));
//  		    }
			
			for (MineralData mineralData : fieldData.getMineralDataList()) {
		        checkAndNotifyError(mineralData.getMineralValue(), mineralData.getMineral().getMineralAmount(), mineralData.getMineral().getMineralName(), NotificationType.INVALID_MINERAL_ERROR, environment);
		    }

//			for (MineralData mineralData : fieldData.getMineralDataList()) {
//				if (!helperServices.isValidFieldData(mineralData.getMineralValue(),
//						mineralData.getMineral().getMineralAmount(), 4)) {
//					System.out.println("Error in mineral" + mineralData.getMineral().getMineralName()
//							+ ". Actual value is: " + mineralData.getMineralValue() + " The value should be within "
//							+ helperServices.givenPercentIncrease(mineralData.getMineral().getMineralAmount(), 4)
//							+ " and "
//							+ helperServices.givenPercentDecrease(mineralData.getMineral().getMineralAmount(), 4));
//				}
//			}

		}

		return ResponseEntity.ok(fieldDataList);
	}

	//MAYBE USE HOCCHENA ETA
	private void checkAndNotifyError(double actualValue, double expectedValue, String fieldName, NotificationType notificationType, Environment environment) {
  	    if (!helperServices.isValidFieldData(actualValue, expectedValue, 4)) {
  	        String msg = "Error in " + fieldName + ". Actual value is: " + actualValue +
  	                " The value should be within " + helperServices.givenPercentIncrease(actualValue, 4) +
  	                " and " + helperServices.givenPercentDecrease(actualValue, 4);
//  	        System.out.println(msg);

  	        Notification notification = new Notification();
  	        notification.setNotificationType(notificationType);
  	        notification.setEnvironment(environment);
  	        notification.setMessage(msg);
  	        notification.setReceiver(environment.getOwnedBy());
  	        notification.setSender(null);
  	        notification.setStatus(NotificationStatus.UNREAD);

  	        Notification sendNotification = notificationServices.sendNotificationAfterVerify(notification, Constants.NOTIFICATION_TIME_INTERVAL_HOUR);
  	        if (sendNotification != null) {
  	            System.out.println("SAVED IN DATABASE");
  	        } else {
  	            System.out.println("FAILED to SAVED IN DATABASE");
  	        }
  	    }
	}

		


}
