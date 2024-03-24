package com.hydroponics.management.system.reopository;

import java.sql.Timestamp;
import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import com.hydroponics.management.system.entities.Environment;
import com.hydroponics.management.system.entities.Notification;
import com.hydroponics.management.system.entities.User;
import com.hydroponics.management.system.entities.enums.NotificationStatus;
import com.hydroponics.management.system.entities.enums.NotificationType;

import jakarta.transaction.Transactional;

public interface NotificationRepository extends JpaRepository<Notification, Long > {

	List<Notification> findByReceiverAndNotificationTypeAndEnvironmentAndTimestampAfter(User receiver, NotificationType notificationType, Environment environment, Timestamp timestamp);

	List<Notification> findByReceiverAndNotificationTypeAndEnvironmentAndMineralAndTimestampAfter(User receiver, NotificationType notificationType, Environment environment, String mineral, Timestamp timestamp);

	
	Page<Notification> findByReceiver(User user, Pageable page);
	
	List<Notification> findByReceiverAndStatus(User user, NotificationStatus status);
	
	@Transactional
	void deleteByEnvironment(Environment env);
	
	void deleteByReceiverOrSender(User user, User sender);
	
	void deleteByReceiver(User user);
}
