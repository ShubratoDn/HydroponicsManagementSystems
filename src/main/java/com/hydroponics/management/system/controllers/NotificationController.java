package com.hydroponics.management.system.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.hydroponics.management.system.DTO.UserDTO;
import com.hydroponics.management.system.annotation.LoginRequired;
import com.hydroponics.management.system.annotation.PreAuthorized;
import com.hydroponics.management.system.configs.Constants;
import com.hydroponics.management.system.entities.Environment;
import com.hydroponics.management.system.entities.FieldData;
import com.hydroponics.management.system.entities.MineralData;
import com.hydroponics.management.system.entities.Notification;
import com.hydroponics.management.system.entities.User;
import com.hydroponics.management.system.entities.enums.NotificationStatus;
import com.hydroponics.management.system.entities.enums.NotificationType;
import com.hydroponics.management.system.payloads.NotificationForm;
import com.hydroponics.management.system.payloads.PageableResponse;
import com.hydroponics.management.system.payloads.ServerMessage;
import com.hydroponics.management.system.services.EnvDataServices;
import com.hydroponics.management.system.services.EnvironmentServices;
import com.hydroponics.management.system.services.NotificationServices;
import com.hydroponics.management.system.services.UserServices;
import com.hydroponics.management.system.servicesImple.HelperServices;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class NotificationController {
	

	@Autowired
	private EnvironmentServices environmentServices;

	@Autowired
	private EnvDataServices envDataServices;

	@Autowired
	private HelperServices helperServices;

	@Autowired
	private NotificationServices notificationServices;
	
	@Autowired
	private SimpMessagingTemplate simpMessagingTemplate;
	
	@Autowired
	private UserServices userServices;	
	
	
	@PreAuthorized(roles = {"admin", "owner"})
	@GetMapping("/send-notification")
	public String sendNotificationPage(Model model) {
		
		List<UserDTO> allUser = userServices.getAllUser();
		
		
		model.addAttribute("userList", allUser);		
		return "notificationDirectory/send-notification";
	}
	
	
	@PreAuthorized(roles = {"admin", "owner"})
	@PostMapping("/send-notification")
	public String sendNotification(@ModelAttribute NotificationForm notificationForm,
			BindingResult bindingResult, RedirectAttributes redirectAttributes) {

		Integer userId = notificationForm.getReceiverId();
		Integer envId = notificationForm.getEnvironmentId();
		
		User receiver = null;
		Environment environment = null;
		NotificationType notificationType = null;
		String message = "";
		
		//receiver validation
		if (userId == null) {
			bindingResult.rejectValue("receiverId", "NotEmpty", "Receiver user id cannot be empty");
		}else {
			UserDTO userById = userServices.getUserById(userId);
			if(userById == null) {
				bindingResult.rejectValue("receiverId", "NotFound", "Receiver Not found");	
			}else {
				receiver = new User();
				receiver.setId(userById.getId());
			}
		}

		
		//environment validation
		if (envId != null) {
			Environment environmentById = environmentServices.getEnvironmentById(envId.longValue());
			if(environmentById == null) {
				bindingResult.rejectValue("environmentId", "NotFound", "Environment Not found");
			}else {
				environment = environmentById;
			}
		}
		
		
		
		//notification type validation
	    if (notificationForm.getNotificationType() == null) {
	        bindingResult.rejectValue("notificationType", "NotNull", "Notification Type cannot be null");
	    }else {
	    	notificationType = notificationForm.getNotificationType();
	    }
		
	    
	    //message validation
	    if(notificationForm.getMessage() == null || notificationForm.getMessage().length() < 7) {
	    	bindingResult.rejectValue("message", "Invalid", "Please write a valid message");
	    }else {
	    	message = notificationForm.getMessage();
	    }
	    
	    
	    
	    System.out.println(notificationForm);
	    
	    if(bindingResult.hasErrors()) {			
			redirectAttributes.addFlashAttribute("inputErrors", bindingResult);
			return "redirect:/send-notification";
		}

	    
	    Notification notification = new Notification();
	    notification.setEnvironment(environment);
	    notification.setReceiver(receiver);
	    notification.setStatus(NotificationStatus.UNREAD);
	    notification.setNotificationType(notificationType);	    
	    notification.setMessage(message);
	    notification.setSender(helperServices.getLoggedUser());
	    
	    Notification sendNotificationAndNotify = notificationServices.sendNotificationAndNotify(notification);
	    if(sendNotificationAndNotify == null) {
	    	redirectAttributes.addFlashAttribute("serverMessage", new ServerMessage("Failed to sent notification!!", "error", "alert-danger"));
	    }else {	    	
	    	redirectAttributes.addFlashAttribute("serverMessage", new ServerMessage("Notification sent successfully", "success", "alert-success"));
	    }
	    
	    redirectAttributes.addFlashAttribute("inputErrors", null);
		return "redirect:/send-notification";

	    
	}
	
	
	@LoginRequired
	@GetMapping("/my-notifications")
	public String myNotifications(Model model) {
		User loggedUser = helperServices.getLoggedUser();
		
		PageableResponse myNotifications = notificationServices.getMyNotifications(loggedUser, 0, 5, "id", "desc");
		
		model.addAttribute("pageableNotifications", myNotifications);
		
		return "notificationDirectory/notifications";
	}
	
	
	//get my notification in JSON format
	@LoginRequired
	@GetMapping("/api/my-notifications/")
	public ResponseEntity<?> getMyNotifications(
			@RequestParam(value = "page", defaultValue = "0", required = false) int page,
			@RequestParam(value = "size", defaultValue = "10", required = false) int size,
			@RequestParam(value = "sortBy", defaultValue = "id", required = false) String sortBy,
			@RequestParam(value = "sortDirection", defaultValue = "desc", required = false) String sortDirection
			){

		User loggedUser = helperServices.getLoggedUser();
		if(loggedUser == null) {
			return ResponseEntity.badRequest().body("YOU ARE NOT LOGGED IN");	
		}		
		
		PageableResponse myNotifications = notificationServices.getMyNotifications(loggedUser, page, size, sortBy, sortDirection);

		return ResponseEntity.ok(myNotifications);
	}
			
	
	//unread message
	@PutMapping("/api/notification/{id}/unread")
	public ResponseEntity<?> unreadMessage(@PathVariable Long id){	
		notificationServices.unreadNotification(id);
		return ResponseEntity.ok(null);
	}
	
	
	
	private void checkAndNotifyError(double actualValue, double expectedValue, String fieldName,
            NotificationType notificationType, Environment environment) {
        if (!helperServices.isValidFieldData(actualValue, expectedValue, 4)) {
            String errorMsg = "Error in " + fieldName + ". Actual value is: " + actualValue +
                    ". It should be within the range of " + helperServices.givenPercentDecrease(actualValue, 4) +
                    " to " + helperServices.givenPercentIncrease(actualValue, 4) + ".";
            log.error(errorMsg);

            Notification notification = new Notification();
            notification.setNotificationType(notificationType);
            notification.setEnvironment(environment);
            notification.setMessage(errorMsg);
            notification.setReceiver(environment.getOwnedBy());
            notification.setSender(null);
            notification.setStatus(NotificationStatus.UNREAD);

            Notification sendNotification = notificationServices.sendNotificationAfterVerify(notification, Constants.NOTIFICATION_TIME_INTERVAL_HOUR);
            if (sendNotification != null) {
            	simpMessagingTemplate.convertAndSend("/specific/notification/" + sendNotification.getReceiver().getId(), sendNotification);
                log.info("Notification: {} saved in the database.", notificationType);
            } else {
                log.error("Failed to save Notification: {} in the database.", notificationType);
            }
        }
    }
	
	//automatically notification upload to the database
	@Scheduled(fixedRate = 1000 * 60 * Constants.NOTIFICATION_SCHEDULE_INTERVAL_MIN)
	public void notificationProgress() {		
		List<Environment> allEnvironments = environmentServices.getAllEnvironments();
		
		for(Environment environment : allEnvironments) {
			List<FieldData> fieldDataList = envDataServices.getFieldDataByEnvironmentAfterGivenHour(environment,
					Constants.NOTIFICATION_TIME_INTERVAL_HOUR);

			for (FieldData fieldData : fieldDataList) {				
				checkAndNotifyError(fieldData.getHumidity(), environment.getHumidity(), "humidity",
						NotificationType.INVALID_HUMIDITY_ERROR, environment);
				checkAndNotifyError(fieldData.getWaterPH(), environment.getWaterPH(), "water pH",
						NotificationType.INVALID_WATER_pH_ERROR, environment);
				checkAndNotifyError(fieldData.getTemperatureC(), environment.getTemperatureC(), "temperature",
						NotificationType.INVALID_TEMPERATURE_ERROR, environment);
	
				List<MineralData> mineralDataList = fieldData.getMineralDataList();
				for (MineralData mineralData : mineralDataList) {
			        checkAndNotifyError(mineralData.getMineralValue(), mineralData.getMineral().getMineralAmount(), mineralData.getMineral().getMineralName(), NotificationType.INVALID_MINERAL_ERROR, environment);
			    }
			}
		}
		
	}
}
