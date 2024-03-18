package com.hydroponics.management.system.services;

public interface SmsServices {
	public boolean sendTestSms();
	
	public boolean sendSms(String phone, String message);
}
