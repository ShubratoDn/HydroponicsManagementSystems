package com.hydroponics.management.system.services;

import java.util.Date;
import java.util.List;

import com.hydroponics.management.system.DTO.EnvironmentDTO;
import com.hydroponics.management.system.entities.Environment;
import com.hydroponics.management.system.entities.Mineral;
import com.hydroponics.management.system.entities.User;
import com.hydroponics.management.system.payloads.PageableResponse;

public interface EnvironmentServices {

	Environment addEnvironment(EnvironmentDTO environmentDTO);
	
	Environment getEnvironmentById(Long id);
	
	Environment getEnvironmentByIdAndOwnedBy(Long envId, User user);
	
	List<Environment> getAllEnvironments();
	
	PageableResponse getAllEnvironmentsPageable( int pageNumber, int pageSize, String sortBy, String sortDirection);
	
	List<Environment> getAllEnvironmentsByUser(int id);
	
	PageableResponse getAllEnvironmentsByUser(User user, int pageNumber, int pageSize, String sortBy, String sortDirection);
	
	PageableResponse getAllEnvironmentsByUser(int id, int pageNumber, int pageSize, String sortBy, String sortDirection);

	List<Environment> getAllEnvironmentsByUser(User user);
	
	List<Environment> searchEnvironments(String plantName, Integer userId, Long locationId, Date startDate, Date endDate);
	
	 List<Environment> searchEnvironments(
	            Long environmentId, String plantName, Integer ownedByUserId,
	            String ownedByUserFirstName, String ownedByUserPhone, String ownedByUserEmail,
	            Long locationId, String locationName, String locationAddress, Boolean locationAvailable,
	            Date plantDate, Date maturityDate, Integer lightDuration, Double waterPH,
	            Double temperatureC, Double humidity, Integer addedByUserId,
	            String addedByUserFirstName, String addedByUserPhone,
	            String addedByUserEmail, String addedByUserRole);
	 
	 List<Mineral> getMineralsOfEnvironment(Long id);
	 List<Mineral> getMineralsOfEnvironment(Environment environment);
	 
	 void deleteEnvironment (Long id);
	 
}

