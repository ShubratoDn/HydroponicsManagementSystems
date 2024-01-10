package com.hydroponics.management.system.services;

import com.hydroponics.management.system.entities.Environment;
import com.hydroponics.management.system.entities.Notification;

public interface NotificationServices {
	Notification sendNotification(Notification notification);
	
	Notification sendNotificationAfterVerify(Notification notification, double hour);
}
