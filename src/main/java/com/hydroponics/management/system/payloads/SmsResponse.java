package com.hydroponics.management.system.payloads;

import lombok.Getter;
import lombok.Setter;

import com.fasterxml.jackson.annotation.JsonProperty;

@Getter
@Setter
public class SmsResponse {
    @JsonProperty("response_code")
    private int responseCode;

    @JsonProperty("message_id")
    private long messageId;

    @JsonProperty("success_message")
    private String successMessage;

    @JsonProperty("error_message")
    private String errorMessage;

    public SmsResponse() {
        // Default constructor required by Jackson
    }

    // Getters and setters for the fields
}
