package com.hydroponics.management.system.entities;

import java.math.BigDecimal;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import lombok.Getter;
import lombok.Setter;

@Entity
@Getter
@Setter
public class InvoiceItem {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String itemName;
    
    private String description;

    private String unitName;
    
    private BigDecimal itemPrice;

    private Double quantity;

    @ManyToOne
    @JoinColumn(name = "invoice_id")
    private Invoice invoice;
}
