package com.hydroponics.management.system.reopository;

import java.sql.Timestamp;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.hydroponics.management.system.entities.Environment;
import com.hydroponics.management.system.entities.FieldData;

import jakarta.transaction.Transactional;

public interface FieldDataRepository extends JpaRepository<FieldData, Long> {

	List<FieldData> findByEnvironment(Environment environment);
	List<FieldData> findByEnvironmentAndTimestampAfter(Environment environment, Timestamp timestamp);

	// Fetch the last N FieldData records for a given Environment (replace :count with the desired number)
    @Query("SELECT fd FROM FieldData fd WHERE fd.environment = :environment ORDER BY fd.timestamp DESC LIMIT :count")
    List<FieldData> findLastNFieldDataByEnvironment(@Param("environment") Environment environment, @Param("count") int count);

    @Transactional
    void deleteAllByEnvironment(Environment env);
    
    @Transactional
    void deleteByEnvironment(Environment env);
}
