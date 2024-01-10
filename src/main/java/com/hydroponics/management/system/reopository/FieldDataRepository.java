package com.hydroponics.management.system.reopository;

import java.sql.Timestamp;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.hydroponics.management.system.entities.Environment;
import com.hydroponics.management.system.entities.FieldData;

public interface FieldDataRepository extends JpaRepository<FieldData, Long> {

	List<FieldData> findByEnvironment(Environment environment);
	List<FieldData> findByEnvironmentAndTimestampAfter(Environment environment, Timestamp timestamp);

}
