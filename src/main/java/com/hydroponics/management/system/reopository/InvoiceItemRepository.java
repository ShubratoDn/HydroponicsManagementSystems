package com.hydroponics.management.system.reopository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.hydroponics.management.system.entities.InvoiceItem;

//InvoiceItemRepository.java
public interface InvoiceItemRepository extends JpaRepository<InvoiceItem, Long> {
	
}
