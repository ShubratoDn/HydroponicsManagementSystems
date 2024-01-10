package com.hydroponics.management.system.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.hydroponics.management.system.annotation.LoginRequired;
import com.hydroponics.management.system.configs.Constants;
import com.hydroponics.management.system.entities.Environment;
import com.hydroponics.management.system.entities.FieldData;
import com.hydroponics.management.system.entities.MineralData;
import com.hydroponics.management.system.entities.Notification;
import com.hydroponics.management.system.entities.User;
import com.hydroponics.management.system.entities.enums.NotificationStatus;
import com.hydroponics.management.system.entities.enums.NotificationType;
import com.hydroponics.management.system.payloads.PageableResponse;
import com.hydroponics.management.system.services.EnvDataServices;
import com.hydroponics.management.system.services.EnvironmentServices;
import com.hydroponics.management.system.services.HelperServices;
import com.hydroponics.management.system.services.NotificationServices;

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
	
	
	
	
	//get my notification
	@LoginRequired
	@GetMapping("/api/my-notifications/")
	public ResponseEntity<?> getMyNotifications(
			@RequestParam(value = "page", defaultValue = "0", required = false) int page,
			@RequestParam(value = "size", defaultValue = "10", required = false) int size,
			@RequestParam(value = "sortBy", defaultValue = "productId", required = false) String sortBy,
			@RequestParam(value = "sortDirection", defaultValue = "desc", required = false) String sortDirection
			){

		User loggedUser = helperServices.getLoggedUser();
		if(loggedUser == null) {
			return ResponseEntity.badRequest().body("YOU ARE NOT LOGGED IN");	
		}		
		
		PageableResponse myNotifications = notificationServices.getMyNotifications(loggedUser, page, size, sortBy, sortDirection);

		return ResponseEntity.ok(myNotifications);
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
