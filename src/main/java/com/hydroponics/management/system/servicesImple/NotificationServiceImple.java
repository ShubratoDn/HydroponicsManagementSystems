package com.hydroponics.management.system.servicesImple;

import java.sql.Timestamp;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hydroponics.management.system.entities.Environment;
import com.hydroponics.management.system.entities.Notification;
import com.hydroponics.management.system.reopository.NotificationRepository;
import com.hydroponics.management.system.services.NotificationServices;

@Service
public class NotificationServiceImple implements NotificationServices  {
	
	@Autowired
	private NotificationRepository notificationRepository;
	
	@Override
	public Notification sendNotification(Notification notification) {
		Notification save = notificationRepository.save(notification);
		return save;
	}

	@Override
	public Notification sendNotificationAfterVerify(Notification notification, double hour) {
		Timestamp now = new Timestamp(System.currentTimeMillis());
		Timestamp tenHoursAgo = new Timestamp(now.getTime() - ((long) hour * 60 * 60 * 1000));
		
		List<Notification> recentNotifications = notificationRepository.findByReceiverAndNotificationTypeAndEnvironmentAndTimestampAfter(notification.getReceiver(), notification.getNotificationType(), notification.getEnvironment(), tenHoursAgo);
		
		if(recentNotifications.size() > 0) {			
			return null;
		}
		
		Notification save = notificationRepository.save(notification);
		return save;
		
	}

}
