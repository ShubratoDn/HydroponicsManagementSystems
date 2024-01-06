package com.hydroponics.management.system.controllers;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.HttpStatusCode;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.hydroponics.management.system.entities.Environment;
import com.hydroponics.management.system.entities.FieldData;
import com.hydroponics.management.system.entities.Mineral;
import com.hydroponics.management.system.entities.MineralData;
import com.hydroponics.management.system.payloads.EnvFormData;
import com.hydroponics.management.system.payloads.EnvMineralData;
import com.hydroponics.management.system.payloads.ServerMessage;
import com.hydroponics.management.system.services.EnvDataServices;
import com.hydroponics.management.system.services.EnvironmentServices;

@Controller
public class DataGeneratorController {

	@Autowired
	private EnvironmentServices environmentServices;
	
	@Autowired
	private EnvDataServices envDataServices;
	
	@GetMapping(value = {"/generate-data/", "/generate-data"})
	public String generateDataPage(Model model) {
		List<Environment> allEnvironments = environmentServices.getAllEnvironments();
		model.addAttribute("environmentList", allEnvironments);
		return "dataGenerate/generate-data";
	}
	

	@PostMapping("/generate-data/")
    public String uploadData(@ModelAttribute EnvFormData formData, RedirectAttributes attributes) {
		
		Environment environment = environmentServices.getEnvironmentById(formData.getEnvironmentId());
		
		List<MineralData> mineralDatas = new ArrayList<>();
		
		for(EnvMineralData envMineralData :formData.getMinerals()) {			
			Mineral mineral = new Mineral();
			mineral.setId(envMineralData.getMineralId());
			
			MineralData md = new MineralData();
			md.setMineral(mineral);
			md.setMineralValue(envMineralData.getMineralAmount());
			
			mineralDatas.add(md);
		}
		
		
		FieldData fieldData = new FieldData();
		fieldData.setEnvironment(environment);
		fieldData.setHumidity(formData.getHumidity());
		fieldData.setLightDuration(formData.getLightDuration());
		fieldData.setTemperatureC(formData.getTemperatureC());
		fieldData.setWaterPH(formData.getWaterPH());
		fieldData.setMineralDataList(mineralDatas);
		
		
		
	    
	    FieldData saveData = envDataServices.saveData(fieldData);
	    if(saveData != null) {	    	
	    	attributes.addFlashAttribute("serverMessage", new ServerMessage("Added data for environment ENV_" + saveData.getEnvironment().getId(), "success", "alert-success"));
	    }else {
	    	attributes.addFlashAttribute("serverMessage", new ServerMessage("Error! Demo data added failed.", "error", "alert-danger"));
	    }
	    	    
        return "redirect:/generate-data"; // Adjust success page as per your project
    }
	
	
	
	@GetMapping("/data/getFieldsData")
	public ResponseEntity<?> getFieldsData(){
		List<FieldData> allFieldsData = envDataServices.getAllFieldsData();
		return ResponseEntity.ok(allFieldsData);
	}

	
	@GetMapping("/generate-data/environment/{envId}")
	public ResponseEntity<?> generateEnvironmentFakedata(@PathVariable Long envId){
//		
//		double generateRandomValue = generateRandomValue(0, 5, 10);
		Environment environment = environmentServices.getEnvironmentById(envId);
		if(environment == null) {
			return new ResponseEntity<>("Environment Not FOUND", HttpStatus.NOT_FOUND);
		}
		
		FieldData fieldData = new FieldData();
		fieldData.setEnvironment(environment);
		fieldData.setLightDuration(environment.getLightDuration());
		fieldData.setWaterPH(generateRandomValue(environment.getWaterPH(), 5,5));
		fieldData.setTemperatureC(generateRandomValue(environment.getTemperatureC(), 5,5));
		fieldData.setHumidity(generateRandomValue(environment.getHumidity(), 5, 5));		
		
		//creating mineral Data list
		List<MineralData> mineralDataList = new ArrayList<>();		
		for(Mineral mineral : environment.getMinerals()) {
			MineralData mineralData = new MineralData();
			mineralData.setFieldData(fieldData);
			mineralData.setMineral(mineral);
			mineralData.setMineralValue(generateRandomValue(mineral.getMineralAmount(), 5, 5));			
			mineralDataList.add(mineralData);
		}
		
		fieldData.setMineralDataList(mineralDataList);
		
		
		FieldData saveData = envDataServices.saveData(fieldData);
		
		
		return ResponseEntity.ok(saveData);
	}
	
	
	
	//generated random value
    double generateRandomValue(double actualValue, int decreasePercent, int increasePercent) {
    	double decreaseValue = actualValue - (actualValue * (decreasePercent/100.0));
    	double increaseValue = actualValue + (actualValue * (increasePercent/100.0));
    	
    	double generateRandomNumber = generateRandomNumber(decreaseValue, increaseValue);
    	
    	System.out.println("DECREASE VALUE IS " + decreaseValue);
    	System.out.println("InCrease VALUE IS " + increaseValue);
    	System.out.println("Random number is " + generateRandomNumber);
    	return generateRandomNumber;
    }
   
    
    public double generateRandomNumber(double minValue, double maxValue) {
        if (minValue >= maxValue) {
//            throw new IllegalArgumentException("minValue must be less than maxValue");
        	return 0;
        }

        Random random = new Random();
        return minValue + (maxValue - minValue) * random.nextDouble();
    }
    
}
