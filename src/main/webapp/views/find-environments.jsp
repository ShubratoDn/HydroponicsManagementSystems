<%@page import="java.util.Locale"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.hydroponics.management.system.entities.Environment"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<title>Find Environment - Leaflab</title>
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
<link rel="shortcut icon" href="assets/images/favicon.png"
	type="image/x-icon">
<link rel="icon" href="assets/images/favicon.ico" type="image/x-icon">


<!-- Google font-->
<link href="https://fonts.googleapis.com/css?family=Ubuntu:400,500,700"
	rel="stylesheet">

<!-- themify -->
<link rel="stylesheet" type="text/css"
	href="assets/icon/themify-icons/themify-icons.css">

<!-- iconfont -->
<link rel="stylesheet" type="text/css"
	href="assets/icon/icofont/css/icofont.css">

<!-- simple line icon -->
<link rel="stylesheet" type="text/css"
	href="assets/icon/simple-line-icons/css/simple-line-icons.css">

<!-- Required Fremwork -->
<link rel="stylesheet" type="text/css"
	href="assets/plugins/bootstrap/css/bootstrap.min.css">

<!-- Chartlist chart css -->
<link rel="stylesheet" href="assets/plugins/chartist/dist/chartist.css"
	type="text/css" media="all">

<!-- Weather css -->
<link href="assets/css/svg-weather.css" rel="stylesheet">

<!-- Select 2 css -->
<link rel="stylesheet" href="assets/plugins/select2/dist/css/select2.min.css" />
<link rel="stylesheet" type="text/css" href="assets/plugins/select2/css/s2-docs.css">

<!-- Style.css -->
<link rel="stylesheet" type="text/css" href="assets/css/main.css">

<!-- Responsive.css-->
<link rel="stylesheet" type="text/css" href="assets/css/responsive.css">


</head>

<body class="sidebar-mini fixed">
	<div class="loader-bg">
		<div class="loader-bar"></div>
	</div>
	<div class="wrapper">

		<!-- Nav top included -->
		<%@include file="partials/util/nav-top.jsp"%>

		<!-- side nav bar -->
		<%@include file="partials/util/sidenav.jsp"%>


		<!-- Side bar chat -->
		<%@include file="partials/util/sidebar-chat.jsp"%>



		<div class="content-wrapper">
			<!-- Container-fluid starts -->
			<!-- Main content starts -->
			<div class="container-fluid">
				<div class="row">
					<div class="main-header">
						<h4>Find Environments</h4>
					</div>
				</div>

				<section class="min-h-80vh">
					<div class="bg-white p-20 bordered">
						<b class="text-muted m-b-10 d-block">Finding Criteria</b>
						
						<ul class="nav nav-tabs  tabs" role="tablist">
						    <li class="nav-item">
						        <a class="nav-link active" data-toggle="tab" href="#NormarSearch" role="tab">Normal Search</a>
						    </li>
						    <li class="nav-item">
						        <a class="nav-link" data-toggle="tab" href="#AdvanceSearch" role="tab">Advance Search</a>
						    </li>
						    <li class="nav-item">
						        <a class="nav-link" data-toggle="tab" href="#ComplexSearch" role="tab">Complex Search</a>
						    </li>
						</ul>
					
						<div class="tab-content tabs">
							<!-- Normal search -->
						    <div class="tab-pane active" id="NormarSearch" role="tabpanel">
						        <!-- Add Bootstrap CSS and JS links if not already included -->

								<h1 class="mt-4 mb-4">Search Environments</h1>
								<form class="form" method="post" action="/find-environments">
								    <div class="row">
								        <div class="col-md-4">
								            <label for="plantName">Plant Name</label>
								            <input type="text" class="form-control" name="plantName" id="plantName" placeholder="Plant Name">
								        </div>
								
								        <div class="col-md-4">
								            <label for="ownedByUserFirstName">Owner Name</label>
								            <input type="text" class="form-control" name="ownedByUserFirstName" id="ownedByUserFirstName"
								                placeholder="Owner Name">
								        </div>
								
								        <div class="col-md-4">
								            <label for="ownedByUserPhone">Owner Phone</label>
								            <input type="text" class="form-control" name="ownedByUserPhone" id="ownedByUserPhone"
								                placeholder="Owner Phone">
								        </div>
								    </div>
								
								    <div class="row m-t-1">
								        <div class="col-md-6">
								            <label for="locationName">Location Name</label>
								            <input type="text" class="form-control" name="locationName" id="locationName" placeholder="Location Name">
								        </div>
								
								        <div class="col-md-6">
								            <label for="environmentId">Environment ID</label>
								            <input type="number" class="form-control" name="environmentId" id="environmentId"
								                placeholder="Environment ID">
								        </div>
								    </div>
								
								    <div class="m-t-4">
								        <button type="submit" class="btn btn-primary m-t-10">Search</button>
								    </div>
								</form>								
						    </div>
						    
						    
						    <div class="tab-pane" id="AdvanceSearch" role="tabpanel">
						        <p>2.Cras consequat in enim ut efficitur. Nulla posuere elit quis auctor interdum praesent sit amet nulla vel enim amet. Donec convallis tellus neque, et imperdiet felis amet.</p>
						    </div>
						    
						    
						    <div class="tab-pane" id="ComplexSearch" role="tabpanel">
						        <h1>Complex Search</h1>
						        <form class="form-horizontal" method="POST" action="/find-environments">
						        
							        <table class="table table-striped table-bordered">								  
									    <tr>
									      <th>Parameter name</th>
									      <th>Parameter Value</th>
									    </tr>								  
									  <tbody>
								            <!-- Environment ID -->
								            <tr>
								                <th>Environment Id</th>
								                <td><input type="number" class="form-control" name="environmentId" placeholder="Environment Id"></td>
								            </tr>
								
								            <!-- Plant Name -->
								            <tr>
								                <th>Plant Name</th>
								                <td><input type="text" class="form-control" name="plantName" placeholder="Plant name"></td>
								            </tr>
								
								            <!-- Owned By User ID -->
								            <tr>
								                <th>Owned By User ID</th>
								                <td><input type="number" class="form-control" name="ownedByUserId" placeholder="Owned By User ID"></td>
								            </tr>
								
								            <!-- Owned By User First Name -->
								            <tr>
								                <th>Owned By User First Name</th>
								                <td><input type="text" class="form-control" name="ownedByUserFirstName" placeholder="Owned By User First Name"></td>
								            </tr>
								
								            <!-- Owned By User Phone -->
								            <tr>
								                <th>Owned By User Phone</th>
								                <td><input type="text" class="form-control" name="ownedByUserPhone" placeholder="Owned By User Phone"></td>
								            </tr>
								
								            <!-- Owned By User Email -->
								            <tr>
								                <th>Owned By User Email</th>
								                <td><input type="text" class="form-control" name="ownedByUserEmail" placeholder="Owned By User Email"></td>
								            </tr>
								
								            <!-- Location ID -->
								            <tr>
								                <th>Location ID</th>
								                <td><input type="number" class="form-control" name="locationId" placeholder="Location ID"></td>
								            </tr>
								
								            <!-- Location Name -->
								            <tr>
								                <th>Location Name</th>
								                <td><input type="text" class="form-control" name="locationName" placeholder="Location Name"></td>
								            </tr>
								
								            <!-- Location Address -->
								            <tr>
								                <th>Location Address</th>
								                <td><input type="text" class="form-control" name="locationAddress" placeholder="Location Address"></td>
								            </tr>
								
								            <!-- Location Available -->
								            <tr>
								                <th>Location Available</th>
								                <td>
								                    <select class="form-control" name="locationAvailable">
								                        <option value="">-- Select --</option>
								                        <option value="true">True</option>
								                        <option value="false">False</option>
								                    </select>
								                </td>
								            </tr>
								
								            <!-- Plant Date -->
								            <tr>
								                <th>Plant Date</th>
								                <td><input type="date" class="form-control" name="plantDate"></td>
								            </tr>
								
								            <!-- Maturity Date -->
								            <tr>
								                <th>Maturity Date</th>
								                <td><input type="date" class="form-control" name="maturityDate"></td>
								            </tr>
								
								            <!-- Light Duration -->
								            <tr>
								                <th>Light Duration</th>
								                <td><input type="number" class="form-control" name="lightDuration" placeholder="Light Duration"></td>
								            </tr>
								
								            <!-- Water pH -->
								            <tr>
								                <th>Water pH</th>
								                <td><input type="number" step="0.1" class="form-control" name="waterPH" placeholder="Water pH"></td>
								            </tr>
								
								            <!-- Temperature (in Celsius) -->
								            <tr>
								                <th>Temperature (in Celsius)</th>
								                <td><input type="number" step="0.1" class="form-control" name="temperatureC" placeholder="Temperature"></td>
								            </tr>
								
								            <!-- Humidity -->
								            <tr>
								                <th>Humidity</th>
								                <td><input type="number" step="0.1" class="form-control" name="humidity" placeholder="Humidity"></td>
								            </tr>
								
								            <!-- Added By User ID -->
								            <tr>
								                <th>Added By User ID</th>
								                <td><input type="number" class="form-control" name="addedByUserId" placeholder="Added By User ID"></td>
								            </tr>
								
								            <!-- Added By User First Name -->
								            <tr>
								                <th>Added By User First Name</th>
								                <td><input type="text" class="form-control" name="addedByUserFirstName" placeholder="Added By User First Name"></td>
								            </tr>
								
								            <!-- Added By User Phone -->
								            <tr>
								                <th>Added By User Phone</th>
								                <td><input type="text" class="form-control" name="addedByUserPhone" placeholder="Added By User Phone"></td>
								            </tr>
								
								            <!-- Added By User Email -->
								            <tr>
								                <th>Added By User Email</th>
								                <td><input type="text" class="form-control" name="addedByUserEmail" placeholder="Added By User Email"></td>
								            </tr>
								
								            <!-- Added By User Role -->
								            <tr>
								                <th>Added By User Role</th>
								                <td><input type="text" class="form-control" name="addedByUserRole" placeholder="Added By User Role"></td>
								            </tr>
								
								        </tbody>
									</table>
									
									 <button type="submit" class="btn btn-primary">Search</button>									
								</form>
						    </div>						    
						</div>					
					</div>
					
					
					
					<div class="bg-white p-20 m-t-20 bordered">
						<b class="text-muted m-b-10 d-block">Finding Result</b>
						<%
							List<Environment> searchResult = (List<Environment>) request.getAttribute("searchResult");
							Object myAttribute = request.getAttribute("searchResult");
						  	if (myAttribute == null) {						  		
						  		%>
						  			<h1 class="text-info text-center">To find environment select any criteria</h1>
						  		<%
						  	}else if(searchResult == null || searchResult.size() <= 0){
						  		%>
					  				<h1 class="text-danger text-center">No environments found!!</h1>
					  			<%
						  	} else {					        
						  		%>
						  		    <h1 class="text-success text-center">Found ${searchResult.size()} environments</h1>						  		    
						  		<%						  		
						  		for(Environment environment: searchResult){
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
						  		    		</div>
						  		    		<a href="/environment/<%=environment.getId()%>" style="width:fit-content; margin-left: auto;margin-right: 0;" class="btn btn-primary d-block m-t-10">View full details</a>
						  		    	</div>					  		    
						  			<%
						  		}
						  	}
						  	
						%>						
					</div>
				</section>				
			</div>
		</div>
	</div>
<%!
    private String formatDate(Date date) {
        SimpleDateFormat sdf = new SimpleDateFormat("dd MMMM, yyyy", new Locale("en"));
        return sdf.format(date);
    }
%>

	<!-- Required Jqurey -->
	<script src="assets/plugins/Jquery/dist/jquery.min.js"></script>
	<script src="assets/plugins/jquery-ui/jquery-ui.min.js"></script>
	<script src="assets/plugins/tether/dist/js/tether.min.js"></script>
	
	<!-- Select 2 js -->
   <script src="assets/plugins/select2/dist/js/select2.full.min.js"></script>
	

	<!-- Required Fremwork -->
	<script src="assets/plugins/bootstrap/js/bootstrap.min.js"></script>

	<!-- Scrollbar JS-->
	<script src="assets/plugins/jquery-slimscroll/jquery.slimscroll.js"></script>
	<script src="assets/plugins/jquery.nicescroll/jquery.nicescroll.min.js"></script>

	<!--classic JS-->
	<script src="assets/plugins/classie/classie.js"></script>

	<!-- notification -->
	<script src="assets/plugins/notification/js/bootstrap-growl.min.js"></script>

	<!-- Sparkline charts -->
	<script src="assets/plugins/jquery-sparkline/dist/jquery.sparkline.js"></script>

	<!-- Counter js  -->
	<script src="assets/plugins/waypoints/jquery.waypoints.min.js"></script>
	<script src="assets/plugins/countdown/js/jquery.counterup.js"></script>

	<!-- Echart js -->
	<script src="assets/plugins/charts/echarts/js/echarts-all.js"></script>

	<!-- custom js -->
	<script type="text/javascript" src="assets/js/main.min.js"></script>
	<script type="text/javascript" src="assets/pages/dashboard.js"></script>
	<script type="text/javascript" src="assets/pages/elements.js"></script>
	<script src="assets/js/menu.min.js"></script>
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