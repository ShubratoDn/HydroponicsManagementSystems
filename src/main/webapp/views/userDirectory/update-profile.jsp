<%@page import="org.springframework.validation.BindingResult"%>
<%@page import="com.hydroponics.management.system.entities.Environment"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Locale"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.hydroponics.management.system.servicesImple.HelperServices"%>
<%@page import="com.hydroponics.management.system.entities.User"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.hydroponics.management.system.entities.Notification"%>
<%@page import="com.hydroponics.management.system.payloads.PageableResponse"%>
<%@page import="com.hydroponics.management.system.payloads.ServerMessage"%>
<%@page import="java.util.List"%>


<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%	
	boolean isMyAccount = (Boolean) request.getAttribute("isMyAccount");
	boolean isAdmin = (Boolean) request.getAttribute("isAdmin");	
	
	UserDTO userDTO = null;
    BindingResult inputErrors = null;

    if (request.getAttribute("userDTO") != null) {
        userDTO = (UserDTO) request.getAttribute("userDTO");
    }

    if (request.getAttribute("inputErrors") != null) {
        inputErrors = (BindingResult) request.getAttribute("inputErrors");
    }
%>

    
<!DOCTYPE html>
<html>
<head>
<title>Updating: <%=userDTO.getFirstName() + " " + userDTO.getLastName() %></title>
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
					<div class="main-header">
						<h4>Update Profile: <span class="text-muted"><%=userDTO.getFirstName() + " " + userDTO.getLastName() %></span> </h4>						
					</div>
				</div>



				<section class="min-h-80vh">
				    <div class="bg-white p-20 bordered">
				    	<div class="row">
				    		<div class="col-md-12 m-b-10">
				    			<img alt="User" class="profile-user-image" src="${pageContext.request.contextPath}/assets/images/userImages/<%=userDTO.getImage()%>">			    			
				    		</div>
				    		
				    		
					    		<div class="col-md-5 offset-md-3">
					                <table class="table user-details-box">				                    
					                    <tbody>
					                        <tr>
					                            <td>User ID</td>
					                            <td><%=userDTO.getId()%></td>
					                        </tr>
					                        <tr>
					                            <td>First Name</td>
					                            <td><%=userDTO.getId()%></td>
					                        </tr>
					                        <tr>
					                            <td>Phone</td>
					                            <td><%=userDTO.getPhone()%></td>
					                        </tr>
					                        <tr>
					                            <td>Email</td>
					                            <td><%=userDTO.getEmail()%></td>
					                        </tr>
					                        <tr>
					                            <td>Role</td>
					                            <td><%=userDTO.getRole()%></td>
					                        </tr>
					                        <tr>
					                        	<td>Date joined</td>
					                        	<td>
					                        		<%=userDTO.getRegistrationDate() !=null ? formatDate(userDTO.getRegistrationDate()) : "undefined" %>                                    			
	                                    		</td>
					                        </tr>
					                        <tr>
					                        	<td>Added By</td>
					                        	<td>
					                        		<a href="/user/<%=userDTO.getAddedBy() != null ? userDTO.getAddedBy().getId() : "1"%>"><%= userDTO.getAddedBy() == null ? "Undefined": userDTO.getAddedBy().getFirstName() + " " + userDTO.getAddedBy().getLastName() %></a>                                    			
	                                    		</td>
					                        </tr>			                        
					                    </tbody>
					                </table>
					                
					                <%
					                	if(isAdmin || isMyAccount){
					                		%>
					                			<div class="m-10 d-flex justify-content-center align-items-center">
								                	<a href="/user/update/<%=userDTO.getId()%>" class="btn btn-info">Update profile</a>
								                </div>
					                		<%		
					                	}
					                %>					                
					                
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
    private String formatDate(Date date) {
        SimpleDateFormat sdf = new SimpleDateFormat("dd MMMM, yyyy", new Locale("en"));
        return sdf.format(date);
    }
%>