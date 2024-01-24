package com.hydroponics.management.system.reopository;

import java.sql.Timestamp;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.hydroponics.management.system.entities.User;

public interface UserRepository extends JpaRepository<User, Integer> {

	User findByEmail(String email);

	User findByPhone(String phone);

	User findByPhoneOrEmail(String phone, String email);

	@Query("SELECT u FROM User u WHERE u.registrationDate >= :startTime AND u.registrationDate <= :endTime")
	List<User> findUsersRegisteredYesterday(Timestamp startTime, Timestamp endTime);

	@Query("SELECT u FROM User u WHERE u.registrationDate >= :startTime AND u.registrationDate <= :endTime")
	List<User> findUsersRegisteredToday(Timestamp startTime, Timestamp endTime);
}
