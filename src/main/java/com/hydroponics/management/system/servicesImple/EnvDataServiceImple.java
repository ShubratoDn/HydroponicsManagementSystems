package com.hydroponics.management.system.servicesImple;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hydroponics.management.system.configs.Constants;
import com.hydroponics.management.system.entities.Environment;
import com.hydroponics.management.system.entities.FieldData;
import com.hydroponics.management.system.entities.MineralData;
import com.hydroponics.management.system.entities.enums.NotificationType;
import com.hydroponics.management.system.reopository.FieldDataRepository;
import com.hydroponics.management.system.reopository.MineralDataRepository;
import com.hydroponics.management.system.reopository.MineralRepository;
import com.hydroponics.management.system.services.EnvDataServices;
import com.hydroponics.management.system.services.NotificationServices;

@Service
public class EnvDataServiceImple implements EnvDataServices {

	@Autowired
	private FieldDataRepository fielDataRepository;
	
	@Autowired
	private MineralDataRepository mineralDataRepository;
	
	@Autowired
	private NotificationServices notificationServices;
	
	@Autowired
	private MineralRepository mineralRepository;

	
	//saving data
	@Override
	public FieldData saveData(FieldData fieldData) {
		FieldData fieldSave = fielDataRepository.save(fieldData);
		
		List<MineralData> mineralDatas = new ArrayList<>();
		
		for(MineralData mineralData : fieldData.getMineralDataList()) {
			mineralData.setFieldData(fieldSave);
			MineralData mineralSave = mineralDataRepository.save(mineralData);
			mineralSave.setMineral(mineralRepository.findById(mineralSave.getMineral().getId()).get());
			mineralDatas.add(mineralSave);
		}
		
		fieldSave.setMineralDataList(mineralDatas);
		
		return fieldSave;
	}
	
	
	//getting all fields data
	@Override
	public List<FieldData> getAllFieldsData() {
		List<FieldData> findAll = fielDataRepository.findAll();
		return findAll;
	}

	@Override
	public FieldData getFieldDataById(Long id) {
		FieldData fieldData = fielDataRepository.findById(id).get();
		if(fieldData != null) {
			return fieldData;
		}
		return null;
	}


	@Override
	public List<FieldData> getFieldDataByEnvironment(Environment environment) {
		List<FieldData> findByEnvironment = fielDataRepository.findByEnvironment(environment);
		return findByEnvironment;
	}

	
	@Override
	public List<FieldData> getFieldDataByEnvironmentAfterGivenHour(Environment environment, double hour) {		
		Timestamp now = new Timestamp(System.currentTimeMillis());
		Timestamp twentyFourHoursAgo = new Timestamp(now.getTime() - ((long) hour * 60 * 60 * 1000));

		List<FieldData> recentFieldData = fielDataRepository.findByEnvironmentAndTimestampAfter(environment, twentyFourHoursAgo);

		return recentFieldData;
	}


	@Override
	public void validateAndNotifyEnvironmentData(Environment environment) {
		List<FieldData> fieldDataList = this.getFieldDataByEnvironmentAfterGivenHour(environment,
				Constants.NOTIFICATION_TIME_INTERVAL_HOUR);
		@SuppressWarnings("unused")
		int flag = 1;
		for (int i = 0; i < fieldDataList.size(); i++) {
		    FieldData fieldData = fieldDataList.get(i);			
			notificationServices.checkAndNotifyError(fieldData.getHumidity(), environment.getHumidity(), "humidity",
					NotificationType.INVALID_HUMIDITY_ERROR, environment);
			notificationServices.checkAndNotifyError(fieldData.getWaterPH(), environment.getWaterPH(), "water pH",
					NotificationType.INVALID_WATER_pH_ERROR, environment);
			notificationServices.checkAndNotifyError(fieldData.getTemperatureC(), environment.getTemperatureC(), "temperature",
					NotificationType.INVALID_TEMPERATURE_ERROR, environment);

			List<MineralData> mineralDataList = fieldData.getMineralDataList();
			
			
			for (MineralData mineralData : mineralDataList) {	

				notificationServices.checkMineralAndNotifyError(mineralData.getMineralValue(), mineralData.getMineral().getMineralAmount(), mineralData.getMineral().getMineralName(), NotificationType.INVALID_MINERAL_ERROR, environment);
				
		    }
			// Skip the last MineralData
		    if (i == fieldDataList.size() - 2) {
		        System.out.println("Skipping the last MineralData");
		        break;
		    }
		    flag++;
		}
		
	}

	

	//validating kore notification send korbe
	@Override
	public void validateLastFieldDataAndNotify(FieldData fieldDataParam) {
		
		FieldData fieldData = this.getFieldDataById(fieldDataParam.getId());
		fieldData.setMineralDataList(null);
		
		Environment environment = fieldData.getEnvironment();		
		notificationServices.checkAndNotifyError(fieldData.getHumidity(), environment.getHumidity(), "humidity",
				NotificationType.INVALID_HUMIDITY_ERROR, environment);
		notificationServices.checkAndNotifyError(fieldData.getWaterPH(), environment.getWaterPH(), "water pH",
				NotificationType.INVALID_WATER_pH_ERROR, environment);
		notificationServices.checkAndNotifyError(fieldData.getTemperatureC(), environment.getTemperatureC(), "temperature",
				NotificationType.INVALID_TEMPERATURE_ERROR, environment);

		
		List<MineralData> mineralDataList = mineralDataRepository.findByFieldData(fieldData);
		
		for (MineralData mineralData : mineralDataList) {
//		    System.out.println("Mineral ID: " + mineralData.getMineral().getId());
//		    System.out.println("Mineral Value: " + mineralData.getMineralValue());
//		    System.out.println("Mineral Amount: " + mineralData.getMineral().getMineralAmount());
//		    System.out.println("Mineral Name: " + mineralData.getMineral().getMineralName());

			notificationServices.checkMineralAndNotifyError(mineralData.getMineralValue(), mineralData.getMineral().getMineralAmount(), mineralData.getMineral().getMineralName(), NotificationType.INVALID_MINERAL_ERROR, environment);
			
	    }
		
	}

	
}
