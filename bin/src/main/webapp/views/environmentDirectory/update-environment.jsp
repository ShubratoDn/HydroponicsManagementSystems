<!DOCTYPE html>

<%@page import="com.hydroponics.management.system.entities.Mineral"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.hydroponics.management.system.DTO.EnvironmentDTO"%>
<%@page import="java.util.List"%>
<%@page import="com.hydroponics.management.system.DTO.LocationDTO"%>
<%@page
	import="com.hydroponics.management.system.payloads.ServerMessage"%>
<%@page import="org.springframework.validation.FieldError"%>
<%@page import="org.springframework.validation.BindingResult"%>
<%@page import="com.hydroponics.management.system.DTO.UserDTO"%>



<%
         
	EnvironmentDTO environment = null;
         BindingResult inputErrors = null;

         
         if (request.getAttribute("environmentDTO") != null) {
         	environment = (EnvironmentDTO) request.getAttribute("environmentDTO");
         }


         if (request.getAttribute("inputErrors") != null) {
             inputErrors = (BindingResult) request.getAttribute("inputErrors");
         }
     %>

<%!
    // Add this scriptlet to format the Date object
    private String formatDate(Date date) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        return sdf.format(date);
    }
%>

<html lang="en">
<head>
<title>Update ENV_<%=environment.getId() %></title>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1.0, user-scalable=no">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="description"
	content="Leaf Lab - a Hydroponics Management System solution">
<meta name="keywords"
	content="Hydroponics, Add Environment, Shubrato, Hydroponics Management System, KYAU Hydroponics,  KYAU">
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
						<h4>Update Environment ENV_<%=environment.getId() %></h4>
					</div>
				</div>

				<section class="form-section">
					<!-- Container-fluid starts -->
					<div class="container-fluid">
						<div class="row">
							<div class="col-sm-12 col-lg-10 offset-lg-1">
								<div class="form-container">
								
																	
									<form class="md-float-material" action="/update-environment/<%=environment.getId() %>" method="post">										
										<div class="text-center">
											<a href="/"> <img class="full-logo-lg"
												src="${pageContext.request.contextPath}/assets/images/logo-black.png" alt="logo">
											</a>
										</div>
										<h3 class="text-center txt-primary m-y-2">Updating Environment : ENV_<%=environment.getId() %></h3>
										
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
										
										<div class="m-t-2 row p-20">
										
										
										<!-- Plant Name -->
										<div class="form-group">
										    <label for="plantName" class="form-control-label">Plant Name</label>
										    <input type="text" class="form-control" id="plantName" name="plantName" placeholder="Enter plant name" value="<%= environment != null ? environment.getPlantName() : "" %>">
										    <% if (inputErrors != null && inputErrors.getFieldErrors("plantName").size() > 0) { %>
										    <small class="form-text text-muted text-danger"><%= inputErrors.getFieldError("plantName").getDefaultMessage() %></small>
										    <% } %>
										</div>				
																					
											
									
									    <!-- Select User -->
										<div class="form-group">
										    <label for="selectUser" class="form-control-label">Select User</label>
										    <select id="selectUser" class="form-control" name="ownedBy">
										        <option value="">-- Select User --</option>
										        <%
										            List<UserDTO> userList = (List<UserDTO>) request.getAttribute("userList");
										            if (userList != null && userList.size() > 0) {
										                for (UserDTO user : userList) {
										        %>
										                    <option value="<%= user.getId() %>" <%= environment != null && environment.getOwnedBy() != null && environment.getOwnedBy().getId() == user.getId() ? "selected" : "" %>>
										                        Name: <%= user.getFirstName() %> || <span class="text-muted"><%= user.getEmail() %></span>
										                    </option>
										        <%
										                }
										            }
										        %>
										    </select>
										    <% if (inputErrors != null && inputErrors.getFieldErrors("ownedBy").size() > 0) { %>
										    <small class="form-text text-muted text-danger"><%= inputErrors.getFieldError("ownedBy").getDefaultMessage() %></small>
										    <% } %>
										</div>
									
									
									    

										<!-- Select Location -->
										<div class="form-group">
										    <label for="selectLocation" class="form-control-label">Select Location</label>
										    <select id="selectLocation" class="form-control" name="location">
										        <option value="">-- Select Location --</option>
										        <%
										            List<LocationDTO> locationList = (List<LocationDTO>) request.getAttribute("locationList");
										            if (locationList != null && locationList.size() > 0) {
										                for (LocationDTO location : locationList) {
										        %>
										                    <option value="<%= location.getId() %>" <%= environment != null && environment.getLocation() != null && environment.getLocation().getId() == location.getId() ? "selected" : "" %>>
										                        Name: <%= location.getLocationName() %> || <span class="text-muted">Address: <%= location.getFullAddress() %></span>
										                    </option>
										        <%
										                }
										            }
										        %>
										    </select>
										    <% if (inputErrors != null && inputErrors.getFieldErrors("location").size() > 0) { %>
										    <small class="form-text text-muted text-danger"><%= inputErrors.getFieldError("location").getDefaultMessage() %></small>
										    <% } %>
										</div>
										
									
									      
											<!-- Plant Date -->
											<div class="form-group">
											    <label for="plantDate" class="form-control-label">Plant Date</label>
											    <input type="date" class="form-control" id="plantDate" name="plantDate"
											           value="<%= environment != null && environment.getPlantDate() != null ? formatDate(environment.getPlantDate()) : "" %>">
											    <% if (inputErrors != null && inputErrors.getFieldErrors("plantDate").size() > 0) { %>
											    <small class="form-text text-muted text-danger"><%= inputErrors.getFieldError("plantDate").getDefaultMessage() %></small>
											    <% } %>
											</div>
											
											 <!-- Maturity Date -->
											<div class="form-group">
											    <label for="maturityDate" class="form-control-label">Maturity Date</label>
											    <input type="date" class="form-control" id="maturityDate" name="maturityDate"
											           value="<%= environment != null && environment.getMaturityDate() != null ? formatDate(environment.getMaturityDate()) : "" %>">
											    <% if (inputErrors != null && inputErrors.getFieldErrors("maturityDate").size() > 0) { %>
											    <small class="form-text text-muted text-danger"><%= inputErrors.getFieldError("maturityDate").getDefaultMessage() %></small>
											    <% } %>
											</div>
											
											

									        <!-- Light Duration -->
											<div class="form-group">
											    <label for="lightDuration" class="form-control-label">Light Duration (in hours)</label>
											    <input type="number" class="form-control" id="lightDuration" name="lightDuration" placeholder="Enter light duration" value="<%= environment != null ? environment.getLightDuration() : "" %>">
											    <% if (inputErrors != null && inputErrors.getFieldErrors("lightDuration").size() > 0) { %>
											        <small class="form-text text-muted text-danger"><%= inputErrors.getFieldError("lightDuration").getDefaultMessage() %></small>
											    <% } %>
											</div>
											
											<!-- Water pH -->
											<div class="form-group">
											    <label for="waterPH" class="form-control-label">Water pH</label>
											    <input type="number" step="0.1" class="form-control" id="waterPH" name="waterPH" placeholder="Enter water pH" value="<%= environment != null ? environment.getWaterPH() : "" %>">
											    <% if (inputErrors != null && inputErrors.getFieldErrors("waterPH").size() > 0) { %>
											        <small class="form-text text-muted text-danger"><%= inputErrors.getFieldError("waterPH").getDefaultMessage() %></small>
											    <% } %>
											</div>
											
											<!-- Temperature (in Celsius) -->
											<div class="form-group">
											    <label for="temperatureC" class="form-control-label">Temperature (in Celsius)</label>
											    <input type="number" step="0.1" class="form-control" id="temperatureC" name="temperatureC" placeholder="Enter temperature" value="<%= environment != null ? environment.getTemperatureC() : "" %>">
											    <% if (inputErrors != null && inputErrors.getFieldErrors("temperatureC").size() > 0) { %>
											        <small class="form-text text-muted text-danger"><%= inputErrors.getFieldError("temperatureC").getDefaultMessage() %></small>
											    <% } %>
											</div>
											
											<!-- Humidity -->
											<div class="form-group">
											    <label for="humidity" class="form-control-label">Humidity</label>
											    <input type="number" step="0.1" class="form-control" id="humidity" name="humidity" placeholder="Enter humidity" value="<%= environment != null ? environment.getHumidity() : "" %>">
											    <% if (inputErrors != null && inputErrors.getFieldErrors("humidity").size() > 0) { %>
											        <small class="form-text text-muted text-danger"><%= inputErrors.getFieldError("humidity").getDefaultMessage() %></small>
											    <% } %>
											</div>

							                <hr>
							                
							                <!-- Add minerals -->
											<div>
											    <label class="form-control-label">Add Minerals</label>
											    <div id="mineral-input-group">
											        <% 
											            List<Mineral> minerals = environment != null ? environment.getMinerals() : null;
											            if (minerals != null && !minerals.isEmpty()) {
											                for (int i = 0; i < minerals.size(); i++) {
											                    Mineral mineral = minerals.get(i);
											        %>
											                    <div class="form-group m-b-0 d-flex">
											                    	<input name="minerals[<%= i %>].id"  value="<%=mineral.getId() != null ? mineral.getId() : ""%>" hidden="hidden"/>
											                        <input type="text" placeholder="Mineral Name" name="minerals[<%= i %>].mineralName" class="form-control m-5" value="<%= mineral.getMineralName() %>"/>
											                        <input type="text" placeholder="Mineral Unit" name="minerals[<%= i %>].mineralUnit" class="form-control m-5" value="<%= mineral.getMineralUnit() %>"/>
											                        <input type="number" placeholder="Mineral amount" name="minerals[<%= i %>].mineralAmount" step="0.1" class="form-control m-5" value="<%= mineral.getMineralAmount() %>"/>
											                    </div>
											        <%
											                }
											            } else {
											        %>
											            <div class="form-group m-b-0 d-flex">
											                <input type="text" placeholder="Mineral Name" name="minerals[0].mineralName" class="form-control m-5"/>
											                <input type="text" placeholder="Mineral Unit" name="minerals[0].mineralUnit" class="form-control m-5"/>
											                <input type="number" placeholder="Mineral amount" name="minerals[0].mineralAmount" step="0.1" class="form-control m-5"/>
											            </div>
											        <%
											            }
											        %>
											    </div>
											    <button type="button" class="d-block btn btn-info btn-sm add-mineral-btn" id="add-mineral-btn">Add Another Mineral</button>
											</div>
											
											<input type="submit" class="btn btn-success w-100 m-t-2" value="Setup Environment">
																
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
    $(document).ready(function(){
        // Initialize select2
        $("#selectUser").select2();
        $("#selectLocation").select2();

        // Add mineral button click event
        $("#add-mineral-btn").click(function(){
            // Clone the last mineral input group
            var lastMineralGroup = $("#mineral-input-group .form-group:last").clone();

            // Increment the index in the input names
            lastMineralGroup.find("input[name^='minerals']").each(function(){
                var currentName = $(this).attr("name");
                var currentIndex = parseInt(currentName.match(/\d+/)[0]);
                var newIndex = currentIndex + 1;
                var newName = currentName.replace(currentIndex, newIndex);
                $(this).attr("name", newName);
                $(this).val(""); // Clear the input values
            });

            // Append the cloned group to the mineral-input-group
            $("#mineral-input-group").append(lastMineralGroup);
        });
    });
</script>


</body>

</html>