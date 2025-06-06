package com.hydroponics.management.system.payloads;


import java.sql.Timestamp;

import org.springframework.web.multipart.MultipartFile;

import com.hydroponics.management.system.entities.User;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.Size;
import lombok.Data;

@Data
public class UpdateUserForm {

    private Integer id;

    @NotEmpty(message = "First name is required")
    @Size(min = 3, message = "First name must be at least 3 characters")
    private String firstName;

    @NotEmpty(message = "Last name is required")
    @Size(min = 3, message = "Last name must be at least 3 characters")
    private String lastName;

    
    @Size(min = 11, max = 14, message = "Phone number must be between 11 and 14 characters")
    private String phone;

    @NotBlank(message = "Email is required")
    @Email(message = "Invalid email format")
    private String email;

    @NotBlank(message = "Address is required")
    private String address;
    
    private MultipartFile file;

    private String image;
    
    
    private String password;

    
    private String confirmPassword;

    @NotBlank(message = "Role is required")    
    private String role;
    
    private User addedBy;
    
    private Timestamp registrationDate;
    
    private String remark;

    @Override
    public String toString() {
        return "UserDTO [firstName=" + firstName + ", lastName=" + lastName + ", phone=" + phone + ", email=" + email
                + ", address=" + address + ", password=" + password + ", confirmPassword=" + confirmPassword + "]";
    }
}
