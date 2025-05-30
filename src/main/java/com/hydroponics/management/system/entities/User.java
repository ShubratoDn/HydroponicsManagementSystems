package com.hydroponics.management.system.entities;

import java.sql.Timestamp;

import com.fasterxml.jackson.annotation.JsonManagedReference;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class User {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;

	private String firstName;

	private String lastName;

	private String phone;

	private String email;

	@Column(length = 500)
	private String image;

	@Column(length = 250)
	private String address;
	
	private String password;

	@Column(length = 1000)
	private String remark;

	private String role;

	@JsonManagedReference
	@ManyToOne
	@JoinColumn(name = "added_by_user_id")
	private User addedBy;
	

    private Timestamp registrationDate = new Timestamp(System.currentTimeMillis());

}
