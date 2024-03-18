package com.hydroponics.management.system.reopository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.hydroponics.management.system.entities.Invoice;
import com.hydroponics.management.system.entities.Payment;

public interface PaymentRepository extends JpaRepository<Payment, Long> {
	void deleteByInvoice(Invoice inv);
	
	List<Payment> findByInvoice(Invoice inv);
}
