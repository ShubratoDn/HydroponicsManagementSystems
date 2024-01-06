package com.hydroponics.management.system.payloads;

public class HydroponicsFormData {
	private String plantName;
	private String nutrientSolution;
	private double phLevel;
	private double waterTemperature;
	private int lightDuration;
	private double nitrogen;
	private double phosphorus;
	private double potassium;
	public String getPlantName() {
		return plantName;
	}
	public void setPlantName(String plantName) {
		this.plantName = plantName;
	}
	public String getNutrientSolution() {
		return nutrientSolution;
	}
	public void setNutrientSolution(String nutrientSolution) {
		this.nutrientSolution = nutrientSolution;
	}
	public double getPhLevel() {
		return phLevel;
	}
	public void setPhLevel(double phLevel) {
		this.phLevel = phLevel;
	}
	public double getWaterTemperature() {
		return waterTemperature;
	}
	public void setWaterTemperature(double waterTemperature) {
		this.waterTemperature = waterTemperature;
	}
	public int getLightDuration() {
		return lightDuration;
	}
	public void setLightDuration(int lightDuration) {
		this.lightDuration = lightDuration;
	}
	public double getNitrogen() {
		return nitrogen;
	}
	public void setNitrogen(double nitrogen) {
		this.nitrogen = nitrogen;
	}
	public double getPhosphorus() {
		return phosphorus;
	}
	public void setPhosphorus(double phosphorus) {
		this.phosphorus = phosphorus;
	}
	public double getPotassium() {
		return potassium;
	}
	public void setPotassium(double potassium) {
		this.potassium = potassium;
	}
	@Override
	public String toString() {
		return "HydroponicsFormData [plantName=" + plantName + ", nutrientSolution=" + nutrientSolution + ", phLevel="
				+ phLevel + ", waterTemperature=" + waterTemperature + ", lightDuration=" + lightDuration
				+ ", nitrogen=" + nitrogen + ", phosphorus=" + phosphorus + ", potassium=" + potassium + "]";
	}

	
	
}
