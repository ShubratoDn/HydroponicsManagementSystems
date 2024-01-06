package com.hydroponics.management.system.services;

import org.springframework.web.multipart.MultipartFile;


public interface FileServices {

	public String uploadFile(MultipartFile file, String filePath);
	
}
