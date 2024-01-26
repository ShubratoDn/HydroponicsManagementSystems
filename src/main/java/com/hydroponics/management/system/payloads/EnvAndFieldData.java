package com.hydroponics.management.system.payloads;

import java.util.List;

import com.hydroponics.management.system.entities.Environment;
import com.hydroponics.management.system.entities.FieldData;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class EnvAndFieldData {
	private Environment environment;
	private List<FieldData> fieldData;
}
