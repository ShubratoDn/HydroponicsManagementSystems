package com.hydroponics.management.system.reopository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.hydroponics.management.system.entities.Invoice;

public interface InvoiceRepository extends JpaRepository<Invoice, Long> {

}
