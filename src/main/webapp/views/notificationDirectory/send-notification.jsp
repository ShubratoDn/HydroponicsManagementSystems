<%@page import="com.hydroponics.management.system.entities.enums.NotificationType"%>
<%@page import="org.springframework.validation.BindingResult"%>
<%@page import="com.hydroponics.management.system.entities.Notification"%>
<%@page import="com.hydroponics.management.system.payloads.ServerMessage"%>
<%@page import="com.hydroponics.management.system.entities.Environment"%>
<%@page import="java.util.List"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<title>Send Notification</title>
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
						<h4>Send Notification</h4>
					</div>
				</div>



				<section class="min-h-80vh">
				    <div class="bg-white p-20 bordered">
				    	 <form id="notificationForm" method="post" action="/send-notification">
				    	 
	    	 			<%
		                    
					      	Notification notification = null;
		                    BindingResult inputErrors = null;
	
		                    
		                    if (request.getAttribute("currentNotification") != null) {
		                    	notification = (Notification) request.getAttribute("currentNotification");
		                    }
		
		
		                    if (request.getAttribute("inputErrors") != null) {
		                        inputErrors = (BindingResult) request.getAttribute("inputErrors");
		                    }
		                %>
					
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
				    	 
	    	 				<!-- Select User -->
							<div class="form-group">
							    <label for="selectUser" class="form-control-label">Select Receiver</label>
							    <select id="receiverUser" class="form-control" name="receiverId">
							        <option value="">-- Select User --</option>
							        
							        							        
							        <%
							            List<UserDTO> userList = (List<UserDTO>) request.getAttribute("userList");
							            if (userList != null && userList.size() > 0) {
							                for (UserDTO user : userList) {
							        %>
							                    <option value="<%= user.getId() %>">							                    
							                        User Id: <%=user.getId() %> ||Name: <%= user.getFirstName() %> || Email: <%= user.getEmail() %>
							                    </option>
							        <%
							                }
							            }
							        %>
							    </select>
							    <% if (inputErrors != null && inputErrors.getFieldErrors("receiverId").size() > 0) { %>
							    <small class="form-text text-muted text-danger"><%= inputErrors.getFieldError("receiverId").getDefaultMessage() %></small>
							    <% } %>
							</div>


							<!-- Select Environment -->
							<div class="form-group">
							    <label for="selectUser" class="form-control-label">Select Environment <span class="text-muted">(optional)</span></label>
							    <!-- Your existing HTML code for the second dropdown -->
								<select id="selectEnv" class="form-control" name="environmentId">
								    <option value="">-- First select receiver --</option>
								</select>
							    <% if (inputErrors != null && inputErrors.getFieldErrors("environmentId").size() > 0) { %>
							    <small class="form-text text-muted text-danger"><%= inputErrors.getFieldError("environmentId").getDefaultMessage() %></small>
							    <% } %>
							</div>
							
							
							<!-- Select Notification Type -->
							<div class="form-group">
							    <label class="form-control-label">Select Notification Type <span class="text-muted"></span></label>
							    <select class="form-control" name="notificationType">
							        <option value="">-- Select Notification Type --</option>
							        <%
							        	for(NotificationType notificationType: NotificationType.values()){
							        		%>
							        		<option value="<%=notificationType.name() %>">
												<%=notificationType.name() %>
											</option>	
							        		<%
							        	}
							        %>							        
							    </select>
							    <% if (inputErrors != null && inputErrors.getFieldErrors("notificationType").size() > 0) { %>
							    <small class="form-text text-muted text-danger"><%= inputErrors.getFieldError("notificationType").getDefaultMessage() %></small>
							    <% } %>
							</div>
							
							<div class="form-control">
								<label class="form-control-label">Write the notification content</label>
								<textarea id="mytextarea" name="message"></textarea>					
								<% if (inputErrors != null && inputErrors.getFieldErrors("message").size() > 0) { %>
							    <small class="form-text text-muted text-danger"><%= inputErrors.getFieldError("message").getDefaultMessage() %></small>
							    <% } %>
							</div>
							
					
	                        <input type="submit" value="Send Notification" class="btn btn-success d-block m-x-auto m-t-20">
	                    </form>
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

	<!-- Rich text editor js -->
	<script src="${pageContext.request.contextPath}/assets/plugins/rich-text-editor/tinymce.min.js"></script>

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
    	tinymce.init({
    	  selector: '#mytextarea',
    	  placeholder: 'Enter your text here...',
    	  setup: function (editor) {
    	    // Remove the default content
    	    editor.on('init', function () {
    	      editor.setContent('');
    	    });
    	  }
    	});
	</script>

	<script type="text/javascript">
		$("#receiverUser").select2();
	</script>
	
	<script>
    $(document).ready(function () {
        // Event listener for the first dropdown change
        $('#receiverUser').change(function () {
            var selectedUserId = $(this).val();

            // Make an AJAX request to get environments based on the selected user
            $.ajax({
                type: 'POST',
                url: '/api/environments/by-user/' + selectedUserId,
                dataType: 'json',
                success: function (environments) {
                    // Clear existing options in the second dropdown
                    $('#selectEnv').empty();

                    // Populate the second dropdown with received data
                    if (environments.length > 0) {
                    	$('#selectEnv').append($('<option>', {
                            value: '',
                            text: "-- You can select Environment now --"
                        }));
                        environments.forEach(function (environment) {
                            var optionText = 'ENV_' + environment.id + ' -> Plant: "' + environment.plantName + '" || Location: "' + environment.location.fullAddress + '" || Owner: ' + environment.ownedBy.firstName + ' ' + environment.ownedBy.lastName;
                            $('#selectEnv').append($('<option>', {
                                value: environment.id,
                                text: optionText
                            }));
                        });
                    } else {
                        // If no environments are found, add a default option
                        $('#selectEnv').append($('<option>', {
                            value: '',
                            text: '-- No Environments Found --'
                        }));
                    }
                },
                error: function () {
                    console.error('Error fetching environments.');
                }
            });
        });
    });
</script>
	
</body>

</html>