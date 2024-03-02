package com.hydroponics.management.system.DTO;

import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

import com.hydroponics.management.system.entities.InvoiceItem;
import com.hydroponics.management.system.entities.User;

import jakarta.persistence.CascadeType;
import jakarta.persistence.OneToMany;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class InvoiceRequest {
	
	private Long id;
	
	@NotNull(message = "Please, select user first!")	
	private Integer userId;
	
	private User user;
	
	@NotNull(message = "Invoice date is required")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date invoiceDate;
	
	@NotNull(message = "Due date is required")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date dueDate;
	
	private String otherInformation;	

    @OneToMany(mappedBy = "invoice", cascade = CascadeType.ALL)
    private List<InvoiceItem> items;
}
