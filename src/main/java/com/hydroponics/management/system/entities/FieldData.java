package com.hydroponics.management.system.entities;

import java.sql.Timestamp;
import java.util.List;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import lombok.Data;

@Data
@Entity
public class FieldData {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    private Environment environment;

    @OneToMany(mappedBy = "fieldData", cascade = CascadeType.ALL)
    private List<MineralData> mineralDataList;
    

	private Integer lightDuration;
	private Double waterPH;
	private Double temperatureC;
	private Double humidity;

    private Timestamp timestamp = new Timestamp(System.currentTimeMillis());


}
