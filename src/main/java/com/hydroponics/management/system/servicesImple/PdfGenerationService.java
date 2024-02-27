package com.hydroponics.management.system.servicesImple;

import com.itextpdf.forms.PdfAcroForm;

import com.itextpdf.forms.fields.PdfFormField;
import com.itextpdf.html2pdf.HtmlConverter;
import com.itextpdf.kernel.geom.PageSize;
import com.itextpdf.kernel.pdf.PdfDocument;
import com.itextpdf.kernel.pdf.PdfReader;
import com.itextpdf.kernel.pdf.PdfWriter;
import com.itextpdf.kernel.pdf.canvas.parser.PdfCanvasProcessor;
import com.itextpdf.layout.Document;
import com.itextpdf.layout.element.Paragraph;
import org.springframework.stereotype.Service;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;

@Service
public class PdfGenerationService {

    public byte[] generatePdf() {
        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();

        try (PdfWriter writer = new PdfWriter(outputStream);
             PdfDocument pdfDocument = new PdfDocument(writer)) {

            Document document = new Document(pdfDocument);
            document.add(new Paragraph("Hello, this is a sample PDF generated using iText 7 Core in Spring Boot."));

        } catch (Exception e) {
            e.printStackTrace();
        }

        return outputStream.toByteArray();
    }
    
    
    
    
    public byte[] generatePdfWithUserData() {
        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();

        try (PdfWriter writer = new PdfWriter(outputStream);
                 PdfDocument pdfDocument = new PdfDocument(writer);
                 PdfDocument templatePdf = new PdfDocument(new PdfReader(getClass().getResourceAsStream("/templates/subject.pdf")))) {

            // Create a new document based on the template
            Document document = new Document(pdfDocument);
//
//            // Get the form fields from the template
//            PdfAcroForm form = PdfAcroForm.getAcroForm(templatePdf, true);
//            PdfFormField userNameField = form.getField("Enayetpur");
//            PdfFormField userAddressField = form.getField("Enayetpur");
//            PdfFormField userIdField = form.getField("Enayetpur");
//
//            // Set the values in the form fields
//            userNameField.setValue("X");
//            userAddressField.setValue("F");
//            userIdField.setValue(String.valueOf("D"));

            // Copy all pages from the template to the new document
//            templatePdf.copyPagesTo(1, templatePdf.getNumberOfPages(), pdfDocument);

            // Add additional content if needed
            document.add(new Paragraph("Additional content goes here."));

        } catch (IOException e) {
            e.printStackTrace();
        }

        return outputStream.toByteArray();
    }

    
    
    
    
    
    public void generatePdfFile() {
    	String path = "templates/invoice.pdf";
    	try {
			PdfWriter writer = new PdfWriter(new File(path));
			PdfDocument pdfDocument = new PdfDocument(writer);
			pdfDocument.setDefaultPageSize(PageSize.A4);
			
			Document document = new Document(pdfDocument);
			document.add(new Paragraph("Hey Bro Fuck"));
			
			document.close();			
			
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }
    
    
    
    public void generatePdfFromHtml(String htmlContent, String outputPath) {
        try {
            HtmlConverter.convertToPdf(htmlContent, new FileOutputStream(outputPath));            
        } catch (IOException e) {
            // Handle exception
            e.printStackTrace();
        }
    }
    
    
}

