package com.hydroponics.management.system.payloads;

import java.util.List;

import lombok.Data;

@Data
public class EnvFormData {
    private Long environmentId;
    private Integer lightDuration;
    private Double waterPH;
    private Double temperatureC;
    private Double humidity;
    private List<EnvMineralData> minerals;

}
