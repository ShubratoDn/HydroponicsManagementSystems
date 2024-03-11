package com.hydroponics.management.system.entities;

import java.sql.Timestamp;

import com.hydroponics.management.system.entities.enums.PaymentStatus;

import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.ManyToOne;
import lombok.Getter;
import lombok.Setter;

@Entity
@Getter
@Setter
public class Payment {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	
	@ManyToOne
	private Invoice invoice;
	
	@Enumerated(EnumType.STRING)
	private PaymentStatus status;
	
	private Double amount;
	
	private Timestamp timestamp = new Timestamp(System.currentTimeMillis());

	@Override
	public String toString() {
		return "Payment [id=" + id + ", invoice=" + invoice + ", status=" + status + ", amount=" + amount
				+ ", timestamp=" + timestamp + "]";
	}
	
	
}
