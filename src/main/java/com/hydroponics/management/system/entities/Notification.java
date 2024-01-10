package com.hydroponics.management.system.entities;

import java.sql.Timestamp;

import com.hydroponics.management.system.entities.enums.NotificationStatus;
import com.hydroponics.management.system.entities.enums.NotificationType;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.ManyToOne;
import lombok.Data;

@Data
@Entity
public class Notification {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	
	@ManyToOne
	private User receiver;
	
	@ManyToOne
	private User sender;
	
	@ManyToOne
	private Environment environment;
	
	@Column(length = 3000)
	private String message;
	
	@Enumerated(EnumType.STRING)
	private NotificationType notificationType;
	
	@Enumerated(EnumType.STRING)
	private NotificationStatus status;
	
	private Timestamp timestamp = new Timestamp(System.currentTimeMillis());
}
