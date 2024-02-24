package com.hydroponics.management.system.servicesImple;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hydroponics.management.system.DTO.LocationDTO;
import com.hydroponics.management.system.entities.Environment;
import com.hydroponics.management.system.entities.Location;
import com.hydroponics.management.system.reopository.EnvironmentRepo;
import com.hydroponics.management.system.reopository.LocationRepository;
import com.hydroponics.management.system.services.LocationService;

@Service
public class LocationServiceImple implements LocationService {

	@Autowired
	private LocationRepository locationRepository;
	
	@Autowired
	private ModelMapper modelMapper;
	
	@Autowired
	private EnvironmentRepo environmentRepo;
	
	@Override
	public Location addLocation(Location location) {
		Location save = locationRepository.save(location);
		return save;
	}
	
	public Location updateLocation(Location location) {
		Location oldLocation = locationRepository.findById(location.getId()).get();
		if(oldLocation == null) {
			return null;
		}
		
		location.setId(oldLocation.getId());
		Location save = locationRepository.save(location);		
		return save;
	}

	@Override
	public List<LocationDTO> getAllLocation() {
		List<Location> findAll = locationRepository.findAll();
		List<LocationDTO> locationDTOs = new ArrayList<>();
		
		for(Location location: findAll) {
			locationDTOs.add(modelMapper.map(location, LocationDTO.class));
		}
		
		return locationDTOs;
	}

	@Override
	public List<LocationDTO> getAllUnusedLocation() {
		List<Location> findAll = locationRepository.findByIsAvailable(true);
		List<LocationDTO> locationDTOs = new ArrayList<>();
		
		for(Location location: findAll) {
			locationDTOs.add(modelMapper.map(location, LocationDTO.class));
		}
		
		return locationDTOs;
	}

	@Override
	public List<LocationDTO> getEnvironmentLocationAndAllUnusedLocation(Environment environment) {
		
		Location envLocation = environmentRepo.findById(environment.getId()).get().getLocation();
		
		List<Location> findAll = locationRepository.findByIsAvailable(true);
		List<LocationDTO> locationDTOs = new ArrayList<>();
		
		for(Location location: findAll) {
			locationDTOs.add(modelMapper.map(location, LocationDTO.class));
		}
		
		locationDTOs.add(modelMapper.map(envLocation, LocationDTO.class));
		
		return locationDTOs;
	}
	
	
	@Override
	public List<LocationDTO> getAllUsedLocation() {
		List<Location> findAll = locationRepository.findByIsAvailable(false);
		List<LocationDTO> locationDTOs = new ArrayList<>();
		
		for(Location location: findAll) {
			locationDTOs.add(modelMapper.map(location, LocationDTO.class));
		}
		
		return locationDTOs;
	}

	@Override
	public Location getLocationById(Long id) {
		Optional<Location> findById = locationRepository.findById(id);
		if(findById == null) {
			return null;
		}
		
		Location location = findById.get();
		return location;
	}
	
	@Override
	public List<Location> searchLocations(String searchQuery, Boolean isAvailable) {
		return locationRepository.searchLocations(searchQuery, isAvailable);
//		return locationRepository.searchLocationsX(isAvailable);
	}

}
