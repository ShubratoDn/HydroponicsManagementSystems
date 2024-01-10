package com.hydroponics.management.system.servicesImple;

import java.util.Date;
import java.util.List;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hydroponics.management.system.DTO.EnvironmentDTO;
import com.hydroponics.management.system.entities.Environment;
import com.hydroponics.management.system.entities.Mineral;
import com.hydroponics.management.system.entities.User;
import com.hydroponics.management.system.reopository.EnvironmentRepo;
import com.hydroponics.management.system.reopository.MineralRepository;
import com.hydroponics.management.system.services.EnvironmentServices;
import com.hydroponics.management.system.services.LocationService;
import com.hydroponics.management.system.services.UserServices;

@Service
public class EnvironmentServiceImple implements EnvironmentServices {

	@Autowired
	private EnvironmentRepo environmentRepo;
	
	@Autowired
	private UserServices userServices;
	
	@Autowired
	private ModelMapper modelMapper;
	
	@Autowired
	private MineralRepository mineralRepository;
	
	@Autowired
	private LocationService locationService;
	
	@Override
	public Environment addEnvironment(EnvironmentDTO environmentDTO) {
		Environment environment = modelMapper.map(environmentDTO, Environment.class);
		environment.setAddedEnvironmentBy(modelMapper.map(userServices.getLoggedInUser(), User.class ));
		Environment save = environmentRepo.save(environment);
		
		//adding minerals
		for(Mineral mineral: environment.getMinerals()) {
			mineral.setEnvironment(save);
			mineralRepository.save(mineral);
		}
		
		//setting the location is used
		environment.getLocation().setAvailable(false);
		locationService.updateLocation(environment.getLocation());
		
		return save;
	}

	@Override
	public Environment getEnvironmentById(Long id) {
		Environment environment = null;
		try {			
			environment = environmentRepo.findById(id).get();
			return environment;
		}catch (Exception e) {
			return null;
		}
		
	}

	@Override
	public List<Environment> getAllEnvironments() {
		List<Environment> findAll = environmentRepo.findAll();
		return findAll;
	}
	
	
	
	public List<Environment> searchEnvironments(String plantName, Integer userId, Long locationId, Date startDate, Date endDate) {
	    
	    return environmentRepo.searchEnvironments(plantName, userId, locationId, startDate, endDate);
	}
	
	
	@Override
    public List<Environment> searchEnvironments(
            Long environmentId, String plantName, Integer ownedByUserId,
            String ownedByUserFirstName, String ownedByUserPhone, String ownedByUserEmail,
            Long locationId, String locationName, String locationAddress, Boolean locationAvailable,
            Date plantDate, Date maturityDate, Integer lightDuration, Double waterPH,
            Double temperatureC, Double humidity, Integer addedByUserId,
            String addedByUserFirstName, String addedByUserPhone,
            String addedByUserEmail, String addedByUserRole) {

        return environmentRepo.searchEnvironments(
                environmentId, plantName, ownedByUserId,
                ownedByUserFirstName, ownedByUserPhone, ownedByUserEmail,
                locationId, locationName, locationAddress, locationAvailable,
                plantDate, maturityDate, lightDuration, waterPH,
                temperatureC, humidity, addedByUserId,
                addedByUserFirstName, addedByUserPhone,
                addedByUserEmail, addedByUserRole
        );
    }

	@Override
	public List<Mineral> getMineralsOfEnvironment(Long id) {
		Environment env = this.getEnvironmentById(id);		
		return env.getMinerals();
	}

	@Override
	public List<Mineral> getMineralsOfEnvironment(Environment environment) {
		Environment env = this.getEnvironmentById(environment.getId());		
		return env.getMinerals();
	}
	
}
