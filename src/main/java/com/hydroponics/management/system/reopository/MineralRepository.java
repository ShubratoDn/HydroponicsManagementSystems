package com.hydroponics.management.system.reopository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.hydroponics.management.system.entities.Mineral;

public interface MineralRepository extends JpaRepository<Mineral, Long> {
	
}
