package com.hydroponics.management.system.services;

import java.util.List;

import com.hydroponics.management.system.entities.Environment;
import com.hydroponics.management.system.entities.Notification;
import com.hydroponics.management.system.entities.Payment;
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

	void checkMineralAndNotifyError(double actualValue, double expectedValue, String fieldName,NotificationType notificationType, Environment environment);
	
	Notification sendNotificationAndNotify(Notification notification);

	Notification sendEnvWelcomeNotification(Environment addEnvironment);
	
	Notification sendPaymentNotification(Payment payment);
	
	List<Notification> getUnreadNotifications(User user);
	
}
