<%@page import="com.hydroponics.management.system.servicesImple.HelperServices"%>
<%@page import="java.util.Locale"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.hydroponics.management.system.entities.Environment"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.hydroponics.management.system.entities.Notification"%>
<%@page import="com.hydroponics.management.system.payloads.PageableResponse"%>
<%@page import="com.hydroponics.management.system.payloads.ServerMessage"%>
<%@page import="java.util.List"%>


<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
<title>Environment</title>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1.0, user-scalable=no">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="description"
	content="Leaf Lab - a Hydroponics Management System solution">
<meta name="keywords"
	content="Hydroponics, Environment, Shubrato, Hydroponics Management System, KYAU Hydroponics,  KYAU">
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
						<h4><%=loggedUser.getFirstName() %>'s all notifications</h4>
					</div>
				</div>



				<section class="min-h-80vh">
				    <div class="bg-white p-20 bordered">				    	
				    	<div class="bg-white p-20 m-t-20 bordered">
						<b class="text-muted m-b-10 d-block">Environment List</b>
						<%
							HelperServices helperServices = new HelperServices();
							PageableResponse envListPageable = (PageableResponse) request.getAttribute("environmentList");
							Object myAttribute = request.getAttribute("environmentList");
						  	if (myAttribute == null) {						  		
						  		%>
						  			<h1 class="text-info text-center">Error!</h1>
						  		<%
						  	}else if(envListPageable == null || envListPageable.getNumberOfElements() <= 0){
						  		%>
					  				<h1 class="text-danger text-center">No environments found!!</h1>
					  			<%
						  	} else {
						  		List<Environment> envList = (List<Environment>) envListPageable.getContent();
						  		%>
						  		    <h6 class="text-info text-muted">You have total <%=envListPageable.getTotalElements() %> environments</h6>
						  		    <br>						  		    
						  		<%						  		
						  		for(Environment environment: envList){
						  			%>						  		    	
						  		    	<div class="p-15 bordered m-b-20">
						  		    		<div class="row">
						  		    			<div class="col-sm-10"><b>Plant Name : </b><%=environment.getPlantName() %></div>
						  		    			<div class="col-sm-2 text-muted"><b>ID - </b><%="ENV_"+environment.getId()%></div>
						  		    			<div class="col-sm-12"><b>Location : </b><%=environment.getLocation().getLocationName()+", "+ environment.getLocation().getFullAddress()%></div>
						  		    			<div class="col-sm-6"><b>Owned by : </b><a href="/user/<%=environment.getOwnedBy().getId()%>"><%=environment.getOwnedBy().getFirstName() +" "+ environment.getOwnedBy().getLastName() %></a></div>
						  		    			<div class="col-sm-6"><b>Added by : </b><a href="/user/<%=environment.getAddedEnvironmentBy().getId()%>"><%=environment.getAddedEnvironmentBy().getFirstName() +" "+ environment.getOwnedBy().getLastName() %></a></div>
						  		    			<div class="col-sm-6"><b>Planted Field : </b><%=formatDate(environment.getPlantDate())%></div>
						  		    			<div class="col-sm-6"><b>Expected maturity date: </b><%= formatDate(environment.getMaturityDate()) %></div>
						  		    			<div class="col-sm-6"><b>Completed progress: </b><%=helperServices.calculateCompletionPercentage(environment.getPlantDate(), environment.getMaturityDate()) %>%</div>
						  		    		</div>
						  		    		<a href="/environment/<%=environment.getId()%>" style="width:fit-content; margin-left: auto;margin-right: 0;" class="btn btn-primary d-block m-t-10">View full details</a>
						  		    	</div>					  		    
						  			<%
						  		}						  		
						  		%>
						  		<h6 class="text-info text-muted">You have total <%= envListPageable.getTotalElements() %> environments</h6>
							    <br>
							
							    <% int currentPage = envListPageable.getPageNumber(); %>
							    <% int totalPages = envListPageable.getTotalPages(); %>

							    <nav aria-label="Page navigation example">
							        <ul class="pagination">
							            <li class="page-item <%= currentPage == 0 ? "disabled" : "" %>">
							                <a class="page-link" href="/my-environments?page=1" tabindex="-1" aria-disabled="true">First</a>
							            </li>
							            <% if (currentPage > 1) { %>
							                <li class="page-item">
							                    <a class="page-link" href="/my-environments?page=<%= currentPage - 1 %>">Previous</a>
							                </li>
							            <% } %>
							
							            <% for (int i = 1; i <= totalPages; i++) { %>
							                <li class="page-item <%= i == (currentPage + 1) ? "active" : "" %>">
							                    <a class="page-link" href="/my-environments?page=<%= i %>"><%= i %></a>
							                </li>
							            <% } %>
							
							            <% if (currentPage < totalPages) { %>
							                <li class="page-item <%= currentPage == (totalPages - 1) ? "disabled" : ""%>">
							                    <a class="page-link" href="/my-environments?page=<%= (currentPage + 1) + 1 %>">Next</a>
							                </li>
							            <% } %>
							            <li class="page-item <%= currentPage == (totalPages - 1) ? "disabled" : "" %>">
							                <a class="page-link" href="/my-environments?page=<%= totalPages %>">Last</a>
							            </li>
							        </ul>
							    </nav>
						  		<%					  		
						  	}						  	
						%>						
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