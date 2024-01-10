package com.hydroponics.management.system.services;

import java.util.Random;

import org.springframework.stereotype.Service;

@Service
public class HelperServices {

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
	
}
