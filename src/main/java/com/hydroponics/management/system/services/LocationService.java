package com.hydroponics.management.system.services;

import java.util.List;

import com.hydroponics.management.system.DTO.LocationDTO;
import com.hydroponics.management.system.entities.Environment;
import com.hydroponics.management.system.entities.Location;

public interface LocationService {	
		
	public Location addLocation(Location location);
	public Location updateLocation(Location location);
	
	public Location getLocationById(Long id);
	
	public List<LocationDTO> getAllLocation();
	public List<LocationDTO> getAllUnusedLocation();
	public List<LocationDTO> getEnvironmentLocationAndAllUnusedLocation(Environment environment);
	public List<LocationDTO> getAllUsedLocation();
	List<Location> searchLocations(String searchQuery, Boolean isAvailable);
}
