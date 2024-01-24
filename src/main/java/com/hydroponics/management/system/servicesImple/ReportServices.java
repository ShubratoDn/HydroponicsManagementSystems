package com.hydroponics.management.system.servicesImple;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hydroponics.management.system.entities.User;
import com.hydroponics.management.system.reopository.EnvironmentRepo;
import com.hydroponics.management.system.reopository.LocationRepository;
import com.hydroponics.management.system.reopository.UserRepository;

@Service
public class ReportServices {

	@Autowired
	private UserRepository userRepository;

	@Autowired
	private EnvironmentRepo environmentRepo;

	@Autowired
	private LocationRepository locationRepository;

	public int countActiveUsers() {
		return userRepository.findAll().size();
	}

	public int countActiveEnvironment() {
		return environmentRepo.findAll().size();
	}

	public int countTotalLocation() {
		return locationRepository.findAll().size();
	}

	public int countAvailableLocation() {
		return locationRepository.findByIsAvailable(true).size();
	}

	public int countAssignedLocation() {
		return locationRepository.findByIsAvailable(false).size();
	}

	public List<User> getUsersRegisteredYesterday() {
		LocalDateTime yesterday = LocalDateTime.now().minusDays(1);
		Timestamp startTime = Timestamp.valueOf(yesterday.withHour(0).withMinute(0).withSecond(0).withNano(0));
		Timestamp endTime = Timestamp.valueOf(yesterday.withHour(23).withMinute(59).withSecond(59).withNano(999999999));
		return userRepository.findUsersRegisteredYesterday(startTime, endTime);
	}

	public List<User> getUsersRegisteredToday() {
		LocalDateTime today = LocalDateTime.now();
		Timestamp startTime = Timestamp.valueOf(today.withHour(0).withMinute(0).withSecond(0).withNano(0));
		Timestamp endTime = Timestamp.valueOf(today);
		return userRepository.findUsersRegisteredToday(startTime, endTime);
	}
}
