package com.hydroponics.management.system.controllers;

import org.apache.pdfbox.Loader;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.pdmodel.PDPage;
import org.apache.pdfbox.pdmodel.PDPageContentStream;
import org.apache.pdfbox.pdmodel.font.PDFont;
import org.apache.pdfbox.pdmodel.font.PDType1Font;
import org.apache.pdfbox.pdmodel.font.Standard14Fonts;
import org.apache.pdfbox.pdmodel.font.Standard14Fonts.FontName;
import org.apache.pdfbox.text.PDFTextStripper;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import jakarta.servlet.http.HttpServletResponse;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;

@RestController
public class TestController {

    @GetMapping("/generate/pdfbox")
    public String generatePdfController(HttpServletResponse response) throws IOException {
        this.generatePdf(response);
        return "PDF generated successfully!";
    }

    public void generatePdf(HttpServletResponse response) {
        try {
            PDDocument document = new PDDocument();
            PDPage page = new PDPage();
            document.addPage(page);

            PDPageContentStream contentStream = new PDPageContentStream(document, page);

            PDFont font = new PDType1Font(FontName.HELVETICA_BOLD);

            contentStream.setFont(font, 28);

            contentStream.beginText();
            contentStream.newLineAtOffset(100, 700); // Set the starting position
            contentStream.showText("Hello, this is your PDF!");
            contentStream.endText();
            contentStream.close();

            // Set response headers
            response.setContentType("application/pdf");
            response.setHeader("Content-Disposition", "inline; filename=generated.pdf");

            // Stream the PDF content to the response
            document.save(response.getOutputStream());
            document.close();
            response.getOutputStream().flush();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    
    
    
    public void generatePdf2(HttpServletResponse response) throws IOException {
    	// Load the template PDF
    	// Load from a file path
//    	PDDocument document = Loader.loadPDF(new File("templates/subject.pdf"));


    	try (PDDocument document = Loader.loadPDF(new File("templates/subject.pdf"))) {
            PDPage page = document.getPage(0); // Assuming the template has only one page
            

            PDFTextStripper stripper = new PDFTextStripper();
            stripper.setStartPage(1);
            stripper.setEndPage(1);

            // Extract text content
            String text = stripper.getText(document);
         // Perform text replacement and handle potential line breaks
            String content = text.replace("Enayetpur", "John Doe").replace("\r", " "); // Replace with space for visual separation
            content = content.replace("\n", " \r\n"); // Optional: Handle newlines similarly
            
            System.out.println("\n\n\n"+content);
             
            try(PDPageContentStream contentStream = new PDPageContentStream(document, page, PDPageContentStream.AppendMode.OVERWRITE, true)) {                
            	
                PDFont font = new PDType1Font(FontName.TIMES_BOLD_ITALIC);

                contentStream.setFont(font, 12);

                contentStream.beginText();
                contentStream.newLineAtOffset(50, 700); // Set the starting position
                contentStream.showText(content);
                contentStream.endText();
                contentStream.close();

                // Set response headers
                response.setContentType("application/pdf");
                response.setHeader("Content-Disposition", "inline; filename=generated.pdf");

                // Stream the PDF content to the response
                document.save(response.getOutputStream());
                document.close();
                response.getOutputStream().flush();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }
    
    
    
    public void generatePdf3(HttpServletResponse response) throws IOException {
        try (PDDocument document = Loader.loadPDF(new File("templates/subject.pdf"))) {
            PDPage page = document.getPage(0); // Assuming the template has only one page

            PDFTextStripper stripper = new PDFTextStripper();
            stripper.setStartPage(1);
            stripper.setEndPage(1);

            // Extract text content
            String text = stripper.getText(document);

            // Replace placeholders with data
            text = text.replace("Hello, this is your PDF!", "Hello, this is a modified PDF!");

            try (PDPageContentStream contentStream = new PDPageContentStream(document, page, PDPageContentStream.AppendMode.APPEND, true)) {

                PDFont font = new PDType1Font(FontName.HELVETICA_BOLD);

                contentStream.setFont(font, 28);

                // Set the starting position and add text
                contentStream.beginText();
                contentStream.newLineAtOffset(100, 700);
                contentStream.showText(text);
                contentStream.endText();
                contentStream.close();

                // Set response headers
                response.setContentType("application/pdf");
                response.setHeader("Content-Disposition", "inline; filename=generated.pdf");

                // Stream the PDF content to the response
                document.save(response.getOutputStream());
                document.close();
                response.getOutputStream().flush();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    
    
    public InputStream loadTemplate() throws IOException {
        // Use ClassLoader to load the template from the resources directory
        Resource resource = new ClassPathResource("templates/subject.pdf");
        return resource.getInputStream();
    }
    
    
    
    
}
