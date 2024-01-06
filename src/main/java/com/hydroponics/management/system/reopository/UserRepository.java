package com.hydroponics.management.system.reopository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.hydroponics.management.system.entities.User;

public interface UserRepository extends JpaRepository<User, Integer> {

	User findByEmail(String email);
	
	User findByPhone(String phone);
	
	User findByPhoneOrEmail(String phone, String email);
}
