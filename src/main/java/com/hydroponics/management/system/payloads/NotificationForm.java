package com.hydroponics.management.system.payloads;

import com.hydroponics.management.system.entities.enums.NotificationType;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class NotificationForm {

	
	private Integer receiverId;
	
	private Integer environmentId;
	
	private NotificationType notificationType;
	
	private String message;

	@Override
	public String toString() {
		return "NotificationForm [receiverId=" + receiverId + ", environmentId=" + environmentId + ", notificationType="
				+ notificationType + ", message=" + message + "]";
	}
	
	
}
