package com.hydroponics.management.system.services;


import java.util.List;

import com.hydroponics.management.system.DTO.UserDTO;

public interface UserServices {

	public UserDTO addUser(UserDTO userDto);
	public UserDTO updateUser(UserDTO userDTO);
	public UserDTO getUserById(Integer id);
	public UserDTO getUserByEmail(String email);
	public UserDTO getUserByPhone(String phone);
	public UserDTO getUserByPhoneOrEmail(String username);
	public List<UserDTO> getAllUser();
	
	public String hashPassword(String password);
	public boolean verifyPassword(String inputPassword, String hashedPassword);
	
	public UserDTO getLoggedInUser();
	
	List<UserDTO> getUsersBySearchQuery(String query);
	
	public void deleteUser(int id);

	public void deleteUser(UserDTO userDTO);
}
