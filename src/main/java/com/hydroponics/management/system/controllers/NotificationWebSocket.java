package com.hydroponics.management.system.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.web.bind.annotation.RestController;


@RestController
public class NotificationWebSocket {

	@Autowired
	private SimpMessagingTemplate simpMessagingTemplate;

	@MessageMapping("/application")
	@SendTo("/global/messages")
	public String send(String message) throws Exception {
		return message;
	}

	
	@MessageMapping("/notification/{to}/{message}")
	public void sendMessage(@DestinationVariable int to, @DestinationVariable String message) {
		System.out.println("handling send message: " + message + " to: " + to);
		simpMessagingTemplate.convertAndSend("/specific/notification/" + to, message);
	}

}
