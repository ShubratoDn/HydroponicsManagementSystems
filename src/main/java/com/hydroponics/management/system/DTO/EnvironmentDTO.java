package com.hydroponics.management.system.DTO;

import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.validation.annotation.Validated;

import com.hydroponics.management.system.entities.Location;
import com.hydroponics.management.system.entities.Mineral;
import com.hydroponics.management.system.entities.User;

import jakarta.validation.constraints.DecimalMax;
import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Validated
public class EnvironmentDTO {

    private Long id;

    @NotBlank(message = "Plant name is required")
    private String plantName;

    @NotNull(message = "Selecting the owner is required")    
    private User ownedBy;

    @NotNull(message = "Location is required")    
    private Location location;

    @NotNull(message = "Plant date is required")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date plantDate;

    @NotNull(message = "Maturity date is required")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date maturityDate;

    @NotNull(message = "Light duration is required")
    @Min(value = 1, message = "Light duration must be greater than 0")
    private Integer lightDuration;

    @NotNull(message = "Water pH is required")
    @DecimalMin(value = "0.0", message = "Water pH must be greater than or equal to 0")
    @DecimalMax(value = "14.0", message = "Water pH must be less than or equal to 14")
    private Double waterPH;

    @NotNull(message = "Temperature is required")
    @DecimalMin(value = "-100.0", message = "Temperature must be greater than or equal to -100")
    @DecimalMax(value = "100.0", message = "Temperature must be less than or equal to 100")
    private Double temperatureC;

    @NotNull(message = "Humidity is required")
    @DecimalMin(value = "0.0", message = "Humidity must be greater than or equal to 0")
    @DecimalMax(value = "100.0", message = "Humidity must be less than or equal to 100")
    private Double humidity;

    private List<Mineral> minerals;
    
    private User addedEnvironmentBy;

    @Override
    public String toString() {
        return "EnvironmentDTO [id=" + id + ", plantName=" + plantName + ", ownedBy=" + ownedBy + ", location="
                + location + ", plantDate=" + plantDate + ", maturityDate=" + maturityDate + ", lightDuration="
                + lightDuration + ", waterPH=" + waterPH + ", temperatureC=" + temperatureC + ", humidity=" + humidity
                + ", minerals=" + minerals + "]";
    }
}
