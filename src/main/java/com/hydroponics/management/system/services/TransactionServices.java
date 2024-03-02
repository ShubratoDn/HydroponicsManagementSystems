package com.hydroponics.management.system.services;

import com.hydroponics.management.system.DTO.InvoiceRequest;
import com.hydroponics.management.system.entities.Invoice;

public interface TransactionServices {

	public Invoice createInvoice(InvoiceRequest invoiceRequest);
	
}
