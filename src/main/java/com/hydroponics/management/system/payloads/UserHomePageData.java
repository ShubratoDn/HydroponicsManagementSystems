package com.hydroponics.management.system.payloads;

import java.util.List;

import com.hydroponics.management.system.entities.Environment;
import com.hydroponics.management.system.entities.Notification;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class UserHomePageData {

	List<Environment> allEnvironmentsByUser;
	List<EnvAndFieldData> fieldDataMultipleList;
	List<Notification> unreadNotifications;
}
