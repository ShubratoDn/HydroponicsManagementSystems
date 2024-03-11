<%@page import="com.hydroponics.management.system.entities.enums.PaymentStatus"%>
<%@page import="com.hydroponics.management.system.entities.Invoice"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.hydroponics.management.system.servicesImple.HelperServices"%>
<%@page import="org.springframework.beans.factory.annotation.Autowired"%>
<%@page import="com.hydroponics.management.system.services.UserServices"%>
<%@page import="com.hydroponics.management.system.entities.InvoiceItem"%>
<%@page import="com.hydroponics.management.system.DTO.InvoiceRequest"%>
<%@page import="org.springframework.validation.ObjectError"%>
<%@page import="org.springframework.validation.FieldError"%>
<%@page import="org.springframework.validation.BindingResult"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.hydroponics.management.system.entities.Notification"%>
<%@page import="com.hydroponics.management.system.payloads.PageableResponse"%>
<%@page import="com.hydroponics.management.system.payloads.ServerMessage"%>
<%@page import="java.util.List"%>


<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
<title>Create Payment</title>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1.0, user-scalable=no">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="description"
	content="Leaf Lab - a Hydroponics Management System solution">
<meta name="keywords"
	content="Hydroponics, Find Environment, Shubrato, Hydroponics Management System, KYAU Hydroponics,  KYAU">
<meta name="author" content="Shubrato Debnath">
<!-- Favicon icon -->
<link rel="shortcut icon" href="${pageContext.request.contextPath}/assets/images/favicon.png"
	type="image/x-icon">
<link rel="icon" href="${pageContext.request.contextPath}/assets/images/favicon.ico" type="image/x-icon">


<!-- Google font-->
<link href="https://fonts.googleapis.com/css?family=Ubuntu:400,500,700"
	rel="stylesheet">

<!-- themify -->
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/assets/icon/themify-icons/themify-icons.css">

<!-- iconfont -->
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/assets/icon/icofont/css/icofont.css">

<!-- simple line icon -->
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/assets/icon/simple-line-icons/css/simple-line-icons.css">

<!-- Required Fremwork -->
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/assets/plugins/bootstrap/css/bootstrap.min.css">

<!-- Chartlist chart css -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/plugins/chartist/dist/chartist.css"
	type="text/css" media="all">

<!-- Weather css -->
<link href="${pageContext.request.contextPath}/assets/css/svg-weather.css" rel="stylesheet">

<!-- Select 2 css -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/plugins/select2/dist/css/select2.min.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/plugins/select2/css/s2-docs.css">

<!-- Style.css -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/main.css">

<!-- Responsive.css-->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/responsive.css">


</head>

<body class="sidebar-mini fixed">
	<div class="loader-bg">
		<div class="loader-bar"></div>
	</div>
	<div class="wrapper">

		<!-- Nav top included -->
		<%@include file="../partials/util/nav-top.jsp"%>

		<!-- side nav bar -->
		<%@include file="../partials/util/sidenav.jsp"%>


		<!-- Side bar chat -->
		<%@include file="../partials/util/sidebar-chat.jsp"%>



		<div class="content-wrapper">
			<!-- Container-fluid starts -->
			<!-- Main content starts -->
			<div class="container-fluid">
				<div class="row">
					<div class="main-header" style="display: flex; justify-content: space-between; padding-right: 30px;">
						<h4>Create Payment</h4>
					</div>
				</div>



				<section class="min-h-80vh bg-white">				
					 <div class="row">
			            <div class="col-sm-12">
			                <form method="post" action="/transaction/create-payment" class="p-20">
			                    <div class="row">			
			                        <!-- User Dropdown -->
			                        <div class="col-sm-12">
										<%
											
											//COUNT											
											int count = 1;

									    	BindingResult inputErrors = null;
											InvoiceRequest invoiceRequest = null;
											
						                    
											invoiceRequest = (InvoiceRequest) request.getAttribute("invoiceRequest");
											UserDTO userInfo = (UserDTO) request.getAttribute("userInfo");
							
											
											ServerMessage msg = (ServerMessage) request.getAttribute("serverMessage");
											if (msg != null) {
												%>
													<div class="alert <%=msg.getClassName()%>">
														<%=msg.getMessage()%>
													</div>
												<%
											}
																						

											if (request.getAttribute("inputErrors") != null) {
											    inputErrors = (BindingResult) request.getAttribute("inputErrors");

											    if (inputErrors.hasErrors()) {
											        
											            %>
											            	<ul class="alert alert-danger">
																<%
																for (FieldError fieldError : inputErrors.getFieldErrors()) {
														            %>
														            	<li>
																			<%=fieldError.getDefaultMessage()%>
																		</li>
														            <%
														        }
																%>
															</ul>
											            <%
											        
											    }
											}
										%>
										
										
										<div class="form-group">
			                                <label>Select Invoice <span class="text-danger">*</span></label>
			                                <select class="form-control" name="invoiceId" id="user_select">
			                                    <option value="">--- Select Invoice ---</option>			                                    
			                                    <%
			                                    	List<Invoice> invoiceList = (List<Invoice>) request.getAttribute("invoiceList");
			                                    	if(invoiceList != null && invoiceList.size() > 0){
			                                    		for(Invoice invoice: invoiceList){
			                                    			%>
			                                    				<option  value="<%=invoice.getId()%>">#INV- <%=String.format("%03d", invoice.getId())%> || Name : <%=invoice.getUser().getFirstName() +" " + invoice.getUser().getLastName() %> || Address : <%=invoice.getUser().getAddress()%></option>
			                                    			<%
			                                    		}
			                                    	}
			                                    %>			                          			
			                                </select>
			                            </div>
			                        </div>
			
			 						<!-- Department Dropdown -->
			 						
			 						<div class="col-sm-6 col-md-3">
			                            <div class="form-group">
			                                <label>Invoice Number <span class="text-danger">*</span></label>
			                                <input class="form-control" type="text" id="invoice_number" >
			                            </div>
			                        </div>
			 						
			 						
			                        <div class="col-sm-6 col-md-3">
			                            <div class="form-group">
			                                <label>User Full Name <span class="text-danger">*</span></label>
			                                <input class="form-control" type="text" id="user_fullname" value="<%=userInfo != null ? userInfo.getFirstName() + " " + userInfo.getLastName() : ""%>">
			                            </div>
			                        </div>
			                        
			                        <!-- Department Dropdown -->
			                        <div class="col-sm-6 col-md-3">
			                            <div class="form-group">
			                                <label>Phone <span class="text-danger">*</span></label>
			                                <input class="form-control" value="<%=userInfo != null ? userInfo.getPhone() : ""%>" type="text" id="user_phone" >
			                            </div>
			                        </div>
			
			                        <div class="col-sm-6 col-md-3">
			                            <div class="form-group">
			                                <label>Email</label>
			                                <input class="form-control" type="text" value="<%=userInfo != null ? userInfo.getEmail() : ""%>" id="user_email">
			                            </div>
			                        </div>
			                        
			                        <div class="col-sm-12 col-md-6">
			                            <div class="form-group">
			                                <label>User Address</label>
			                                <input class="form-control" type="text" value="<%=userInfo != null ? userInfo.getAddress() : ""%>" id="user_address">
			                            </div>
			                        </div>
			                        
									<div class="col-sm-6 col-md-6">
			                            <div class="form-group">
			                                <label> Current Payment Status <span class="text-danger"></span></label>
			
			                                <input class="form-control" type="text" disabled="disabled" id="current_payment_status" >
			
			                            </div>
			                        </div>									
								
									
			                        <div class="col-sm-6 col-md-3">
			                            <div class="form-group">
			                                <label>Total Invoice amount <span class="text-danger"></span></label>
			
			                                <input class="form-control" type="text" disabled="disabled" id="total_invoice_cost">
			
			                            </div>
			                        </div>
			                        
			                        <div class="col-sm-12 col-md-6">
			                            <div class="form-group">
			                                <label>Amount in words <span class="text-danger"></span></label>
			
			                                <input class="form-control" type="text" disabled="disabled" id="total_invoice_cost_spell">
			
			                            </div>
			                        </div>
			                        
			                    </div>
			                    <div class="row">
			                        <div class="col-md-12 col-sm-12 border m-l-10 m-r-10">
			                            <h5>Payment information</h5>
				                         <div class="col-sm-6 col-md-3">
				                            <div class="form-group">
				                                <label>Payment Amount <span class="text-danger"></span></label>				
				                                <input class="form-control" type="number" name="amount">				
				                            </div>
				                        </div>
				                        
				                        <div class="col-sm-6 col-md-3">
				                            <div class="form-group">
				                                <label>Payment Status <span class="text-danger"></span></label>				
				                                <select class="form-control" name="status">
				                                	<option value="PAID"> Paid</option>
				                                	<option value="UNPAID"> Unpaid</option>
				                                	<option value="PARTIAL_PAID"> Partial Paid</option>
				                                </select>
				                            </div>
				                        </div>
			                            
			                        </div>
			                    </div>
			                    <div class="text-center m-t-20">
			                        <button type="submit" class="btn btn-primary p-l-20 p-r-20">Add Payment</button>
			                    </div>
			                </form>
			            </div>
			        </div>
				    
				</section>
			
			</div>
		</div>
	</div>

	<!-- Required Jqurey -->
	<script src="${pageContext.request.contextPath}/assets/plugins/Jquery/dist/jquery.min.js"></script>
	<script src="${pageContext.request.contextPath}/assets/plugins/jquery-ui/jquery-ui.min.js"></script>
	<script src="${pageContext.request.contextPath}/assets/plugins/tether/dist/js/tether.min.js"></script>
	
	<!-- Select 2 js -->
   <script src="${pageContext.request.contextPath}/assets/plugins/select2/dist/js/select2.full.min.js"></script>
	

	<!-- Required Fremwork -->
	<script src="${pageContext.request.contextPath}/assets/plugins/bootstrap/js/bootstrap.min.js"></script>

	<!-- Scrollbar JS-->
	<script src="${pageContext.request.contextPath}/assets/plugins/jquery-slimscroll/jquery.slimscroll.js"></script>
	<script src="${pageContext.request.contextPath}/assets/plugins/jquery.nicescroll/jquery.nicescroll.min.js"></script>

	<!--classic JS-->
	<script src="${pageContext.request.contextPath}/assets/plugins/classie/classie.js"></script>

	<!-- notification -->
	<script src="${pageContext.request.contextPath}/assets/plugins/notification/js/bootstrap-growl.min.js"></script>

	<!-- Sparkline charts -->
	<script src="${pageContext.request.contextPath}/assets/plugins/jquery-sparkline/dist/jquery.sparkline.js"></script>

	<!-- Counter js  -->
	<script src="${pageContext.request.contextPath}/assets/plugins/waypoints/jquery.waypoints.min.js"></script>
	<script src="${pageContext.request.contextPath}/assets/plugins/countdown/js/jquery.counterup.js"></script>

	<!-- Echart js -->
	<script src="${pageContext.request.contextPath}/assets/plugins/charts/echarts/js/echarts-all.js"></script>

	<!-- custom js -->
	<script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/main.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/assets/pages/dashboard.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/assets/pages/elements.js"></script>
	<script src="${pageContext.request.contextPath}/assets/js/menu.min.js"></script>
	
	

	 <!-- Web Socket -->    
    <script src="assets/plugins/websocket/sockjs.min.js"></script>
    <script src="assets/plugins/websocket/stomp.min.js"></script>    

    <script type="text/javascript">
        // Include the base context path in a JavaScript variable
        var contextPath = '<%= request.getContextPath() %>';
        var userId = '<%=loggedUser != null ? loggedUser.getId() : null %>';
    </script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/notification.js"></script>
	
	
	
		
	<script>	
	    $(document).ready(function() {	    	
	    	$("#user_select").select2();	    	
	    	$("#user_select").on("change", function(){
	    		// Make an AJAX request to the server
	            $.ajax({
	                type: 'GET',
	                url: '/api/invoice/'+$("#user_select").val(),
	                data:"",
	                success: function (data) {
	                    console.log(data);
	                    $("#invoice_number").val("#INV-00"+data.id);
	                    
	                    
	                    $("#user_fullname").val(data.user.firstName + " " + data.user.lastName);
	                    $("#user_phone").val(data.user.phone);
	                    $("#user_email").val(data.user.email);
	                    $("#user_address").val(data.user.address);
	                    
	                    
	                    let totalAmount = calculateInvoiceTotalAmount(data.items);
	                    $("#total_invoice_cost").val(totalAmount+" Tk.");
	                    $("#total_invoice_cost_spell").val(spellNumber(totalAmount));
	                    $("#current_payment_status").val(data.status);
	                    
	                    //neuro_science
	                    
	                },
	                error: function (error) {
	                    console.error('Error:', error);
	                }
	            }); 
	    	})	
	    	
	    	
	    	function calculateInvoiceTotalAmount(items){
	    		let total = 0;
	    		
	    		items.forEach((item)=>{
	    			total = total + (item.itemPrice * item.quantity);
	    		})
	    			    		
	    		return total;
	    	}
	    	
	    	
	    	
	    	function spellNumber(number) {
	    	    const units = ['', 'one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine'];
	    	    const teens = ['', 'eleven', 'twelve', 'thirteen', 'fourteen', 'fifteen', 'sixteen', 'seventeen', 'eighteen', 'nineteen'];
	    	    const tens = ['', 'ten', 'twenty', 'thirty', 'forty', 'fifty', 'sixty', 'seventy', 'eighty', 'ninety'];
	    	    const thousands = ['', 'thousand', 'million', 'billion'];

	    	    function convertChunk(chunk) {
	    	        const hundred = Math.floor(chunk / 100);
	    	        const remainder = chunk % 100;

	    	        let result = '';

	    	        if (hundred > 0) {
	    	            result += units[hundred] + ' hundred';
	    	            if (remainder > 0) {
	    	                result += ' and ';
	    	            }
	    	        }

	    	        if (remainder > 0) {
	    	            if (remainder < 10) {
	    	                result += units[remainder];
	    	            } else if (remainder < 20) {
	    	                result += teens[remainder - 10];
	    	            } else {
	    	                const ten = Math.floor(remainder / 10);
	    	                const unit = remainder % 10;

	    	                result += tens[ten];
	    	                if (unit > 0) {
	    	                    result += '-' + units[unit];
	    	                }
	    	            }
	    	        }

	    	        return result;
	    	    }

	    	    if (number === 0) {
	    	        return 'zero';
	    	    }

	    	    let result = '';
	    	    let chunkCount = 0;

	    	    while (number > 0) {
	    	        const chunk = number % 1000;
	    	        if (chunk > 0) {
	    	            result = convertChunk(chunk) + ' ' + thousands[chunkCount] + ' ' + result;
	    	        }

	    	        number = Math.floor(number / 1000);
	    	        chunkCount++;
	    	    }

	    	    return result.trim();
	    	}

	    });
	</script>
	
	
</body>
</html>
