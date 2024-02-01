package com.hydroponics.management.system.reopository;

import java.util.Date;
import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.hydroponics.management.system.entities.Environment;
import com.hydroponics.management.system.entities.User;

public interface EnvironmentRepo extends JpaRepository<Environment, Long>, JpaSpecificationExecutor<Environment> {

	@Query("SELECT e FROM Environment e " +
            "WHERE (:plantName IS NULL OR LOWER(e.plantName) LIKE LOWER(CONCAT('%', :plantName, '%'))) " +
            "AND (:userId IS NULL OR e.ownedBy.id = :userId) " +
            "AND (:locationId IS NULL OR e.location.id = :locationId) " +
            "AND (:startDate IS NULL OR e.plantDate >= :startDate) " +
            "AND (:endDate IS NULL OR e.maturityDate <= :endDate)")
    List<Environment> searchEnvironments(
            @Param("plantName") String plantName,
            @Param("userId") Integer userId,
            @Param("locationId") Long locationId,
            @Param("startDate") Date startDate,
            @Param("endDate") Date endDate
    );
	
	
	@Query("SELECT e FROM Environment e " +
            "LEFT JOIN e.ownedBy ownedByUser " +
            "LEFT JOIN e.location loc " +
            "LEFT JOIN e.addedEnvironmentBy addedByUser " +
            "WHERE (:environmentId IS NULL OR e.id = :environmentId) " +
            "AND (:plantName IS NULL OR e.plantName LIKE %:plantName%) " +
            "AND (:ownedByUserId IS NULL OR ownedByUser.id = :ownedByUserId) " +
            "AND (:ownedByUserFirstName IS NULL OR ownedByUser.firstName LIKE %:ownedByUserFirstName%) " +
            "AND (:ownedByUserPhone IS NULL OR ownedByUser.phone LIKE %:ownedByUserPhone%) " +
            "AND (:ownedByUserEmail IS NULL OR ownedByUser.email LIKE %:ownedByUserEmail%) " +
            "AND (:locationId IS NULL OR loc.id = :locationId) " +
            "AND (:locationName IS NULL OR loc.locationName LIKE %:locationName%) " +
            "AND (:locationAddress IS NULL OR loc.fullAddress LIKE %:locationAddress%) " +
            "AND (:locationAvailable IS NULL OR loc.isAvailable = :locationAvailable) " +
            "AND (:plantDate IS NULL OR e.plantDate >= :plantDate) " +
            "AND (:maturityDate IS NULL OR e.maturityDate <= :maturityDate) " +
            "AND (:lightDuration IS NULL OR e.lightDuration = :lightDuration) " +
            "AND (:waterPH IS NULL OR e.waterPH = :waterPH) " +
            "AND (:temperatureC IS NULL OR e.temperatureC = :temperatureC) " +
            "AND (:humidity IS NULL OR e.humidity = :humidity) " +
            "AND (:addedByUserId IS NULL OR addedByUser.id = :addedByUserId) " +
            "AND (:addedByUserFirstName IS NULL OR addedByUser.firstName LIKE %:addedByUserFirstName%) " +
            "AND (:addedByUserPhone IS NULL OR addedByUser.phone LIKE %:addedByUserPhone%) " +
            "AND (:addedByUserEmail IS NULL OR addedByUser.email LIKE %:addedByUserEmail%) " +
            "AND (:addedByUserRole IS NULL OR addedByUser.role LIKE %:addedByUserRole%)")
    List<Environment> searchEnvironments(
            @Param("environmentId") Long environmentId,
            @Param("plantName") String plantName,
            @Param("ownedByUserId") Integer ownedByUserId,
            @Param("ownedByUserFirstName") String ownedByUserFirstName,
            @Param("ownedByUserPhone") String ownedByUserPhone,
            @Param("ownedByUserEmail") String ownedByUserEmail,
            @Param("locationId") Long locationId,
            @Param("locationName") String locationName,
            @Param("locationAddress") String locationAddress,
            @Param("locationAvailable") Boolean locationAvailable,
            @Param("plantDate") Date plantDate,
            @Param("maturityDate") Date maturityDate,
            @Param("lightDuration") Integer lightDuration,
            @Param("waterPH") Double waterPH,
            @Param("temperatureC") Double temperatureC,
            @Param("humidity") Double humidity,
            @Param("addedByUserId") Integer addedByUserId,
            @Param("addedByUserFirstName") String addedByUserFirstName,
            @Param("addedByUserPhone") String addedByUserPhone,
            @Param("addedByUserEmail") String addedByUserEmail,
            @Param("addedByUserRole") String addedByUserRole
    );
	
	
	
	List<Environment> findByOwnedBy(User user);
	
	Page<Environment> findByOwnedBy(User user, org.springframework.data.domain.Pageable pageable);
}
