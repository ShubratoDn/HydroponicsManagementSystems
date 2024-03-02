package com.hydroponics.management.system.servicesImple;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hydroponics.management.system.DTO.InvoiceRequest;
import com.hydroponics.management.system.entities.Invoice;
import com.hydroponics.management.system.entities.InvoiceItem;
import com.hydroponics.management.system.entities.User;
import com.hydroponics.management.system.reopository.InvoiceRepository;
import com.hydroponics.management.system.services.TransactionServices;

import jakarta.transaction.Transactional;

@Service
public class TransactionServiceImple implements TransactionServices {

	@Autowired
	private InvoiceRepository invoiceRepository;
	
	@Override
	@Transactional
	public Invoice createInvoice(InvoiceRequest invoiceRequest) {
		Invoice invoice = new Invoice();
		
		User user = new User();
		user.setId(invoiceRequest.getUserId());
		
		invoice.setUser(user);
		invoice.setInvoiceDate(invoiceRequest.getInvoiceDate());
		invoice.setDueDate(invoiceRequest.getDueDate());
		invoice.setOtherInformation(invoiceRequest.getOtherInformation());
		invoice.setStatus("unpaid");
		invoice.setItems(invoiceRequest.getItems());
		
		for(InvoiceItem invoiceItem : invoice.getItems()) {
			invoiceItem.setInvoice(invoice);
		}
		
		Invoice save = invoiceRepository.save(invoice);
		
		return save;
	}

	
	
	@Override
	public List<Invoice> getAllInvoices() {
		List<Invoice> findAll = invoiceRepository.findAll();
		return findAll;
	}
	
}
