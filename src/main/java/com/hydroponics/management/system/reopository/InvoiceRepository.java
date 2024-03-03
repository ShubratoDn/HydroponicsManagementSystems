package com.hydroponics.management.system.reopository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.hydroponics.management.system.entities.Invoice;
import com.hydroponics.management.system.entities.User;


public interface InvoiceRepository extends JpaRepository<Invoice, Long> {
	List<Invoice> findByUser(User user);
}
