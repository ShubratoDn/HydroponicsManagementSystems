package com.hydroponics.management.system.entities;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import lombok.Data;

@Entity
@Data
public class Location {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	
	private String locationName;
	
	private String fullAddress;
	
	private Double length;
	
	private Double width;
	
	private boolean isAvailable;
	
	private String note;	
}
