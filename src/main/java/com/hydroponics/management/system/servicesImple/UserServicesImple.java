package com.hydroponics.management.system.servicesImple;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.mindrot.jbcrypt.BCrypt;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.hydroponics.management.system.DTO.UserDTO;
import com.hydroponics.management.system.entities.Environment;
import com.hydroponics.management.system.entities.Invoice;
import com.hydroponics.management.system.entities.Notification;
import com.hydroponics.management.system.entities.Payment;
import com.hydroponics.management.system.entities.User;
import com.hydroponics.management.system.entities.enums.NotificationType;
import com.hydroponics.management.system.reopository.EnvironmentRepo;
import com.hydroponics.management.system.reopository.FieldDataRepository;
import com.hydroponics.management.system.reopository.InvoiceRepository;
import com.hydroponics.management.system.reopository.NotificationRepository;
import com.hydroponics.management.system.reopository.PaymentRepository;
import com.hydroponics.management.system.reopository.UserRepository;
import com.hydroponics.management.system.services.NotificationServices;
import com.hydroponics.management.system.services.SmsServices;
import com.hydroponics.management.system.services.UserServices;

import jakarta.servlet.http.HttpSession;


@Service
public class UserServicesImple implements UserServices {

	@Autowired
	private ModelMapper modelMapper;

	@Autowired
	private UserRepository userRepository;
		
	@Autowired
	private NotificationRepository notificationRepository;
	
	@Autowired
	private InvoiceRepository invoiceRepository;
	
	@Autowired
	private EnvironmentRepo environmentRepo;
	

	@Autowired
	private FieldDataRepository fieldDataRepository;
	
	@Autowired
	private NotificationServices notificationServices;
	
	@Autowired
	private SmsServices smsServices;
	
	@Autowired
	private PaymentRepository paymentRepository;
		
	// Adding User
	@Override
	public UserDTO addUser(UserDTO userDto) {
		userDto.setPassword(this.hashPassword(userDto.getPassword()));
		
		User user = modelMapper.map(userDto, User.class);
		user.setRegistrationDate(new Timestamp(System.currentTimeMillis()));
		User save = userRepository.save(user);
		
		//send Notification
		if(save != null) {
			
			String message = "Hello "+save.getFirstName()+",\r\n"
					+ "\r\n"
					+ "Congratulations on successfully registering to LeafLab - A Hydroponics management system!\r\n"
					+ "\r\n"
					+ "You are now part of our community dedicated to efficient and sustainable hydroponics management. Explore the features and functionalities tailored to enhance your hydroponics experience.\r\n"
					+ "\r\n"
					+ "Feel free to reach out to us if you have any questions or need assistance. Happy farming!\r\n"
					+ "\r\n"
					+ "Best regards,\r\n"
					+ "LeafLab Team";
			
			//sending the notification
			Notification notification = new Notification();
			notification.setNotificationType(NotificationType.SUCCESS_USER_REGISTRATION);
			notification.setReceiver(save);
			notification.setMessage(message);
			notificationServices.sendNotificationAndNotify(notification);
			smsServices.sendSms(save.getPhone(), "Hello "+save.getFirstName()+" "+ save.getLastName() +", Congratulations on joining LeafLab! Explore our hydroponics management system for efficient farming. Happy farming! - LeafLab Team");
		}
		
		return modelMapper.map(save, UserDTO.class);
	}

	@Override
	public UserDTO getUserById(Integer id) {
		User user = null;
		
		Optional<User> findById = userRepository.findById(id);		
		
		if (!findById.isPresent()) {
			return null;
		}else {
			user = findById.get();
		}
		
		UserDTO map = modelMapper.map(user, UserDTO.class);
		if(map.getAddedBy() != null) {
			map.getAddedBy().setAddedBy(null);
		}
		
		return map;
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

	@Override
	public UserDTO updateUser(UserDTO userDTO) {
		User user = userRepository.findById(userDTO.getId()).get();
		
		 // Check and update each attribute individually
	    if (userDTO.getAddress() != null) {
	        user.setAddress(userDTO.getAddress());
	    }

	    if (userDTO.getFirstName() != null) {
	        user.setFirstName(userDTO.getFirstName());
	    }

	    if (userDTO.getLastName() != null) {
	        user.setLastName(userDTO.getLastName());
	    }
	    
	    if (userDTO.getEmail() != null) {
	        user.setEmail(userDTO.getEmail());
	    }

	    if (userDTO.getPhone() != null) {
	        user.setPhone(userDTO.getPhone());
	    }
		
	    if (userDTO.getRemark() != null) {
	        user.setRemark(userDTO.getRemark());
	    }
	    
	    if (userDTO.getRole() != null || !userDTO.getRole().isBlank()) {
	    	user.setRole(userDTO.getRole());
	    }
	    
	    if (userDTO.getPassword() != null && !userDTO.getPassword().isBlank()) {
	        user.setPassword(hashPassword(userDTO.getPassword()));
	    }
		
	    if (userDTO.getImage() != null) {
	        user.setImage(userDTO.getImage());
	    }
	    
		User save = userRepository.save(user);
		
		return modelMapper.map(save, UserDTO.class);
	}


	
	@Override
	public List<UserDTO> getUsersBySearchQuery(String query){
		List<User> findUsersBySearchQuery = userRepository.findUsersBySearchQuery(query);
		
		List<UserDTO> userDTOs = new ArrayList<>();
		
		for(User user: findUsersBySearchQuery) {
			if(user.getAddedBy() != null) {
				user.getAddedBy().setAddedBy(null);
			}
			UserDTO userDTO = modelMapper.map(user, UserDTO.class);			
			userDTOs.add(userDTO);
		}
		
		return userDTOs;
	}

	
	@Override
	public void deleteUser(int id) {		
		userRepository.deleteById(id);
	}
	
	@Override
	public void deleteUser(UserDTO userDTO) {		
		User user = modelMapper.map(userDTO, User.class);		
		
		this.deleteEnvironmentByUser(user);
		
		//deleting notification
		Page<Notification> findByReceiver = notificationRepository.findByReceiver(user, null);
		
		for(Notification notification: findByReceiver.getContent()) {
			notificationRepository.delete(notification);
		}
		
//		notificationRepository.deleteByReceiver(user);
		

		
		
		//Deleting the invoice and payments
		List<Invoice> findByUser = invoiceRepository.findByUser(user);
		for(Invoice invoice: findByUser) {			
			List<Payment> findByInvoice = paymentRepository.findByInvoice(invoice);
			for(Payment payment: findByInvoice) {
				paymentRepository.delete(payment);
			}			
			invoiceRepository.delete(invoice);
		}
		
		userRepository.delete(user);
		
	}
	
	
	
	public void deleteEnvironmentByUser(User user) {		
		List<Environment> allEnvironmentsByUser = environmentRepo.findByOwnedBy(user);
		
		for(Environment env: allEnvironmentsByUser) {		
			fieldDataRepository.deleteByEnvironment(env);
			notificationRepository.deleteByEnvironment(env);
			environmentRepo.deleteById(env.getId());	
		}		
	}

}
