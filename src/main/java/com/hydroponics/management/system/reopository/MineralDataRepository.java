package com.hydroponics.management.system.reopository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.hydroponics.management.system.entities.FieldData;
import com.hydroponics.management.system.entities.MineralData;

import jakarta.transaction.Transactional;

public interface MineralDataRepository extends JpaRepository<MineralData, Long> {
	List<MineralData> findByFieldData(FieldData fieldData);
	
	@Transactional
    void deleteByFieldData(FieldData fieldData);
}
