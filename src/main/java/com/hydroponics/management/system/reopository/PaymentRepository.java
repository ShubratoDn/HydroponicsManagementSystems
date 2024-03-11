package com.hydroponics.management.system.reopository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.hydroponics.management.system.entities.Payment;

public interface PaymentRepository extends JpaRepository<Payment, Long> {

}
