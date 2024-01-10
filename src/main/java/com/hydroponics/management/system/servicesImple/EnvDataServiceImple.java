package com.hydroponics.management.system.servicesImple;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hydroponics.management.system.entities.Environment;
import com.hydroponics.management.system.entities.FieldData;
import com.hydroponics.management.system.entities.MineralData;
import com.hydroponics.management.system.reopository.FieldDataRepository;
import com.hydroponics.management.system.reopository.MineralDataRepository;
import com.hydroponics.management.system.services.EnvDataServices;

@Service
public class EnvDataServiceImple implements EnvDataServices {

	@Autowired
	private FieldDataRepository fielDataRepository;
	
	@Autowired
	private MineralDataRepository mineralDataRepository;
	
	//saving data
	@Override
	public FieldData saveData(FieldData fieldData) {
		FieldData fieldSave = fielDataRepository.save(fieldData);
		
		List<MineralData> mineralDatas = new ArrayList<>();
		
		for(MineralData mineralData : fieldData.getMineralDataList()) {
			mineralData.setFieldData(fieldSave);
			MineralData mineralSave = mineralDataRepository.save(mineralData);
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

	
}
