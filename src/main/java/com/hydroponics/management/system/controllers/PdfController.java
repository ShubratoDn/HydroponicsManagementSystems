package com.hydroponics.management.system.controllers;


import java.io.File;
import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ContentDisposition;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import com.hydroponics.management.system.servicesImple.PdfGenerationService;

import jakarta.servlet.http.HttpServletResponse;

@Controller
//@RequestMapping("/pdf")
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
    
    
    @GetMapping("/generate-dynamicPdf")
    public String generateJSPToPDF(){    
    	
    	String BASEURI = "src/main/webapp/views/";
    	String SRC = String.format("%sDELETE_ME.jsp", BASEURI);
    	
    	String TARGET = "templates/";
    	String DEST = String.format("%shtml2pdf.pdf", TARGET);
    	
    	
    	
    	File file = new File(DEST);
		file.getParentFile().mkdirs();
    	
//    	pdfGenerationService.generatePdfFromHtml(HTML,path);
		try {
			pdfGenerationService.createPdf(SRC, DEST);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	return "DELETE_ME";
    }
    
    
    
    
    @GetMapping("/pdf/invoice-view/{id}")
    public ResponseEntity<?> generateInvoiceView(@PathVariable("id") Long id, HttpServletResponse response) {
        byte[] pdfBytes = pdfGenerationService.generateInvoiceView(id);

        if(pdfBytes == null) {
        	return new ResponseEntity<>("INVOICE NOT FOUND", HttpStatus.NOT_FOUND);
        }
        
        // Set response headers
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_PDF);
        headers.setContentDisposition(ContentDisposition.builder("inline").filename("generated.pdf").build());

        return ResponseEntity.ok()
                .headers(headers)
                .body(pdfBytes);
    }
    
    @GetMapping("/invoice-view")
    public String generateInvoiceTemplate( HttpServletResponse response) {

        return "DELETE_ME";
    }
    
}
