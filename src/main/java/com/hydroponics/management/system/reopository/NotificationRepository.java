package com.hydroponics.management.system.reopository;

import java.sql.Timestamp;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.hydroponics.management.system.entities.Environment;
import com.hydroponics.management.system.entities.Notification;
import com.hydroponics.management.system.entities.User;
import com.hydroponics.management.system.entities.enums.NotificationType;

public interface NotificationRepository extends JpaRepository<Notification, Long > {

	List<Notification> findByReceiverAndNotificationTypeAndEnvironmentAndTimestampAfter(User receiver, NotificationType notificationType, Environment environment, Timestamp timestamp);

}
