package com.hydroponics.management.system.reopository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.hydroponics.management.system.entities.Location;

public interface LocationRepository extends JpaRepository<Location, Long> {

	List<Location> findByIsAvailable(boolean available);
	
}
