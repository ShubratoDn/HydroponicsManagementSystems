package com.hydroponics.management.system.services;

import com.hydroponics.management.system.entities.Environment;
import com.hydroponics.management.system.entities.Notification;
import com.hydroponics.management.system.entities.User;
import com.hydroponics.management.system.entities.enums.NotificationType;
import com.hydroponics.management.system.payloads.PageableResponse;

public interface NotificationServices {
	Notification getNotificationById(Long id);
	
	Notification sendNotification(Notification notification);
	
	Notification sendNotificationAfterVerify(Notification notification, double hour);

	PageableResponse getMyNotifications(User user, int pageNumber, int pageSize, String sortBy, String sortDirection);
	
	Notification unreadNotification(Long id);
	
	void checkAndNotifyError(double actualValue, double expectedValue, String fieldName,NotificationType notificationType, Environment environment);
	
}
