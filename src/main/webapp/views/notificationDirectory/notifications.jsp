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
<title>My Notifications</title>
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
						<h4>My notifications</h4>
					</div>
				</div>



				<section class="min-h-80vh">
				    <div class="bg-white p-20 bordered">
				    <%
				    	PageableResponse pageableResponse = (PageableResponse) request.getAttribute("pageableNotifications");
				    %>
				    <% int currentPage = pageableResponse.getPageNumber(); %>
				    <% int totalPages = pageableResponse.getTotalPages(); %>

				    <nav aria-label="Page navigation example">
				        <ul class="pagination">
				            <li class="page-item <%= currentPage == 0 ? "disabled" : "" %>">
				                <a class="page-link" href="/my-notifications?page=0" tabindex="-1" aria-disabled="true">First</a>
				            </li>
				            <% if (currentPage > 0) { %>
				                <li class="page-item">
				                    <a class="page-link" href="/my-notifications?page=<%= currentPage - 1 %>">Previous</a>
				                </li>
				            <% } %>
				
				            <% for (int i = 1; i <= totalPages; i++) { %>
				                <li class="page-item <%= i == (currentPage + 1) ? "active" : "" %>">
				                    <a class="page-link" href="/my-notifications?page=<%= i-1 %>"><%= i %></a>
				                </li>
				            <% } %>
				
				            <% if (currentPage < totalPages) { %>
				                <li class="page-item <%= currentPage == (totalPages - 1) ? "disabled" : ""%>">
				                    <a class="page-link" href="/my-notifications?page=<%= (currentPage + 1) %>">Next</a>
				                </li>
				            <% } %>
				            <li class="page-item <%= currentPage == (totalPages - 1) ? "disabled" : "" %>">
				                <a class="page-link" href="/my-notifications?page=<%= totalPages -1 %>">Last</a>
				            </li>
				        </ul>
				    </nav>
				    
				    <%
				    	
						
				    	List<Notification> notifications = new ArrayList<>();
				    
				    	if(pageableResponse != null){
				    		notifications = (List<Notification>) pageableResponse.getContent();
				    	}
				    	
				    	
				    	if(notifications == null || notifications.size() < 1){
				    		%>
				    			<h1 class="text-danger text-center">Empty Notifications</h1>
				    		<%
				    	}else{
				    		for(Notification notification: notifications){
				    			
				    			 // Determine the CSS class based on notification type
				                String cssClass = "";
				    			 if(notification.getNotificationType().name().startsWith("SUCCESS")){
				    				 cssClass = "success";
				    			 }else if(notification.getNotificationType().name().startsWith("ERROR") || notification.getNotificationType().name().startsWith("INVALID")){
				    				 cssClass = "danger";
				    			 }else if(notification.getNotificationType().name().startsWith("EXPIR") || notification.getNotificationType().name().startsWith("WARN") || notification.getNotificationType().name().startsWith("UN")){
				    				 cssClass = "warning";
				    			 }
				    			 
				    			 
				    			 String shortMessage = "";
				    			 
				    			 if(notification.getMessage().length() > 20){
				    				 shortMessage = notification.getMessage().substring(0, 20);
				    			 }
				    		
				    		%>
					    	<div class="accordion-panel notification-accordion-panel <%=notification.getStatus().toString().toLowerCase() %> <%=cssClass %> " id="notification_<%=notification.getId()%>" onclick="markAsRead(<%=notification.getId()%>)">
	                            <div class="accordion-heading" role="tab" id="headingOne">
	                                <h3 class="card-title accordion-title">
	                                    <a class="accordion-msg collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapse_<%=notification.getId()%>"
	                                        aria-expanded="true" aria-controls="collapse_<%=notification.getId()%>">
	                                        <div class="d-flex">
	                                            <img src="<%=request.getContextPath()+"/assets/images/util/"+notification.getNotificationType()+".png" %>" alt="image" class="notification-image">
	                                            <div>
	                                                <%=notification.getNotificationType().name() %>
	                                                <span class="short-info">(<%=shortMessage %>...)</span>
	                                                <span class="icon collapsed-icon icon-arrow-down"></span>
	                                            </div>
	                                            <div style="margin-left: auto; margin-right: 20px; color: #ccc;"><%=formatTimeAgo(notification.getTimestamp()) %></div>
	                                        </div>
	                                        <span class="icon non-collapsed-icon icon-arrow-up"></span>
	                                    </a>
	                                </h3>
	                            </div>
	                            
	                            <div id="collapse_<%=notification.getId()%>" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingOne">
	                                <div class="accordion-content accordion-desc p-t-10">
	                                    <div class="notification-content-container-main">
	                                        <div class="m-r-10">
	                                            <img src="<%=notification.getSender() == null ? request.getContextPath()+"/assets/images/avatar-1.png" : request.getContextPath()+"/assets/images/userimages/"+notification.getSender().getImage()%>" alt="image" class="notification-sender-image">
	                                        </div>
	                                        <div class="content">
	                                            <h6><%= notification.getSender() == null ? "Owner" : notification.getSender().getFirstName() + " " + notification.getSender().getLastName() %></h6>
	                                            <div>
	                                               <%=notification.getMessage()%>
	                                            </div>
	                                        </div>
	                                    </div>
	                                </div>
	                            </div>
	                        </div>
				    		<%
				    		}
				    	}
				    %>	    
				    
				   
				    <nav aria-label="Page navigation example">
				        <ul class="pagination">
				            <li class="page-item <%= currentPage == 0 ? "disabled" : "" %>">
				                <a class="page-link" href="/my-notifications?page=0" tabindex="-1" aria-disabled="true">First</a>
				            </li>
				            <% if (currentPage > 0) { %>
				                <li class="page-item">
				                    <a class="page-link" href="/my-notifications?page=<%= currentPage - 1 %>">Previous</a>
				                </li>
				            <% } %>
				
				            <% for (int i = 1; i <= totalPages; i++) { %>
				                <li class="page-item <%= i == (currentPage + 1) ? "active" : "" %>">
				                    <a class="page-link" href="/my-notifications?page=<%= i-1 %>"><%= i %></a>
				                </li>
				            <% } %>
				
				            <% if (currentPage < totalPages) { %>
				                <li class="page-item <%= currentPage == (totalPages - 1) ? "disabled" : ""%>">
				                    <a class="page-link" href="/my-notifications?page=<%= (currentPage + 1) %>">Next</a>
				                </li>
				            <% } %>
				            <li class="page-item <%= currentPage == (totalPages - 1) ? "disabled" : "" %>">
				                <a class="page-link" href="/my-notifications?page=<%= totalPages -1 %>">Last</a>
				            </li>
				        </ul>
				    </nav>
				    
				    
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
	public String formatTimeAgo(Timestamp timestamp) {
    long now = System.currentTimeMillis();
    long notificationTime = timestamp.getTime();
    long timeDiff = now - notificationTime;

    // Calculate time ago in seconds, minutes, hours, or days
    if (timeDiff < 60000) {
        return Math.floorDiv(timeDiff, 1000) + " seconds ago";
    } else if (timeDiff < 3600000) {
        return Math.floorDiv(timeDiff, 60000) + " minutes ago";
    } else if (timeDiff < 86400000) {
        return Math.floorDiv(timeDiff, 3600000) + " hours ago";
    } else {
        return Math.floorDiv(timeDiff, 86400000) + " days ago";
    }
}
%>