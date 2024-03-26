<!DOCTYPE html>
<%@page import="com.hydroponics.management.system.DTO.LocationDTO"%>
<%@page
	import="com.hydroponics.management.system.payloads.ServerMessage"%>
<%@page import="org.springframework.validation.FieldError"%>
<%@page import="org.springframework.validation.BindingResult"%>
<%@page import="com.hydroponics.management.system.DTO.UserDTO"%>

<%
    LocationDTO locationDTO = null;
    BindingResult inputErrors = null;

    if (request.getAttribute("locationDTO") != null) {
    	locationDTO = (LocationDTO) request.getAttribute("locationDTO");
    }

    if (request.getAttribute("inputErrors") != null) {
        inputErrors = (BindingResult) request.getAttribute("inputErrors");
    }
%>
								

<html lang="en">
<head>
<title>Update Location - <%=locationDTO.getLocationName() %></title>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1.0, user-scalable=no">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="description"
	content="Leaf Lab - a Hydroponics Management System solution">
<meta name="keywords"
	content="Hydroponics, Add location Shubrato, Hydroponics Management System, KYAU Hydroponics,  KYAU">
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


<!-- Style.css -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/main.css">

<!-- Responsive.css-->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/responsive.css">

<style type="text/css">
.error-message {
	color: red;
	font-size: 12px;
}
</style>

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
					<div class="main-header">
						<h4>Update Location</h4>
					</div>
				</div>
				
				<section class="register">
					<!-- Container-fluid starts -->
					<div class="container-fluid">
						<div class="row">
							<div class="col-sm-12">
								<div class="register-card card-block m-b-3 rounded">
								
								      
								
																	
									<form class="md-float-material" action="/location/update/<%=locationDTO.getId() %>" method="post">
										<div class="text-center">
											<a href="/"> <img class="full-logo-lg"
												src="${pageContext.request.contextPath}/assets/images/logo-black.png" alt="logo">
											</a>
										</div>
										<h3 class="text-center txt-primary m-t-2">Update Land Location</h3>
										<h5 class="text-center txt-muted">Location: <%=locationDTO.getLocationName() %></h5>
										
										<div class="m-t-2">											
											<%												
							                    	ServerMessage  msg = (ServerMessage) request.getAttribute("serverMessage");
							                    	if(msg != null){
							                    		%>
							                    			<div class="alert <%=msg.getClassName()%>">									
																<%=msg.getMessage() %>
															</div>
							                    		<%
							                    	}
							                    %>

											<!-- Location Name -->
											<div class="form-group">
											    <label for="locationName" class="form-control-label">Location Name</label>
											    <input type="text" class="form-control" id="locationName" name="locationName" placeholder="Enter location name" value="<%= locationDTO != null ? locationDTO.getLocationName() : "" %>">
											     <%
											     	if(inputErrors != null && inputErrors.getFieldErrors("locationName").size() > 0){
											     		%>
											     		<small class="form-text text-muted text-danger"><%=inputErrors.getFieldError("locationName").getDefaultMessage() %></small>
											     		<%
											     	}
											     %>
											</div>
											
											<!-- Full Address -->
											<div class="form-group">
											    <label for="fullAddress" class="form-control-label">Full Address</label>
											    <input type="text" class="form-control" id="fullAddress" name="fullAddress"
											           placeholder="Enter full address" value="<%= locationDTO != null ? locationDTO.getFullAddress() : "" %>">
											    <small class="form-text text-muted text-danger">
											        <% if (inputErrors != null && inputErrors.getFieldErrors("fullAddress").size() > 0) {
											            out.print(inputErrors.getFieldError("fullAddress").getDefaultMessage());
											        } %>
											    </small>
											</div>

											
											<!-- Length -->
									        <div class="form-group">
									            <label for="length" class="form-control-label">Length (in meter)</label>
									            <input type="number" class="form-control" id="length" name="length"
									                   placeholder="Enter length" value="<%= locationDTO != null ? locationDTO.getLength() : "" %>">
									            <small class="form-text text-muted text-danger">
									                <% if (inputErrors != null && inputErrors.getFieldErrors("length").size() > 0) {
									                    out.print(inputErrors.getFieldError("length").getDefaultMessage());
									                } %>
									            </small>
									        </div>
									
									        <!-- Width -->
									        <div class="form-group">
									            <label for="width" class="form-control-label">Width (in meter)</label>
									            <input type="number" class="form-control" id="width" name="width"
									                   placeholder="Enter width" value="<%= locationDTO != null ? locationDTO.getWidth() : "" %>">
									            <small class="form-text text-muted text-danger">
									                <% if (inputErrors != null && inputErrors.getFieldErrors("width").size() > 0) {
									                    out.print(inputErrors.getFieldError("width").getDefaultMessage());
									                } %>
									            </small>
									        </div>
										
											
											<!-- isAvailable -->
											<div class="form-group form-check border">											    
											    <input type="checkbox" id="isAvailable" name="isAvailable" <%=locationDTO == null? "checked" : (locationDTO != null && locationDTO.getIsAvailable() != null && locationDTO.getIsAvailable()) ? "checked" : ""%>>
											    <label class="form-check-label" for="isAvailable">Land is available?</label>
											</div>

					
											<!-- Note -->
											<div class="form-group">
											    <label for="note" class="form-control-label">Note</label>
											    <textarea class="form-control" id="note" name="note" rows="3" placeholder="Enter notes"><%= locationDTO != null ? locationDTO.getNote() : "" %></textarea>
											    <small class="form-text text-muted text-danger">
											        <% if (inputErrors != null && inputErrors.getFieldErrors("note").size() > 0) {
											            out.print(inputErrors.getFieldError("note").getDefaultMessage());
											        } %>
											    </small>
											</div>

											<input type="submit" class="btn btn-success w-100 m-t-2" value="Add Location">
											
										</div>										
									</form>
									<!-- end of form -->
								</div>
								<!-- end of login-card -->
							</div>
							<!-- end of col-sm-12 -->
						</div>
						<!-- end of row-->
					</div>
					<!-- end of container-fluid -->
				</section>

			</div>
		</div>
	</div>


	<!-- Required Jqurey -->
	<script src="${pageContext.request.contextPath}/assets/plugins/Jquery/dist/jquery.min.js"></script>
	<script src="${pageContext.request.contextPath}/assets/plugins/jquery-ui/jquery-ui.min.js"></script>
	<script src="${pageContext.request.contextPath}/assets/plugins/tether/dist/js/tether.min.js"></script>

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
 // Select all input elements within .md-input-wrapper elements
    const inputs = document.querySelectorAll(".md-input-wrapper input");

    // Loop through each input
    inputs.forEach(input => {
      // Check if the input has a value
      if (input.value.trim()) {
        // Add the "md-valid" class
        input.classList.add("md-valid");
      }
    });

</script>

</body>

</html>