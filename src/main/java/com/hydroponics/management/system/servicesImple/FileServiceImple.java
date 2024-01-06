package com.hydroponics.management.system.servicesImple;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.security.SecureRandom;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.hydroponics.management.system.services.FileServices;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class FileServiceImple implements FileServices {

	//uploading user file
	public String uploadFile(MultipartFile file, String upload_directory) {
	

		//Random text generate
		SecureRandom random = new SecureRandom();
        byte[] randomBytes = new byte[20];
        random.nextBytes(randomBytes);

        StringBuilder sb = new StringBuilder();
        for (byte b : randomBytes) {
            sb.append(String.format("%02x", b));
        }
        
        String randomHexCode = sb.toString();        
        String fileExtension = file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf("."));
        String fileName = randomHexCode+"_"+fileExtension;
        
	
		try {
			File f = new File(upload_directory);
			f.mkdir();
			
			InputStream inputStream = file.getInputStream();
			byte[] data = new byte[inputStream.available()];
			inputStream.read(data);
			
			FileOutputStream fos = new FileOutputStream(upload_directory+File.separator+fileName);
			fos.write(data);
			
			fos.flush();
			fos.close();			
			
			return fileName;
			
		}catch (Exception e) {
			log.error("File Upload fail Because : ");
			log.error(e.toString());
			return null;
		}		
	}
	
	
}
