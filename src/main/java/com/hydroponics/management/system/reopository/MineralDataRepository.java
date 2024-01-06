package com.hydroponics.management.system.reopository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.hydroponics.management.system.entities.MineralData;

public interface MineralDataRepository extends JpaRepository<MineralData, Long> {

}
