package com.hydroponics.management.system.controllers;


import java.io.File;
import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.hydroponics.management.system.servicesImple.PdfGenerationService;

import jakarta.servlet.http.HttpServletResponse;

@RestController
@RequestMapping("/pdf")
public class PdfController {

    @Autowired
    private PdfGenerationService pdfGenerationService;

    @GetMapping("/generate")
    public ResponseEntity<byte[]> generatePdf(HttpServletResponse response) throws IOException {
        byte[] pdfBytes = pdfGenerationService.generatePdfWithUserData();

//        HttpHeaders headers = new HttpHeaders();
//        headers.setContentType(MediaType.APPLICATION_PDF);
//        headers.setContentDispositionFormData("inline", "generated.pdf");

     // Set response headers
        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "inline; filename=generated.pdf");
        response.getOutputStream().flush();
        
        return ResponseEntity.ok(pdfBytes);
    }
    
    
    @GetMapping("/generate-temp")
    public ResponseEntity<?> generateTemplate(){
    	pdfGenerationService.generatePdfFile();
    	return new ResponseEntity<>("Generated File", HttpStatus.OK);
    }
    
    @GetMapping("/generate-html2pdf")
    public ResponseEntity<?> generateHTMLToPDF(){    	
    	String HTML = "<h1>Test</h1><p>Hello World</p>";
    	String path = "templates/html2pdf.pdf";
    	
    	File file = new File(path);
		file.getParentFile().mkdirs();
    	
    	pdfGenerationService.generatePdfFromHtml(HTML,path );
    	return new ResponseEntity<>("Generated PDF from HTML FILE", HttpStatus.OK);
    }
}
