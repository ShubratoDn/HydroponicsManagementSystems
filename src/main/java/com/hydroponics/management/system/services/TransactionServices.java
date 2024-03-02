package com.hydroponics.management.system.services;

import java.util.List;

import com.hydroponics.management.system.DTO.InvoiceRequest;
import com.hydroponics.management.system.entities.Invoice;

public interface TransactionServices {

	public Invoice createInvoice(InvoiceRequest invoiceRequest);
	public List<Invoice> getAllInvoices();
	public Invoice getInvoiceById(Long id);
}
