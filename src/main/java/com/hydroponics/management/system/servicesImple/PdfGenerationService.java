package com.hydroponics.management.system.servicesImple;

import com.itextpdf.forms.PdfAcroForm;

import com.itextpdf.forms.fields.PdfFormField;
import com.itextpdf.html2pdf.ConverterProperties;
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
import java.io.FileInputStream;
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
        
        try (
        		PdfWriter writer = new PdfWriter(outputStream);
        		PdfDocument pdfDocument = new PdfDocument(writer);
                 ) {

        	pdfDocument.setDefaultPageSize(PageSize.A4);
    		
    		Document document = new Document(pdfDocument);
    		document.add(new Paragraph("Hey Bro Fuck"));
    		document.add(new Paragraph("Additional content goes here."));
    		document.close();	            

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
    
    
//    public void createPdf(String baseUri, String html, String dest) throws IOException {
//        ConverterProperties properties = new ConverterProperties();
//        properties.setBaseUri(baseUri);
//        HtmlConverter.convertToPdf(html, new FileOutputStream(dest), properties);
//    }
    
    
    public void createPdf(String baseUri, String src, String dest) throws IOException {
        ConverterProperties properties = new ConverterProperties();
        properties.setBaseUri(baseUri);
        HtmlConverter.convertToPdf(
            new FileInputStream(src), new FileOutputStream(dest), properties);
    }
    
    
    public void createPdf(String src, String dest) throws IOException {
        HtmlConverter.convertToPdf(new File(src), new File(dest));
    }
    
    
    //generate Invoice view
    public byte[] generateInvoiceView(Long id) {
    	ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
    	String HTML =  "\r\n"
    			+ "<!DOCTYPE html>\r\n"
    			+ "<html>\r\n"
    			+ "<head>\r\n"
    			+ "<title>Invoice</title>\r\n"
    			+ "<meta charset=\"utf-8\">\r\n"
    			+ "<meta name=\"viewport\"\r\n"
    			+ "	content=\"width=device-width, initial-scale=1, maximum-scale=1.0, user-scalable=no\">\r\n"
    			+ "\r\n"
    			+ "<!-- Google font-->\r\n"
    			+ "<link href=\"https://fonts.googleapis.com/css?family=Ubuntu:400,500,700\"\r\n"
    			+ "	rel=\"stylesheet\">\r\n"
    			+ "\r\n"
    			+ "<!-- Required Fremwork -->\r\n"
    			+ "<link rel=\"stylesheet\" type=\"text/css\"\r\n"
    			+ "	href=\"src/main/resources/static/assets/plugins/bootstrap/css/bootstrap.min.css\">\r\n"
    			+ "\r\n"
    			+ "<!-- Style.css -->\r\n"
    			+ "<link rel=\"stylesheet\" type=\"text/css\"\r\n"
    			+ "	href=\"src/main/resources/static/assets/css/main.css\">\r\n"
    			+ "\r\n"
    			+ "<!-- Responsive.css-->\r\n"
    			+ "<link rel=\"stylesheet\" type=\"text/css\"\r\n"
    			+ "	href=\"src/main/resources/static/assets/css/responsive.css\">\r\n"
    			+ "\r\n"
    			+ "\r\n"
    			+ "</head>\r\n"
    			+ "\r\n"
    			+ "<body style=\"background-color: white\">\r\n"
    			+ "	<section class=\"min-h-80vh\">\r\n"
    			+ "		<div class=\"content\" style=\"background-color: white\">\r\n"
    			+ "\r\n"
    			+ "\r\n"
    			+ "			<table class=\"invoice-info-table\">\r\n"
    			+ "				<tr>\r\n"
    			+ "					<td>\r\n"
    			+ "						<div class=\"company-info\">\r\n"
    			+ "							<img\r\n"
    			+ "								src=\"src/main/resources/static/assets/images/favicon.png\"\r\n"
    			+ "								class=\"inv-logo\" alt=\"\" style=\"width: 60px\">\r\n"
    			+ "							<ul class=\"list-unstyled\">\r\n"
    			+ "								<li class=\"font-bold\"><b>LeafLab</b></li>\r\n"
    			+ "								<li>Hydroponics Management System</li>\r\n"
    			+ "								<li>Enayetpur, Sirajganj, Bangladesh</li>\r\n"
    			+ "							</ul>\r\n"
    			+ "						</div>\r\n"
    			+ "					</td>\r\n"
    			+ "					<td>\r\n"
    			+ "						<div class=\"invoice-info\">\r\n"
    			+ "							<div class=\"invoice-details\">\r\n"
    			+ "								<h3 class=\"text-uppercase\">Invoice #INV-001</h3>\r\n"
    			+ "								<ul class=\"list-unstyled\">\r\n"
    			+ "									<li>Date: <span>2014-01-3</span></li>\r\n"
    			+ "									<li>Due date: <span>2012-2-1</span></li>\r\n"
    			+ "								</ul>\r\n"
    			+ "							</div>\r\n"
    			+ "						</div>\r\n"
    			+ "					</td>\r\n"
    			+ "				</tr>\r\n"
    			+ "\r\n"
    			+ "\r\n"
    			+ "\r\n"
    			+ "				<tr>\r\n"
    			+ "					<td>\r\n"
    			+ "						<div>\r\n"
    			+ "\r\n"
    			+ "							<h5>Invoice to:</h5>\r\n"
    			+ "							<ul class=\"list-unstyled\">\r\n"
    			+ "								<li>\r\n"
    			+ "									<h5>\r\n"
    			+ "										<strong>Shurato Debnath</strong>\r\n"
    			+ "									</h5>\r\n"
    			+ "								</li>\r\n"
    			+ "								<li><span>Gopinathpur, Enayetpur, Sirajganj</span></li>\r\n"
    			+ "								<li>01759458961</li>\r\n"
    			+ "								<li><a href=\"#\">Shubratodn44985@gmail.com</a></li>\r\n"
    			+ "							</ul>\r\n"
    			+ "\r\n"
    			+ "						</div>\r\n"
    			+ "					</td>\r\n"
    			+ "					<td>\r\n"
    			+ "						<div class=\"invoices-view\">\r\n"
    			+ "							<span class=\"text-muted\">Payment Details:</span>\r\n"
    			+ "							<ul class=\"list-unstyled invoice-payment-details\">\r\n"
    			+ "								<li>\r\n"
    			+ "									<h5>\r\n"
    			+ "										Total Due: TK. <span class=\"text-right\">1000</span>\r\n"
    			+ "									</h5>\r\n"
    			+ "								</li>\r\n"
    			+ "								<li>Status: Unpaid</li>\r\n"
    			+ "							</ul>\r\n"
    			+ "						</div>\r\n"
    			+ "					</td>\r\n"
    			+ "\r\n"
    			+ "				</tr>\r\n"
    			+ "\r\n"
    			+ "			</table>\r\n"
    			+ "<br>\r\n"
    			+ "\r\n"
    			+ "			<div class=\"table-responsive\">\r\n"
    			+ "				<table class=\"table table-striped table-hover\">\r\n"
    			+ "					<thead>\r\n"
    			+ "						<tr>\r\n"
    			+ "							<th>#</th>\r\n"
    			+ "							<th>ID</th>\r\n"
    			+ "							<th>ITEM</th>\r\n"
    			+ "							<th>DESCRIPTION</th>\r\n"
    			+ "							<th>UNIT COST</th>\r\n"
    			+ "							<th>QUANTITY</th>\r\n"
    			+ "							<th>TOTAL</th>\r\n"
    			+ "						</tr>\r\n"
    			+ "					</thead>\r\n"
    			+ "					<tbody>\r\n"
    			+ "\r\n"
    			+ "					</tbody>\r\n"
    			+ "				</table>\r\n"
    			+ "			</div>\r\n"
    			+ "			<div>\r\n"
    			+ "				<div class=\"row invoice-payment\">\r\n"
    			+ "					<div class=\"col-sm-7\"></div>\r\n"
    			+ "					<div class=\"col-sm-5\">\r\n"
    			+ "						<div class=\"m-b-20\">\r\n"
    			+ "							<h6>Total due</h6>\r\n"
    			+ "							<div class=\"table-responsive no-border\">\r\n"
    			+ "								<table class=\"table mb-0\">\r\n"
    			+ "									<tbody>\r\n"
    			+ "										<tr>\r\n"
    			+ "											<th>Total:</th>\r\n"
    			+ "											<td class=\"text-right text-primary\">\r\n"
    			+ "												<h5>Tk.</h5>\r\n"
    			+ "											</td>\r\n"
    			+ "											<td></td>\r\n"
    			+ "										</tr>\r\n"
    			+ "									</tbody>\r\n"
    			+ "								</table>\r\n"
    			+ "							</div>\r\n"
    			+ "						</div>\r\n"
    			+ "					</div>\r\n"
    			+ "				</div>\r\n"
    			+ "				<div class=\"invoice-info p-l-20 p-r-20\">\r\n"
    			+ "					<h5>Other information</h5>\r\n"
    			+"<p class=\"text-muted\" style=\"background-color: white;\">This is other information</p>"
    			+ "				</div>\r\n"
    			+ "			</div>\r\n"
    			+ "		</div>\r\n"
    			+ "\r\n"
    			+ "	</section>\r\n"
    			+ "\r\n"
    			+ "</body>\r\n"
    			+ "\r\n"
    			+ "</html>\r\n"
    			+ "\r\n"
    			+ "\r\n"
    			+ "\r\n"
    			+ "\r\n"
    			+ "";
    	
    	
    	try {
            // Use iText or any PDF generation library to convert HTML to PDF and write to the outputStream
            // For example, using iText 7:
            HtmlConverter.convertToPdf(HTML, outputStream);
        } catch (com.itextpdf.io.IOException e) {
            e.printStackTrace();
        }

        return outputStream.toByteArray();  	
    }
    
}

