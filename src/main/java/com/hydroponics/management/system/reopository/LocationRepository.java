package com.hydroponics.management.system.reopository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.hydroponics.management.system.entities.Location;

public interface LocationRepository extends JpaRepository<Location, Long> {

	List<Location> findByIsAvailable(boolean available);
	
	@Query("SELECT l FROM Location l " +
		       "WHERE (LOWER(l.locationName) LIKE LOWER(CONCAT('%', :searchQuery, '%')) " +
		       "   OR LOWER(l.fullAddress) LIKE LOWER(CONCAT('%', :searchQuery, '%')) " +
		       "   OR CAST(l.length AS string) LIKE CONCAT('%', :searchQuery, '%') " +
		       "   OR CAST(l.width AS string) LIKE CONCAT('%', :searchQuery, '%') " +
		       "   OR LOWER(l.note) LIKE LOWER(CONCAT('%', :searchQuery, '%')))" +
		       "   AND (:isAvailable IS NULL OR l.isAvailable = :isAvailable)")
		List<Location> searchLocations(
		        @Param("searchQuery") String searchQuery,
		        @Param("isAvailable") Boolean isAvailable);

		
}
