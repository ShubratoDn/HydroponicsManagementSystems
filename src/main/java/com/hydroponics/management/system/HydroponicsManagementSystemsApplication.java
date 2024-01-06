package com.hydroponics.management.system;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import com.hydroponics.management.system.DTO.UserDTO;
import com.hydroponics.management.system.services.UserServices;

@SpringBootApplication
public class HydroponicsManagementSystemsApplication implements CommandLineRunner {

	
	//USED IN THE WebMvcConfig.java class
//	@Bean
//	ModelMapper modelMapper() {
//		return new ModelMapper();
//	}
//	
	public static void main(String[] args) {
		SpringApplication.run(HydroponicsManagementSystemsApplication.class, args);
	}

	
	@Autowired
	private UserServices userServices;
		
	@Override
	public void run(String... args) throws Exception {
		
		UserDTO user = null;
		
		user = userServices.getUserByEmail("admin@gmail.com");
		
		if(user == null) {
			user = new UserDTO();
			user.setEmail("admin@gmail.com");
			user.setFirstName("Admin");
			user.setLastName("Admin");
			user.setImage("AdminImage.jpg");
			user.setRole("Admin");
			user.setPassword("1111");
			userServices.addUser(user);
		}		
		
		
		
	}

}
