package com.hydroponics.management.system.services;

import java.util.List;

import com.hydroponics.management.system.DTO.InvoiceRequest;
import com.hydroponics.management.system.entities.Invoice;
import com.hydroponics.management.system.entities.User;

public interface TransactionServices {

	public Invoice createInvoice(InvoiceRequest invoiceRequest);
	public List<Invoice> getAllInvoices();
	public Invoice getInvoiceById(Long id);
	public List<Invoice> getInvoicesByUser(User user);
	public List<Invoice> getInvoicesByUserId(Integer user);	
}

