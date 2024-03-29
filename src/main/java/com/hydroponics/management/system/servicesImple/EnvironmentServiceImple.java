package com.hydroponics.management.system.servicesImple;


import java.util.Date;
import java.util.List;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import com.hydroponics.management.system.DTO.EnvironmentDTO;
import com.hydroponics.management.system.entities.Environment;
import com.hydroponics.management.system.entities.Location;
import com.hydroponics.management.system.entities.Mineral;
import com.hydroponics.management.system.entities.User;
import com.hydroponics.management.system.payloads.PageableResponse;
import com.hydroponics.management.system.reopository.EnvironmentRepo;
import com.hydroponics.management.system.reopository.FieldDataRepository;
import com.hydroponics.management.system.reopository.MineralRepository;
import com.hydroponics.management.system.reopository.NotificationRepository;
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
	
	@Autowired
	private NotificationRepository notificationRepository;
	
	@Autowired
	private FieldDataRepository fieldDataRepository;
	
		
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
	
	//update Environment
	@Override
	public Environment updateEnvironment(EnvironmentDTO environmentDTO) {
						
		Environment environment = modelMapper.map(environmentDTO, Environment.class);
		environment.setAddedEnvironmentBy(modelMapper.map(userServices.getLoggedInUser(), User.class ));

		
		Environment oldEnv = null;
		if(environmentDTO.getId() == null) {
			return null;
		}else {			
			oldEnv = this.getEnvironmentById(environmentDTO.getId());
			
			//setting the OLD location is AVAILABLE
			Location oldLocation = oldEnv.getLocation();
			oldLocation.setAvailable(true);		
			locationService.updateLocation(oldLocation);
			
			
			//setting environment id
			environment.setId(oldEnv.getId());
		}
		
		environment.setMinerals(null);		
		Environment save = environmentRepo.save(environment);
		
		
		//adding or updating minerals
		for(Mineral mineral: environmentDTO.getMinerals()) {			
			if(mineral.getId() != null) {
				
				if((mineral.getMineralName() == null || mineral.getMineralName().isBlank()) && (mineral.getMineralUnit() == null || mineral.getMineralUnit().isBlank())) {
					//deleting mineral if Mineral Name and Mineral Unit is null
					mineralRepository.deleteById(mineral.getId());
				}else {
					//updating the mineral
					Mineral oldMineral = mineralRepository.findById(mineral.getId()).get();
					
					oldMineral.setMineralAmount(mineral.getMineralAmount());
					oldMineral.setMineralName(mineral.getMineralName());
					oldMineral.setMineralUnit(mineral.getMineralUnit());		
					mineralRepository.save(oldMineral);
				}
				
				
			}else {
				mineral.setEnvironment(save);
				mineralRepository.save(mineral);
				System.out.println(mineral.getId() + " ADDED MINERAL \n");
			}			
		}
		
		
		
		
		
		//setting the NEW location is USED
		save.getLocation().setAvailable(false);
		locationService.updateLocation(save.getLocation());
				
		
		
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

	@Override
	public void deleteEnvironment(Long id) {
		Environment env = new Environment();
		env.setId(id);
		
		fieldDataRepository.deleteByEnvironment(env);
		notificationRepository.deleteByEnvironment(env);
		environmentRepo.deleteById(id);
	}
	
	@Override
	public void deleteEnvironmentByUser(User user) {		
		List<Environment> allEnvironmentsByUser = this.getAllEnvironmentsByUser(user.getId());		
		
		for(Environment env: allEnvironmentsByUser) {		
			fieldDataRepository.deleteByEnvironment(env);
			notificationRepository.deleteByEnvironment(env);
			environmentRepo.deleteById(env.getId());	
		}
		
		
	}

	@Override
	public List<Environment> getAllEnvironmentsByUser(int id) {
		User user = new User();
		user.setId(id);
		
		List<Environment> findByOwnedBy = environmentRepo.findByOwnedBy(user);
		return findByOwnedBy;
	}
	
	@Override
	public List<Environment> getAllEnvironmentsByUser(User user) {		
		List<Environment> findByOwnedBy = environmentRepo.findByOwnedBy(user);
		return findByOwnedBy;
	}

	
	@Override
	public PageableResponse getAllEnvironmentsByUser(User user, int pageNumber, int pageSize, String sortBy, String sortDirection) {
	
		Sort sort = null;
		if(sortBy != null && sortDirection != null && sortDirection.equalsIgnoreCase("asc")) {
			sort =  Sort.by(sortBy).ascending();
		}else {
			sort =  Sort.by(sortBy).descending();
		}
		
		Page<Environment> pageInfo;
		
		try {
			Pageable pageable = PageRequest.of(pageNumber, pageSize, sort);
			pageInfo = environmentRepo.findByOwnedBy(user, pageable);
			
		}catch (Exception e) {
			Pageable pageable = PageRequest.of(pageNumber, pageSize, Sort.by("id").descending());
			pageInfo = environmentRepo.findByOwnedBy(user, pageable);
		}
		
		
		
		PageableResponse pageData = new PageableResponse();
		pageData.setContent(pageInfo.getContent());
		pageData.setPageNumber(pageInfo.getNumber());
		pageData.setPageSize(pageInfo.getSize());
		pageData.setTotalElements(pageInfo.getTotalElements());
		pageData.setTotalPages(pageInfo.getTotalPages());
		pageData.setNumberOfElements(pageInfo.getNumberOfElements());

		pageData.setEmpty(pageInfo.isEmpty());
		pageData.setFirst(pageInfo.isFirst());
		pageData.setLast(pageInfo.isLast());
		
		
		return pageData;
	}

	
	@Override
	public PageableResponse getAllEnvironmentsByUser(int id, int pageNumber, int pageSize, String sortBy, String sortDirection) {
		User user = new User();
		user.setId(id);		
		return this.getAllEnvironmentsByUser(user, pageNumber, pageSize, sortBy, sortDirection);
	}

	@Override
	public Environment getEnvironmentByIdAndOwnedBy(Long envId, User user) {
		Environment findByIdAndOwnedBy = environmentRepo.findByIdAndOwnedBy(envId, user);
		return findByIdAndOwnedBy;
	}
	
	
	
	//find all environment pageable
	@Override
	public PageableResponse getAllEnvironmentsPageable( int pageNumber, int pageSize, String sortBy, String sortDirection) {
		

		Sort sort = null;
		if(sortBy != null && sortDirection != null && sortDirection.equalsIgnoreCase("asc")) {
			sort =  Sort.by(sortBy).ascending();
		}else {
			sort =  Sort.by(sortBy).descending();
		}
		
		Page<Environment> pageInfo;
		
		try {
			Pageable pageable = PageRequest.of(pageNumber, pageSize, sort);
			pageInfo = environmentRepo.findAll(pageable);
			
		}catch (Exception e) {
			Pageable pageable = PageRequest.of(pageNumber, pageSize, Sort.by("id").descending());
			pageInfo = environmentRepo.findAll(pageable);
		}
		
		
		
		PageableResponse pageData = new PageableResponse();
		pageData.setContent(pageInfo.getContent());
		pageData.setPageNumber(pageInfo.getNumber());
		pageData.setPageSize(pageInfo.getSize());
		pageData.setTotalElements(pageInfo.getTotalElements());
		pageData.setTotalPages(pageInfo.getTotalPages());
		pageData.setNumberOfElements(pageInfo.getNumberOfElements());

		pageData.setEmpty(pageInfo.isEmpty());
		pageData.setFirst(pageInfo.isFirst());
		pageData.setLast(pageInfo.isLast());
		
		
		return pageData;
	}
	
}
