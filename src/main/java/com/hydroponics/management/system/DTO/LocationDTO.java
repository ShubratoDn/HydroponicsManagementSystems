package com.hydroponics.management.system.DTO;

import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.DecimalMin;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class LocationDTO {

    private Long id;

    @NotEmpty(message = "Enter location name.")
    private String locationName;

    @NotEmpty(message = "Enter full address")
    private String fullAddress;

    @NotNull(message = "Please, enter length size.")
    @DecimalMin(value = "1", message = "Length should be minimum 1 meter")
    private Double length;

    @NotNull(message = "Please, enter width size.")
    @DecimalMin(value = "1", message = "Width should be minimum 1 meter")
    private Double width;

    private Boolean isAvailable;

    private String note;

    @Override
    public String toString() {
        return "LocationDTO [id=" + id + ", locationName=" + locationName + ", fullAddress=" + fullAddress + ", length="
                + length + ", width=" + width + ", isAvailable=" + isAvailable + ", note=" + note + "]";
    }
}
