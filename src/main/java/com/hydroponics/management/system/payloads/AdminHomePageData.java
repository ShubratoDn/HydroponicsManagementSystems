package com.hydroponics.management.system.payloads;

import java.util.List;
import java.util.Map;

import com.hydroponics.management.system.entities.User;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class AdminHomePageData {

	private int activeUsers;
	
	private int activeEnvironment;
	
	private int totalLocation;
	
	private int availableLocation;
	
	private int assignedLocation;
	
	private List<User> usersRegisterToday;
	
	private Map<User, Long> userWithMostAddedUser;
	
	private Map<User, Long> usersWithEnvironmentCount;
}
