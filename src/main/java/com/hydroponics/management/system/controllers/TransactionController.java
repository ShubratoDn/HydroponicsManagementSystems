package com.hydroponics.management.system.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.hydroponics.management.system.DTO.InvoiceRequest;
import com.hydroponics.management.system.DTO.UserDTO;
import com.hydroponics.management.system.entities.Invoice;
import com.hydroponics.management.system.payloads.ServerMessage;
import com.hydroponics.management.system.services.TransactionServices;
import com.hydroponics.management.system.services.UserServices;

import jakarta.validation.Valid;

@Controller
public class TransactionController {

	@Autowired
	private UserServices userServices;
	
	@Autowired
	private TransactionServices transactionServices;
	
	
	@GetMapping("/transaction/invoices")
	public String invoicesPage(Model model) {
		List<Invoice> allInvoices = transactionServices.getAllInvoices();
		model.addAttribute("invoiceList", allInvoices);
		return "transactionDirectory/invoices";
	}
	
	@GetMapping("/transaction/invoices/{id}")
	public String invoiceViewPage(@PathVariable("id")Long id, Model model) {
		Invoice invoiceById = transactionServices.getInvoiceById(id);
		if(invoiceById == null) {
			return "404";
		}
		
		model.addAttribute("invoice",invoiceById);
		return "transactionDirectory/invoice-view";
	}
	
	//show the create invoice page
	@GetMapping("/transaction/create-invoice")
	public String createinvoicesPage(Model model, RedirectAttributes redirectAttributes) {
		List<UserDTO> allUser = userServices.getAllUser();
		model.addAttribute("userList", allUser);
		
		ServerMessage serverMessage = (ServerMessage) model.getAttribute("serverMessage");
		BindingResult bindingResult = (BindingResult) model.getAttribute("inputErrors");
		InvoiceRequest invoiceRequest = (InvoiceRequest) model.getAttribute("invoiceRequest");
		
		if(serverMessage != null) {
			redirectAttributes.addFlashAttribute("serverMessage", serverMessage);
		}
		
		if(bindingResult != null) {
			redirectAttributes.addFlashAttribute("inputErrors", bindingResult);	
		}
		
		if(invoiceRequest != null) {			
			redirectAttributes.addFlashAttribute("invoiceRequest", invoiceRequest);
		}
		
		if(invoiceRequest != null && invoiceRequest.getUserId() != null) {
			UserDTO userById = userServices.getUserById(invoiceRequest.getUserId());
			model.addAttribute("userInfo", userById);
		}
		
		return "transactionDirectory/create-invoice";
	}
	
	
	
	
	//creating invoice
	@PostMapping("/transaction/create-invoice")
	public String createinvoice(@Valid @ModelAttribute InvoiceRequest invoiceRequest, BindingResult bindingResult, Model model, RedirectAttributes redirectAttributes) {
		
		 // Remove objects with null or empty name from the list
		invoiceRequest.getItems().removeIf(item -> item.getItemName() == null || item.getItemName().isEmpty() || item.getItemPrice() == null || item.getItemPrice() == null || item.getQuantity() == null || item.getQuantity() < 1);
		
				
		if(invoiceRequest.getItems().size() < 1) {
			bindingResult.addError(new FieldError("invoice", "items", "Invoice can not be empty"));
		}
		
		
		invoiceRequest.setItems(invoiceRequest.getItems());
		redirectAttributes.addFlashAttribute("invoiceRequest", invoiceRequest);
		
		if (bindingResult.hasErrors()) {
			redirectAttributes.addFlashAttribute("inputErrors", bindingResult);			
			return "redirect:/transaction/create-invoice";
		}
		
		
		Invoice createInvoice = transactionServices.createInvoice(invoiceRequest);
		if(createInvoice != null) {
			redirectAttributes.addFlashAttribute("serverMessage", new ServerMessage("Successfully created invoice (ID: #INV_00"+createInvoice.getId()+")", "success", "alert-success" ));
			redirectAttributes.addFlashAttribute("invoiceRequest", null);
		}else {
			redirectAttributes.addFlashAttribute("serverMessage", new ServerMessage("Failed to create invoice!!", "erroe", "alert-danger" ));
		}
		
		return "redirect:/transaction/create-invoice";
	}
	
	
	
	
	
	
	
	
}
