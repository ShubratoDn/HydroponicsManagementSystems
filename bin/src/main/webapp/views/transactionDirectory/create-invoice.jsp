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
<title>Create Invoice</title>
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
						<h4>Create Invoice</h4>
					</div>
				</div>



				<section class="min-h-80vh bg-white">				
					 <div class="row">
			            <div class="col-sm-12">
			                <form method="post" action="/transaction/create-invoice" class="p-20">
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
			                                <label>Select User <span class="text-danger">*</span></label>
			                                <select class="form-control" name="userId" id="user_select">
			                                    <option value="">--Select User--</option>			                                    
			                                    <%
			                                    	List<UserDTO> userList = (List<UserDTO>) request.getAttribute("userList");
			                                    	if(userList.size() > 0){
			                                    		for(UserDTO userDTO: userList){
			                                    			%>
			                                    				<option <%=invoiceRequest != null && invoiceRequest.getUserId() != null ? (userDTO.getId() == invoiceRequest.getUserId() ? "selected" :"") :"" %> value="<%=userDTO.getId()%>">ID: <%=userDTO.getId() %> || Name: <%=userDTO.getFirstName() + " "+ userDTO.getLastName() %> || Address: <%=userDTO.getAddress() %> || Role: <%=userDTO.getRole() %></option>
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
			                                <label>Full Name <span class="text-danger">*</span></label>
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
			                        
			                        <div class="col-sm-6 col-md-3">
			                            <div class="form-group">
			                                <label>User Address</label>
			                                <input class="form-control" type="text" value="<%=userInfo != null ? userInfo.getAddress() : ""%>" id="user_address">
			                            </div>
			                        </div>
			
			                        <div class="col-sm-6 col-md-3">
			                            <div class="form-group">
			                                <label>Invoice date <span class="text-danger">*</span></label>
			
			                                <input class="form-control" type="date" name="invoiceDate" value="<%=invoiceRequest != null ? formatDate(invoiceRequest.getInvoiceDate()): ""%>">
			
			                            </div>
			                        </div>
			                        <div class="col-sm-6 col-md-3">
			                            <div class="form-group">
			                                <label>Due Date <span class="text-danger">*</span></label>
			                                <input class="form-control" type="date" name="dueDate" value="<%=invoiceRequest != null ? formatDate(invoiceRequest.getDueDate()) : ""%>">
			                            </div>
			                        </div>
			                         <div class="col-sm-12">
			                            <div class="form-group">
			                                <label>Other Information <span class="text-danger"></span></label>
			                                <textarea class="form-control" rows="" cols="" name="otherInformation"><%=invoiceRequest != null? invoiceRequest.getOtherInformation():"" %></textarea>
			                            </div>
			                        </div>
			                    </div>
			                    <div class="row">
			                        <div class="col-md-12 col-sm-12">
			                            <div class="table-responsive bordered">
			                                <table class="table table-hover table-white">
			                                    <thead>
			                                        <tr>
			                                            <th >#</th>
			                                            <th >Item Name</th>
			                                            <th >Description</th>
			                                            <th >Unit type</th>
			                                            <th >Unit Cost</th>
			                                            <th >Quantity</th>
			                                            <th>Amount</th>
			                                        </tr>
			                                    </thead>
			                                    <tbody id="invoice-table">
			                                    <%
			                                    	if(invoiceRequest != null && invoiceRequest.getItems().size()>0){
			                                    		for(InvoiceItem invoiceItem: invoiceRequest.getItems()){
			                                    			%>
			                                    			<tr>
					                                        	<td><%=count %></td>
					                                        	<td><input value="<%=invoiceItem.getItemName() != null ? invoiceItem.getItemName() : ""  %>" type="text" class="form-control" placeholder="Item name" name="items[<%=count %>].itemName"></td>
					                                        	<td><input value="<%=invoiceItem.getDescription() != null ? invoiceItem.getDescription() : ""  %>" type="text" class="form-control" placeholder="Description" name="items[<%=count %>].description"></td>
					                                        	<td><input value="<%=invoiceItem.getUnitName() != null ? invoiceItem.getUnitName() : ""  %>" type="text" class="form-control" placeholder="Unit Type (kg/piece/...)" name="items[<%=count %>].unitName"></td>
					                                        	<td><input value="<%=invoiceItem.getItemPrice() != null ? invoiceItem.getItemPrice() : ""  %>" type="number" style="max-width: 110px" class="form-control unit-cost" placeholder="Unit Cost" name="items[<%=count %>].itemPrice"></td>
					                                        	<td><input value="<%=invoiceItem.getQuantity() != null ? invoiceItem.getQuantity() : ""  %>" type="number" style="max-width: 110px" class="form-control quantity" placeholder="Quantity" name="items[<%=count %>].quantity"></td>					                                        	
    															<td><input type="text" style="max-width: 110px" class="form-control amount" value="<%=invoiceItem.getItemPrice() != null && invoiceItem.getQuantity() != null ? (new java.math.BigDecimal(invoiceItem.getItemPrice().toString()).multiply(new java.math.BigDecimal(invoiceItem.getQuantity().toString()))) : "0" %>" disabled="disabled"></td>
					                                        </tr>
			                                    			<%
			                                    			count++;
			                                    		}
			                                    	}else{
			                                    		%>
		                                    			<tr>
				                                        	<td>1</td>
				                                        	<td><input type="text" class="form-control" placeholder="Item name" name="items[0].itemName"></td>
				                                        	<td><input type="text" class="form-control" placeholder="Description" name="items[0].description"></td>
				                                        	<td><input type="text" class="form-control" placeholder="Unit Type (kg/piece/...)" name="items[0].unitName"></td>
				                                        	<td><input type="number" style="max-width: 110px" class="form-control unit-cost" placeholder="Unit Cost" name="items[0].itemPrice"></td>
				                                        	<td><input type="number" style="max-width: 110px" class="form-control quantity" placeholder="Quantity" name="items[0].quantity"></td>
				                                        	<td><input type="text" style="max-width: 110px" class="form-control amount" value="0" disabled="disabled"></td>
				                                        </tr>
		                                    			<%
			                                    	}
			                                    %>			                                   
			                                    </tbody>
			                                </table>
			                                <button type="button" class="btn btn-success d-block m-l-10 m-b-10" id="add-row">Add Row</button>
			
			
			                            </div>
			                            <div class="table-responsive">
			                                <table class="table table-hover table-white">
			                                    <tbody>
			                                        <tr>
			                                            <td></td>
			                                            <td></td>
			                                            <td></td>
			                                            <td></td>
			                                            <td class="text-right">Total</td>
			                                            <td style="text-align: right; padding-right: 30px;width: 230px" id="total-amount">0</td>
			                                        </tr>			
			                                    </tbody>
			                                </table>
			                            </div>
			                        </div>
			                    </div>
			                    <div class="text-center m-t-20">
			                        <button type="submit" class="btn btn-primary p-l-20 p-r-20">Add Invoice</button>
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
	                type: 'POST',
	                url: '/api/user/'+$("#user_select").val(),
	                data:"",
	                success: function (data) {
	                    console.log(data);
	                    $("#user_fullname").val(data.firstName + " " + data.lastName);
	                    $("#user_phone").val(data.phone);
	                    $("#user_email").val(data.email);
	                    $("#user_address").val(data.address);
	                },
	                error: function (error) {
	                    console.error('Error:', error);
	                }
	            }); 
	    	})
	    	
	    	
	    	
	    });
	</script>
	
<script>
    $(document).ready(function () {
        var count = <%=count+1%>;

        // Function to add a new row to the invoice table
        function addNewRow() {
            var newRow = '<tr>' +
                '<td>' + (count) + '</td>' +
                '<td><input type="text" class="form-control" placeholder="Item name" name="items[' + count + '].itemName"></td>' +
                '<td><input type="text" class="form-control" placeholder="Description" name="items[' + count + '].description"></td>' +
                '<td><input type="text" class="form-control" placeholder="Unit Type (kg/piece/...)" name="items[' + count + '].unitName"></td>' +
                '<td><input type="number" style="max-width: 110px" class="form-control unit-cost" placeholder="Unit Cost" name="items[' + count + '].itemPrice"></td>' +
                '<td><input type="number" style="max-width: 110px" class="form-control quantity" placeholder="Quantity" name="items[' + count + '].quantity"></td>' +
                '<td><input type="text" style="max-width: 110px" class="form-control amount" value="0" disabled="disabled"></td>' +
                '</tr>';

            $('#invoice-table').append(newRow);
            count++;

            // Update amount and grand total on change of unit cost or quantity
            updateAmountAndGrandTotal();
        }

        // Update amount and grand total on change of unit cost or quantity
        function updateAmountAndGrandTotal() {
            $('.unit-cost, .quantity').on('input', function () {
                var row = $(this).closest('tr');
                var unitCost = parseFloat(row.find('.unit-cost').val()) || 0;
                var quantity = parseFloat(row.find('.quantity').val()) || 0;
                var amount = unitCost * quantity;
                row.find('.amount').val(amount.toFixed(2));

                // Update grand total
                updateGrandTotal();
            });
        }

        // Update grand total
        function updateGrandTotal() {
            var grandTotal = 0;
            $('.amount').each(function () {
                grandTotal += parseFloat($(this).val()) || 0;
            });
            $('#total-amount').text("BDT "+grandTotal.toFixed(2));
        }

        // Add row when "Add Row" button is clicked
        $('#add-row').on('click', function () {
            addNewRow();
        });

        // Initial update for the first row
        updateAmountAndGrandTotal();
    });
</script>

	
	
<%!
    // Add this scriptlet to format the Date object
    private String formatDate(Date date) {
		if(date != null){
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	        return sdf.format(date);	
		}else{
			return "";
		}
    }
%>	
</body>

</html>
