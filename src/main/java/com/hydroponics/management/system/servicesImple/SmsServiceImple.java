package com.hydroponics.management.system.servicesImple;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.hydroponics.management.system.configs.Constants;
import com.hydroponics.management.system.payloads.SmsResponse;
import com.hydroponics.management.system.services.SmsServices;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class SmsServiceImple implements SmsServices {

	@Autowired
	private ObjectMapper objectMapper;

	@Override
	public boolean sendTestSms() {
		if (Constants.IS_PERMITTED_SENDING_SMS) {
			sendSMS("01759458961",
					"./\"\'This is : CHARACTER set () test * . % . ;message from Hydroponics Management System, by shubrato");
		}
		return false;
	}

	public void sendSMS(String receiver, String message) {
		String apiKey = Constants.SMS_API_KEY;
		String senderId = Constants.SMS_SENDER_ID;

		try {
			String url = UriComponentsBuilder.fromUriString("http://bulksmsbd.net/api/smsapi")
					.queryParam("api_key", apiKey).queryParam("senderid", senderId).queryParam("number", receiver)
					.queryParam("message", message).build().toUriString();

			RestTemplate restTemplate = new RestTemplate();
			String responseString = restTemplate.getForObject(url, String.class);
			
			
//			String responseString = "{\"response_code\":202,\"message_id\":14904493,\"success_message\":\"SMS Submitted Successfully 1\",\"error_message\":\"\"}";
//			System.out.println(responseString);			
			
			SmsResponse response = objectMapper.readValue(responseString, SmsResponse.class);
			if (response != null && response.getResponseCode() == 202) {
				log.info("SMS sent successfully");
			} else {
				log.error("Failed to send sms: " + response.getErrorMessage());
			}
		} catch (Exception e) {
			e.printStackTrace();
			log.error("ERROR while sending sms: " + e.getMessage());
		}
	}

}
