package com.hydroponics.management.system.servicesImple;

import java.text.DecimalFormat;
import java.util.Date;
import java.util.Random;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.hydroponics.management.system.DTO.UserDTO;
import com.hydroponics.management.system.entities.User;

import jakarta.servlet.http.HttpSession;

@Service
public class HelperServices {
	
	@Autowired
	private ModelMapper modelMapper;

	//generated random value
    public double generateRandomValue(double actualValue, int decreasePercent, int increasePercent) {
    	double decreaseValue = actualValue - (actualValue * (decreasePercent/100.0));
    	double increaseValue = actualValue + (actualValue * (increasePercent/100.0));
    	
    	double generateRandomNumber = generateRandomNumber(decreaseValue, increaseValue);
    	return generateRandomNumber;
    }
    
    public double givenPercentIncrease(double actualValue, double percent) {
    	double increaseValue = actualValue + (actualValue * (percent/100.0));
    	return increaseValue;
    }
    
    public double givenPercentDecrease(double actualValue, double percent) {
    	double decreaseValue = actualValue - (actualValue * (percent/100.0));
    	return decreaseValue;
    }
   
   
    
    public double generateRandomNumber(double minValue, double maxValue) {
        if (minValue >= maxValue) {
        	return 0;
        }

        Random random = new Random();
        return minValue + (maxValue - minValue) * random.nextDouble();
    }
    
    
    public boolean isValidFieldData(double actualValue, double baseValue, double percent ) {    	
    	double minValue = baseValue - (baseValue * (percent/100.0));
    	double maxValue = baseValue + (baseValue * (percent/100.0));
    	
//    	System.out.println("\n\n\n");
//    	System.out.println("Actual value : " + actualValue);
//    	System.out.println("Base value : " + baseValue);
//    	System.out.println("Increase : " + maxValue);
//    	System.out.println("Decrease " + minValue);
    	
    	if(actualValue >= minValue && actualValue <= maxValue) {
//    		System.out.println("TRUE");
    		return true;
    	}else {
//    		System.out.println("FALSE");
    		return false;
    	}
    	
    }
    
    
    
    
    public User getLoggedUser() {
        ServletRequestAttributes attr = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
        HttpSession session = attr.getRequest().getSession(false);

        if (session != null) {
        	User user = modelMapper.map((UserDTO) session.getAttribute("loggedUser"), User.class);
        	if(user  != null) {
        		return user;
        	}else {
        		return null;
        	}
        }

        return null;
    }
    
    
 // Assuming this method is part of your service class
 // Assuming this method is part of your service class
    public double calculateCompletionPercentage(Date plantingDate, Date maturityDate) {
        // Get the current date
        Date currentDate = new Date();

        // Calculate the total duration in milliseconds
        long totalDuration = maturityDate.getTime() - plantingDate.getTime();

        // Calculate the elapsed duration in milliseconds
        long elapsedDuration = currentDate.getTime() - plantingDate.getTime();

        // Calculate the percentage completion
        double completionPercentage = ((double) elapsedDuration / totalDuration) * 100;

        // Ensure the percentage is within the valid range (0% to 100%)
        completionPercentage = Math.min(Math.max(completionPercentage, 0.0), 100.0);

        // Format the result to have two decimal places
        DecimalFormat decimalFormat = new DecimalFormat("#.##");
        return Double.parseDouble(decimalFormat.format(completionPercentage));
    }
	
}
