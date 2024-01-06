package com.hydroponics.management.system.entities;

import java.util.Date;
import java.util.List;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import lombok.Data;

@Data
@Entity
public class Environment {
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
	private String plantName;	
	@ManyToOne
	private User ownedBy;
	@ManyToOne
	private Location location;
	private Date plantDate;
	private Date maturityDate;
	private Integer lightDuration;
	private Double waterPH;
	private Double temperatureC;
	private Double humidity;
	
	@OneToMany(mappedBy = "environment", cascade = CascadeType.ALL)
	private List<Mineral> minerals;
	
	@ManyToOne
	private User addedEnvironmentBy;
	
}
