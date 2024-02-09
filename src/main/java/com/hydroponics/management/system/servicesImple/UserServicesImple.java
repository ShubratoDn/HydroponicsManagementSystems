package com.hydroponics.management.system.servicesImple;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.mindrot.jbcrypt.BCrypt;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.hydroponics.management.system.DTO.UserDTO;
import com.hydroponics.management.system.entities.User;
import com.hydroponics.management.system.reopository.UserRepository;
import com.hydroponics.management.system.services.UserServices;

import jakarta.servlet.http.HttpSession;


@Service
public class UserServicesImple implements UserServices {

	@Autowired
	private ModelMapper modelMapper;

	@Autowired
	private UserRepository userRepository;

	// Adding User
	@Override
	public UserDTO addUser(UserDTO userDto) {
		userDto.setPassword(this.hashPassword(userDto.getPassword()));
		
		User user = modelMapper.map(userDto, User.class);
		user.setRegistrationDate(new Timestamp(System.currentTimeMillis()));
		User save = userRepository.save(user);
		return modelMapper.map(save, UserDTO.class);
	}

	@Override
	public UserDTO getUserById(Integer id) {
		User user = null;
		
		Optional<User> findById = userRepository.findById(id);		
		
		if (findById == null) {
			return null;
		}else {
			user = findById.get();
		}
		
		return modelMapper.map(user, UserDTO.class);
	}

	@Override
	public UserDTO getUserByEmail(String email) {
		User user = userRepository.findByEmail(email);
		if (user == null) {
			return null;
		}
		return modelMapper.map(user, UserDTO.class);
	}

	@Override
	public UserDTO getUserByPhone(String phone) {
		User user = userRepository.findByPhone(phone);
		if (user == null) {
			return null;
		}
		return modelMapper.map(user, UserDTO.class);
	}

	
	@Override
	public UserDTO getUserByPhoneOrEmail(String username) {
		User user = userRepository.findByPhoneOrEmail(username, username);
		if (user == null) {
			return null;
		}
		return modelMapper.map(user, UserDTO.class);
	}

	
	
	//password encryption
	public String hashPassword(String password) {
		return BCrypt.hashpw(password, BCrypt.gensalt());
	}

	public boolean verifyPassword(String inputPassword, String hashedPassword) {
		return BCrypt.checkpw(inputPassword, hashedPassword);
	}

	@Override
	public List<UserDTO> getAllUser() {
		List<User> findAll = userRepository.findAll();
		List<UserDTO> userDto = new ArrayList<>();
		
		for(User user : findAll) {
			userDto.add(modelMapper.map(user, UserDTO.class));
		}
		
		return userDto;
	}

	@Override
	public UserDTO getLoggedInUser() {
	    // Get the HttpSession
	    HttpSession session = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes())
	            .getRequest().getSession();

	    // Retrieve the logged-in user from the session
	    UserDTO loggedUser = (UserDTO) session.getAttribute("loggedUser");

	    // Convert the User entity to UserDTO
	    if (loggedUser != null) {	        
	        return loggedUser;
	    }

	    return null;
	}



}
