package com.hydroponics.management.system.payloads;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PaymentRequest {

	private Long id;
	
	private Long invoiceId;
	
	private Double amount;
	
	private String status;
	
}
