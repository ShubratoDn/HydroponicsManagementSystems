package com.hydroponics.management.system.services;

import java.util.List;

import com.hydroponics.management.system.entities.Environment;
import com.hydroponics.management.system.entities.FieldData;

public interface EnvDataServices {

	public FieldData saveData(FieldData fieldData);
	
	public List<FieldData> getAllFieldsData();
	
	public FieldData getFieldDataById(Long id);
	
	public List<FieldData> getFieldDataByEnvironment(Environment environment);

	List<FieldData> getFieldDataByEnvironmentAfterGivenHour(Environment environment, double hour);
	
	public void validateAndNotifyEnvironmentData(Environment environment);
	
	public void validateLastFieldDataAndNotify(FieldData fieldData);
}
