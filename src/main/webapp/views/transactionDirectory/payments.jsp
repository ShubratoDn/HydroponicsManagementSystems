<%@page import="com.hydroponics.management.system.entities.Payment"%>
<%@page import="java.util.Locale"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.hydroponics.management.system.entities.InvoiceItem"%>
<%@page import="com.hydroponics.management.system.entities.Invoice"%>
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
<title>Payments</title>
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
						<h4>Payments</h4>
						<a href="/transaction/create-payment" class="btn btn-primary" style="color:white;"><i class="icon-plus"></i> Create Payment</a>
					</div>
				</div>



				<section class="min-h-80vh bg-white">
				
					<!-- Searching Crietaria -->
				    <div class="d-flex p-20">
				    	<div class="form-group w-100 m-r-20">
				    		<label class="form-label">From</label>
				    		<input type="date" class="form-control"> 
				    	</div>
				    	<div class="form-group w-100 m-r-20">
				    		<label class="form-label">To</label>
				    		<input type="date" class="form-control"> 
				    	</div>
				    	<div class="form-group w-100 m-r-20">
				    		<label class="form-label">Status</label>
				    		<select class="form-control">
				    			<option>--Select Status--</option>
				    			<option>Pending</option>
				    		</select> 
				    	</div>
				    	<div class="w-100 m-r-20">
				    		<button class="btn btn-success"> <i class="icon-magnifier m-r-5"></i> Search</button>
				    	</div>					    
				    </div>
				    
				    
				    
				    <div class="bordered p-10 m-10">
					    <div class="table-responsive">
					        <table class="table table-striped mb-0">
					            <thead>
					                <tr>
					                    <th>#</th>
					                    <th>Payment Number</th>
					                    <th>Invoice Number</th>
					                    <th>User Name</th>
					                    <th>Payment amount</th>
					                    <th>Total Amount</th>					                    
					                    <th>Status</th>
					                    <th>Date</th>
					                    <th class="text-right">Action</th>
					                </tr>
					            </thead>
					            <tbody>
					                <%
					                    List<Payment> paymentList = (List<Payment>) request.getAttribute("paymentList");
					                    if (paymentList != null && paymentList.size() > 0) {
					                        int count = 1;
					                        for (Payment payment : paymentList) {
					                        	Invoice invoice = payment.getInvoice();
					                            %>
					                            <tr>
					                                <td><%= count %></td>
					                                <td>#PAY-00<%=payment.getId() %></td>
					                                <td><a href="/transaction/invoices/<%=invoice.getId()%>">#INV-<%= String.format("%04d", invoice.getId()) %></a></td>
					                                <td><%= invoice.getUser().getFirstName() + " " + invoice.getUser().getLastName() %></td>
					                                <td><%=payment.getAmount() %> Tk</td>
					                                <td><%= calculateTotalAmount(invoice.getItems()) %> Tk.</td>
					                                <td><%=payment.getStatus() %></td>
					                                <td><%= new SimpleDateFormat("dd MMMM, yyyy", Locale.ENGLISH).format(payment.getTimestamp()) %></td>
					                                <td class="text-right">
					                                    <div class="dropdown dropdown-action">
					                                        <a href="#" class="action-icon dropdown-toggle" data-toggle="dropdown" aria-expanded="false"><i class="fa fa-ellipsis-v"></i></a>
					                                        <div class="dropdown-menu dropdown-menu-right">
					                                            <a class="dropdown-item" href="edit-invoice.html"><i class="fa fa-pencil m-r-5"></i> Edit</a>
					                                            <a class="dropdown-item" href="invoice-view.html"><i class="fa fa-eye m-r-5"></i> View</a>
					                                            <a class="dropdown-item" href="#"><i class="fa fa-file-pdf-o m-r-5"></i> Download</a>
					                                            <a class="dropdown-item" href="#" data-toggle="modal" data-target="#delete_invoice"><i class="fa fa-trash-o m-r-5"></i> Delete</a>
					                                        </div>
					                                    </div>
					                                </td>
					                            </tr>
					                            <%
					                            count++;
					                        }
					                    }
					                %>
					            </tbody>
					        </table>
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
