<%@page import="com.hydroponics.management.system.payloads.ServerMessage"%>
<%@page import="com.hydroponics.management.system.entities.Environment"%>
<%@page import="java.util.List"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<title>Generate Fake Data</title>
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
						<h4>Add Fake Data</h4>
					</div>
				</div>



				<section class="min-h-80vh">
				    <div class="bg-white p-20 bordered">
				    
				    	<%
				    		List<Environment> environmentList = (List<Environment>) request.getAttribute("environmentList");
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
				    	<form class="form-horizontal" method="post" action="/generate-data/">
				        <table class="table table-striped bordered">
				            
				            <tbody>
				            	<tr>
				                    <th>Select Environment</th>
				                    <td>				                    	
				                    	<select id="selectEnvironment" class="form-control" name="environmentId" required="required" >
									        <option value="">-- Select Environment --</option>
									        <%										            
									            if (environmentList != null && environmentList.size() > 0) {
									                for (Environment environment : environmentList) {
									        %>
									                    <option value="<%= environment.getId() %>">
									                        <%="ENV_"+ environment.getId() +" -> Plant: \"" +environment.getPlantName()+ "\" || Location: \"" + environment.getLocation().getFullAddress() +"\" || Owner: " + environment.getOwnedBy().getFirstName() +" "+ environment.getOwnedBy().getLastName() %>
									                    </option>
									        <%
									                }
									            }
									        %>
										</select>
				                    </td>
				                </tr>					             			                
				            </tbody>
				        </table>
				        
				        <h1>Set Environment value</h1>
				        <table class="table table-striped bordered">
				            <tr>
				                <th>Mineral name</th>
				                <th>Base value</th>
				                <th>Your value	</th>
				            </tr>
				            <tbody id="environmentElementBody">				            
				                		                
				            </tbody>
				        </table>	
				        
				        
				        <h1>Set minerals value</h1>
				        <table class="table table-striped bordered" id="setMineralTable">
				            <tr>
				                <th>Mineral name</th>
				                <th>Base value</th>
				                <th>Your value	</th>
				            </tr>
				            <tbody id="mineralTableBody">
				            				                
				            </tbody>
				        </table>				        
				
				        <button type="submit" class="btn btn-primary">Upload Data</button>
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

	<!-- custom js -->
	<script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/main.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/assets/pages/dashboard.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/assets/pages/elements.js"></script>
	<script src="${pageContext.request.contextPath}/assets/js/menu.min.js"></script>

	<script>
    $(document).ready(function () {
        // Initialize select2
        $("#selectEnvironment").select2();

        // Capture the change event when an option is selected
        $("#selectEnvironment").on("change", function () {
            // Get the selected environment ID
            var selectedEnvironmentId = $(this).val();

            // Check if a valid ID is selected
            if (selectedEnvironmentId) {
                // Perform AJAX request to fetch data for the selected environment
                $.ajax({
                    type: "GET",
                    //url: "/environment/get-minerals/" + selectedEnvironmentId,
                    url: "/environment/fake-data/" + selectedEnvironmentId,
                    success: function (env) {
                        console.log(env);
                        var minerals = env.minerals;
                        // Clear previous mineral rows
                        $("#mineralTableBody").empty();
                        $("#environmentElementBody").empty();
                        
                        var row1 = `
                        <tr>
		                    <th>Light Duration</th>
		                    <td><b>`+env.lightDuration+` Hours</b></td>
		                    <td><input type="number" required="required"  class="form-control" name="lightDuration" placeholder="Light Duration"></td>
		                </tr>
		                <tr>
		                    <th>Water pH</th>
		                    <td><b>`+env.waterPH+`</b></td>
		                    <td><input type="number" required="required"  step="0.1" class="form-control" name="waterPH" placeholder="Water pH"></td>
		                </tr>
		                <tr>
		                    <th>Temperature (°C)</th>
		                    <td><b>`+env.temperatureC+`°C </b></td>
		                    <td><input type="number" required="required"  step="0.1" class="form-control" name="temperatureC" placeholder="Temperature (°C)"></td>
		                </tr>
		                <tr>
		                    <th>Humidity</th>
		                    <td><b>`+env.humidity+`</b></td>
		                    <td><input type="number" required="required"  step="0.1" class="form-control" name="humidity" placeholder="Humidity"></td>
		                </tr>
                        `;                             

                        $("#environmentElementBody").append(row1);
					
                        // Dynamically create input fields for each mineral
                        for (var i = 0; i < minerals.length; i++) {
                            var mineral = minerals[i];
                            var row = "<tr>" +
                                "<th>" + mineral.mineralName + "</th>" +
                                "<th>" + mineral.mineralAmount + " / "+mineral.mineralUnit+"</th>" +
                                "<td><input type='number' required='required' step='0.1' class='form-control' name='minerals[" + i + "].mineralAmount' placeholder='" + mineral.mineralName + " Amount'>"+"<input type='number' hidden  name='minerals[" + i + "].mineralId' value='" + mineral.id + "'> "+"</td>" +                                
                                "</tr>";
                           $("#mineralTableBody").append(row);
                        }
                    },
                    error: function (error) {
                        // Handle the error response
                        console.error("Error fetching minerals data:", error);
                    }
                });
            }
        });
    });
</script>


</body>

</html>