package com.hydroponics.management.system.servicesImple;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Locale;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hydroponics.management.system.entities.Invoice;
import com.hydroponics.management.system.entities.InvoiceItem;
import com.hydroponics.management.system.services.TransactionServices;
import com.itextpdf.html2pdf.ConverterProperties;
import com.itextpdf.html2pdf.HtmlConverter;
import com.itextpdf.kernel.geom.PageSize;
import com.itextpdf.kernel.pdf.PdfDocument;
import com.itextpdf.kernel.pdf.PdfWriter;
import com.itextpdf.layout.Document;
import com.itextpdf.layout.element.Paragraph;

@Service
public class PdfGenerationService {
	
	@Autowired
	private TransactionServices transactionServices;

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
    	
    	Invoice invoice = transactionServices.getInvoiceById(id);
    	if(invoice == null) {
    		return null;
    	}
    	
    	
    	String invoiceItemsData = "";    	
    	
	 	int count = 1;
		for(InvoiceItem invoiceItem : invoice.getItems()){
			String invoiceDescription = invoiceItem.getDescription() != null ? invoiceItem.getDescription() :""; 
//			String price = invoiceItem.getItemPrice() != null && invoiceItem.getQuantity() != null ? (new java.math.BigDecimal(invoiceItem.getItemPrice().toString()).multiply(new java.math.BigDecimal(invoiceItem.getQuantity().toString()))) +" Tk" : "---";
			
			BigDecimal itemPrice = invoiceItem.getItemPrice();
			Double quantity = invoiceItem.getQuantity();

			String price = "---"; // Default value if either itemPrice or quantity is null

			if (itemPrice != null && quantity != null) {
			    BigDecimal totalPrice = itemPrice.multiply(BigDecimal.valueOf(quantity));
			    DecimalFormat decimalFormat = new DecimalFormat("#0.00");
			    price = decimalFormat.format(totalPrice) + " Tk";
			}
			
			invoiceItemsData = invoiceItemsData + "<tr>\r\n"
					+ "                <td>"+count+"</td>\r\n"
					+ "                <td>#ITEM-"+invoiceItem.getId()+"</td>\r\n"
					+ "                <td>"+invoiceItem.getItemName()+"</td>\r\n"
					+ "                <td>"+invoiceDescription+"</td>\r\n"
					+ "                <td>"+invoiceItem.getItemPrice()+" Tk " + invoiceItem.getUnitName()+"</td>\r\n"
					+ "                <td>"+invoiceItem.getQuantity()+" "+ invoiceItem.getUnitName()+"</td>\r\n"
					+ "                <td>"+price+"</td>\r\n"
					+ "            </tr>";
			
			count++;
		}
	
		String otherInformation = invoice.getOtherInformation() != null ? invoice.getOtherInformation() : "";
    	
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
    			+ "								<li class=\"font-bold\"><h4>LeafLab</h4></li>\r\n"
    			+ "								<li>Hydroponics Management System</li>\r\n"
    			+ "								<li>Enayetpur, Sirajganj, Bangladesh</li>\r\n"
    			+ "							</ul>\r\n"
    			+ "						</div>\r\n"
    			+ "					</td>\r\n"
    			+ "					<td>\r\n"
    			+ "						<div class=\"invoice-info\">\r\n"
    			+ "							<div class=\"invoice-details\">\r\n"
    			+ "								<h3 class=\"text-uppercase\">Invoice #INV-00"+String.format("%03d", invoice.getId())+"</h3>\r\n"
    			+ "								<ul class=\"list-unstyled\">\r\n"
    			+ "									<li><strong>Date:</strong> <span>"+new SimpleDateFormat("MMMM dd, yyyy", Locale.ENGLISH).format(invoice.getInvoiceDate())+"</span></li>\r\n"
    			+ "									<li>Due date: <span>"+new SimpleDateFormat("MMMM dd, yyyy", Locale.ENGLISH).format(invoice.getDueDate())+"</span></li>\r\n"
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
    			+ "										<strong>"+invoice.getUser().getFirstName() + " " + invoice.getUser().getLastName()+"</strong>\r\n"
    			+ "									</h5>\r\n"
    			+ "								</li>\r\n"
    			+ "								<li><span>"+invoice.getUser().getAddress()+"</span></li>\r\n"
    			+ "								<li>"+invoice.getUser().getPhone()+"</li>\r\n"
    			+ "								<li><a href=\"#\">"+invoice.getUser().getEmail()+"</a></li>\r\n"
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
    			+ "										Total Due: TK. <span class=\"text-right\">"+calculateTotalAmount(invoice.getItems())+"</span>\r\n"
    			+ "									</h5>\r\n"
    			+ "								</li>\r\n"
    			+ "								<li>Status: "+invoice.getStatus()+"</li>\r\n"
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
    			+ "\r\n"+invoiceItemsData
    			+ "					</tbody>\r\n"
    			+ "				</table>\r\n"
    			+ "			</div>\r\n"
    			+ "			<div>\r\n"
    			+ "				<table class=\"table\"\r\n"
    			+ "							style=\"width: 50%; margin-right: 0; margin-left: auto;\">\r\n"
    			+ "							<tr>\r\n"
    			+ "								<th colspan=\"\">Total Due</th>\r\n"
    			+ "							</tr>\r\n"
    			+ "							<tr>\r\n"
    			+ "								<td>Total</td>\r\n"
    			+ "								<td>"+calculateTotalAmount(invoice.getItems())+" Tk</td>\r\n"
    			+ "							</tr>\r\n"
    			+ "						</table>"
    			+ "				<div class=\"invoice-info p-l-20 p-r-20\">\r\n"
    			+ "					<h5>Other information</h5>\r\n"
    			+"<p class=\"text-muted\" style=\"background-color: white;\">"+otherInformation+"</p>"
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

    double calculateTotalAmount(List<InvoiceItem> items) {
        double totalAmount = 0;
        if (items != null) {
            for (InvoiceItem item : items) {
                if (item.getItemPrice() != null && item.getQuantity() != null) {
                    totalAmount += item.getItemPrice().doubleValue() * item.getQuantity();
                }
            }
        }
        return totalAmount;
    }
    
}

