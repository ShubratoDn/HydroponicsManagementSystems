package com.hydroponics.management.system.payloads;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@Data
@NoArgsConstructor
public class ServerMessage {

	private String message;
	
	private String type;
	
	private String className;
}
