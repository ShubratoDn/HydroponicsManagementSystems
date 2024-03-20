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
	
	List<UserDTO> userList = (List<UserDTO>) request.getAttribute("userList");
	
%>

    
<!DOCTYPE html>
<html>
<head>
<title>All Users</title>
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
						<h4>All Users List</h4>						
					</div>
				</div>

				<section class="min-h-80vh">
		            <div class="bg-white p-20 bordered">
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
		            <table class="table table-bordered">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Full Name</th>
                                <th>Image</th>
                                <th>Role</th>
                                <th>Phone</th>
                                <th>Email</th>
                                <th>Address</th>
                                <th>Date Join</th>
                                
                                <th>Added By</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                        	<%
                        		for(UserDTO user : userList){
                        			%>                        			
                        			<tr>
                        				<td><%=user.getId() %></td>
                        				<td><%=user.getFirstName() + " " + user.getLastName() %></td>
                        				<td><img class="user-table-image" src="${pageContext.request.contextPath}/assets/images/userimages/<%=user.getImage()%>"></td>
                        				<td><%=user.getRole() %></td>
                        				<td><%=user.getPhone() %></td>
                        				<td><%=user.getEmail() %></td>
                        				<td><%=user.getAddress() %></td>
                        				<td><%=formatDate(user.getRegistrationDate()) %></td>
                        				
                        				<td>
                        					<%
                        						if(user.getAddedBy() != null){
                        							%>
                        								<a href="/user/<%=user.getAddedBy().getId()%>"><%=user.getAddedBy().getFirstName() +" " + user.getAddedBy().getLastName() %></a>
                        							<%
                        						}
                        					%>
                        				</td>
	                                    <td class="d-flex">
		                                    <a href="/user/<%=user.getId() %>" class="btn btn-primary m-r-5"><i class="icon icofont-expand"></i></a>
		                                    <a href="/user/update/<%=user.getId() %>" class="btn btn-success m-r-5"><i class="icon icon-pencil"></i></a>
		                                    <button class="btn btn-danger delete-btn" data-toggle="modal" data-target="#deleteConfirmationModal" data-user-id="<%=user.getId()%>" data-user-full-name="<%=user.getFirstName() + ' ' + user.getLastName()%>">
									            <i class="icon icofont-bin"></i>
									        </button>
	                                	</td>
	                                </tr>
                        			<%
                        		}
                        	%>	
			            	      
                        </tbody>
                    </table>	                	            	
		            	
		            </div>
		        </section>
			
			</div>
		</div>
	</div>
	
	
	
	
	<!-- Add Bootstrap Modal for Delete Confirmation -->
<div class="modal fade" id="deleteConfirmationModal" tabindex="-1" role="dialog" aria-labelledby="deleteConfirmationModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="deleteConfirmationModalLabel">Confirm Deletion</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                Are you sure you want to delete this user?
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-danger" id="confirmDeleteBtn">Confirm Delete</button>
            </div>
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
    <script src="${pageContext.request.contextPath}/assets/plugins/websocket/sockjs.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/plugins/websocket/stomp.min.js"></script>    

    <script type="text/javascript">
        // Include the base context path in a JavaScript variable
        var contextPath = '<%= request.getContextPath() %>';
        var userId = '<%=loggedUser != null ? loggedUser.getId() : null %>';
    </script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/notification.js"></script>
	
	
	<script type="text/javascript">
		$(document).ready(function () {
		    var userIdToDelete;
		    var userFullNameToDelete;
	
		    // Handle click on delete button to store user ID and full name
		    $('.delete-btn').click(function () {
		        userIdToDelete = $(this).data('user-id');
		        userFullNameToDelete = $(this).data('user-full-name');
		        // Update modal content with user full name
		        $('#deleteConfirmationModal .modal-body').text('Are you sure you want to delete ' + userFullNameToDelete + '?');
		    });
	
		    // Handle click on confirm delete button
		    $('#confirmDeleteBtn').click(function () {
		        if (userIdToDelete) {
		            // Redirect to the delete URL with the user ID
		            window.location.href = '<%= request.getContextPath() %>/user/delete/' + userIdToDelete;
		        }
		    });
		});

	</script>
	
</body>

</html>

<%!
    private String formatDate(Date date) {
		if(date != null){
			SimpleDateFormat sdf = new SimpleDateFormat("dd MMMM, yyyy", new Locale("en"));
	        return sdf.format(date);	
		}
        return "undefined";
    }
%>