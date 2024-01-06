package com.hydroponics.management.system.configs;

import org.modelmapper.ModelMapper;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.hydroponics.management.system.annotation.LoginRequireInterceptor;
import com.hydroponics.management.system.annotation.PreAuthorizedInterceptor;

//In your Spring MVC configuration class (e.g., WebMvcConfig)
@Configuration
public class WebMvcConfig implements WebMvcConfigurer {

	@Bean
	ModelMapper modelMapper() {
		return new ModelMapper();
	}
	
	
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		registry.addInterceptor(new PreAuthorizedInterceptor());
        registry.addInterceptor(new LoginRequireInterceptor());
	}
}
