package com.hydroponics.management.system.reopository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.hydroponics.management.system.entities.Invoice;
import com.hydroponics.management.system.entities.User;


public interface InvoiceRepository extends JpaRepository<Invoice, Long> {
	List<Invoice> findByUser(User user);
	void deleteByUser(User user);
	
	@Query("DELETE FROM Invoice i WHERE i.user.id = :userId")
    void deleteByUserId(@Param("userId") int userId);
}
