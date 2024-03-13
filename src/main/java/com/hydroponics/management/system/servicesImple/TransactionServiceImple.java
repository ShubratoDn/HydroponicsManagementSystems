package com.hydroponics.management.system.servicesImple;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hydroponics.management.system.DTO.InvoiceRequest;
import com.hydroponics.management.system.entities.Invoice;
import com.hydroponics.management.system.entities.InvoiceItem;
import com.hydroponics.management.system.entities.Payment;
import com.hydroponics.management.system.entities.User;
import com.hydroponics.management.system.reopository.InvoiceRepository;
import com.hydroponics.management.system.reopository.PaymentRepository;
import com.hydroponics.management.system.services.TransactionServices;

import jakarta.transaction.Transactional;

@Service
public class TransactionServiceImple implements TransactionServices {

	@Autowired
	private InvoiceRepository invoiceRepository;
	
	@Autowired
	private PaymentRepository paymentRepository;
	
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
	
	
	@Override
	public Invoice getInvoiceById(Long id) {
		Invoice invoice = invoiceRepository.findById(id).orElse(null);
		if(invoice == null) {
			return null;
		}		
		return invoice;
	}
	
	@Override
	public List<Invoice> getInvoicesByUser(User user) {
		if(user != null) {
			List<Invoice> findByUser = invoiceRepository.findByUser(user);
			return findByUser;
		}
		return null;
	}
	
	@Override
	public List<Invoice> getInvoicesByUserId(Integer user) {
		if(user != null && user > 0) {
			User userx = new User();
			userx.setId((int) user);
			List<Invoice> findByUser = invoiceRepository.findByUser(userx);
			return findByUser;
		}
		return null;
	}

	
	@Override
	public Payment addPayment(Payment payment) {
		Payment save = paymentRepository.save(payment);
		
		Invoice invoiceById = this.getInvoiceById(save.getInvoice().getId());
		invoiceById.setStatus(save.getStatus().toString());
		
		Invoice savedInvoice = this.invoiceRepository.save(invoiceById);		
		save.setInvoice(savedInvoice);
		
		return save;
	}
	
	@Override
	public List<Payment> getAllPayments() {
		List<Payment> findAll = paymentRepository.findAll();
		System.out.println("FOUND SERVICE " + findAll.size());
		return findAll;
	}
	
}
