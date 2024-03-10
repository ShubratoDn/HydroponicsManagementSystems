<%@page import="com.hydroponics.management.system.entities.InvoiceItem"%>
<%@page import="java.util.Locale"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.hydroponics.management.system.entities.Invoice"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.hydroponics.management.system.entities.Notification"%>
<%@page import="com.hydroponics.management.system.payloads.PageableResponse"%>
<%@page import="com.hydroponics.management.system.payloads.ServerMessage"%>
<%@page import="java.util.List"%>


<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    
<%
	 Invoice invoice = (Invoice) request.getAttribute("invoice");					
%>
<!DOCTYPE html>
<html>
<head>
<title>Invoice - #INV-<%= String.format("%04d", invoice.getId())%> </title>
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
						<h4>Invoices</h4>
						<div class="col-sm-7 col-8 text-right m-b-30">
	                        <div class="btn-group btn-group-sm">	                            
	                            <a href="/pdf/invoice-view/<%=invoice.getId() %>" target="blank"  class="btn btn-info">PDF</a>
	                            <a href="/pdf/invoice-view/<%=invoice.getId() %>" target="blank" class="btn btn-primary"><i class="fa fa-print fa-lg"></i> Print</a>
	                        </div>
	                    </div>
					</div>
				</div>
					
			

				<section class="min-h-80vh bg-white">				
					<div class="content">		                
		                <div class="row">
		                    <div class="col-md-12">
		                        <div class="card">
		                            <div class="card-body">
		                                <div class="row custom-invoice p-l-20 p-r-20 p-t-20 ">
		                                    <div class="col-8 col-sm-8 m-b-20">
		                                        <img src="${pageContext.request.contextPath}/assets/images/favicon.png" class="inv-logo" alt="" style="width: 60px">
		                                        <ul class="list-unstyled">
		                                            <li class="font-bold"><b>LeafLab</b></li>
		                                            <li>Hydroponics Management System </li>
		                                            <li>Enayetpur, Sirajganj, Bangladesh</li>		                                            
		                                        </ul>
		                                    </div>
		                                    <div class="col-4 col-sm-4 m-b-20">
		                                        <div class="invoice-details">
		                                            <h3 class="text-uppercase">Invoice #INV-<%= String.format("%04d", invoice.getId()) %></h3>
		                                             <ul class="list-unstyled">
				                                        <li>Date: <span><%= new SimpleDateFormat("MMMM dd, yyyy", Locale.ENGLISH).format(invoice.getInvoiceDate()) %></span></li>
				                                        <li>Due date: <span><%= new SimpleDateFormat("MMMM dd, yyyy", Locale.ENGLISH).format(invoice.getDueDate()) %></span></li>
				                                    </ul>
		                                        </div>
		                                    </div>
		                                </div>
		                                <div class="row p-20">
		                                    <div class="col-sm-8 col-lg-8 m-b-20">
												
													<h5>Invoice to:</h5>
													 <ul class="list-unstyled">
					                                    <li>
					                                        <h5><strong><%= invoice.getUser().getFirstName() + " " + invoice.getUser().getLastName() %></strong></h5>
					                                    </li>
					                                    <li><span><%= invoice.getUser().getAddress() != null ? invoice.getUser().getAddress() :"" %></span></li>
					                                    <li><%= invoice.getUser().getPhone() != null? invoice.getUser().getPhone() : ""%></li>
					                                    <li><a href="#"><%= invoice.getUser().getEmail() != null ? invoice.getUser().getEmail() : "" %></a></li>
					                                </ul>
												
		                                    </div>
		                                    <div class="col-sm-4 col-lg-4 m-b-20">
												<div class="invoices-view">
													<span class="text-muted">Payment Details:</span>
													 <ul class="list-unstyled invoice-payment-details">
				                                        <li>
				                                            <h5>Total Due: TK. <span class="text-right"><%= calculateTotalAmount(invoice.getItems()) %></span></h5>
				                                        </li>
				                                        <li>Status: <%= invoice.getStatus() %></li>
				                                    </ul>
												</div>
		                                    </div>
		                                </div>
		                                <div class="table-responsive">
		                                    <table class="table table-striped table-hover">
		                                        <thead>
		                                            <tr>
		                                                <th>#</th>
		                                                <th>ID</th>
		                                                <th>ITEM</th>
		                                                <th>DESCRIPTION</th>
		                                                <th>UNIT COST</th>
		                                                <th>QUANTITY</th>
		                                                <th>TOTAL</th>
		                                            </tr>
		                                        </thead>
		                                        <tbody>		                                        
		                                        	<%
		                                        	 	int count = 1;
		                                        		for(InvoiceItem invoiceItem : invoice.getItems()){
		                                        			%>
		                                        			<tr>
				                                                <td><%=count %></td>
				                                                <td>#ITEM-<%=invoiceItem.getId() %></td>
				                                                <td><%=invoiceItem.getItemName() %></td>
				                                                <td><%=invoiceItem.getDescription() != null ? invoiceItem.getDescription() : "" %></td>
				                                                <td><%=invoiceItem.getItemPrice() +" Tk / " + invoiceItem.getUnitName() %></td>
				                                                <td><%=invoiceItem.getQuantity() + " "+ invoiceItem.getUnitName()%></td>
				                                                <td><%=invoiceItem.getItemPrice() != null && invoiceItem.getQuantity() != null ? (new java.math.BigDecimal(invoiceItem.getItemPrice().toString()).multiply(new java.math.BigDecimal(invoiceItem.getQuantity().toString()))) + " Tk" : "---" %></td>
				                                            </tr>
		                                        			<%
		                                        			count++;
		                                        		}
		                                        	%>		                                            
		                                        </tbody>
		                                    </table>
		                                </div>
		                                <div>
		                                    <div class="row invoice-payment">
		                                        <div class="col-sm-7">
		                                        </div>
		                                        <div class="col-sm-5">
		                                            <div class="m-b-20">
		                                                <h6>Total due</h6>
		                                                <div class="table-responsive no-border">
		                                                    <table class="table mb-0">
		                                                        <tbody>		                                                           
		                                                            <tr>
		                                                                <th>Total:</th>
		                                                                <td class="text-right text-primary">
		                                                                    <h5>Tk. <%= calculateTotalAmount(invoice.getItems()) %></h5>
																		</td>
																		<td></td>																		
		                                                            </tr>
		                                                        </tbody>
		                                                    </table>
		                                                </div>
		                                            </div>
		                                        </div>
		                                    </div>
		                                    <div class="invoice-info p-l-20 p-r-20">
		                                        <h5>Other information</h5>
		                                        <p class="text-muted"><%=invoice.getOtherInformation() != null ? invoice.getOtherInformation() : "" %></p>
		                                    </div>
		                                </div>
		                            </div>
		                        </div>
		                    </div>
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
	
</body>

</html>



<%!
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
%>
