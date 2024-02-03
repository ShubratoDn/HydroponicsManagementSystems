<%@page import="com.hydroponics.management.system.payloads.EnvAndFieldData"%>
<%@page import="com.hydroponics.management.system.entities.FieldData"%>
<%@page import="com.hydroponics.management.system.entities.MineralData"%>
<%@page import="com.hydroponics.management.system.servicesImple.HelperServices"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Locale"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.hydroponics.management.system.entities.Mineral"%>
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


		<%	
			HelperServices helperServices = new HelperServices();
    		Environment env = (Environment) request.getAttribute("environment");						
		%>
		
		<div class="content-wrapper">
		    <!-- Container-fluid starts -->
		    <!-- Main content starts -->
		    <div class="container-fluid">
		        <div class="row">
		            <div class="main-header">
		                <h4>Environment <%= env != null ? "ENV_" + env.getId() : "<span class='text-danger'>ERROR!</span>" %> </h4>
		            </div>
		        </div>
		
		        <section class="min-h-80vh">
		            <div class="bg-white p-20 bordered">
		                <!-- Display Environment Data -->
		                <% if (env != null) { %>
		                    <div class="row">
		                        <div class="col-md-6">
		                            <h5>Plant Information</h5>
		                            <p><strong>Plant Name:</strong> <%= env.getPlantName() %></p>
		                            <p><strong>Planted Date:</strong> <%= formatDate(env.getPlantDate()) %></p>
		                            <p><strong>Maturity Date:</strong> <%= formatDate(env.getMaturityDate()) %></p>
		                            <p><strong>Total completed:</strong> <%=helperServices.calculateCompletionPercentage(env.getPlantDate(), env.getMaturityDate()) %>%</p>
		                            <p><strong>Owner by: </strong><a href="/user/<%=env.getOwnedBy().getId()%>"><%=env.getOwnedBy().getFirstName() + " " + env.getOwnedBy().getLastName() %></a></p> 
		                        </div>
		                        <div class="col-md-6">
		                            <h5>Environmental Conditions</h5>
		                            <p><strong>Light Duration:</strong> <%= env.getLightDuration() %> hours</p>
		                            <p><strong>Water pH:</strong> <%= env.getWaterPH() %></p>
		                            <p><strong>Temperature:</strong> <%= env.getTemperatureC() %> °C</p>
		                            <p><strong>Humidity:</strong> <%= env.getHumidity() %></p>
		                        </div>
		                    </div>
		                    
		                    <br>
		
		                    <h5>Location Information</h5>
		                    <p><strong>Location:</strong> <%= env.getLocation().getLocationName() + ", " + env.getLocation().getFullAddress() %></p>
		
							<br>
		                    <h5>Minerals</h5>
		                    <% if (env.getMinerals() != null && !env.getMinerals().isEmpty()) { %>
		                        <ul>
		                            <% for (Mineral mineral : env.getMinerals()) { %>
		                                <li><strong><%= mineral.getMineralName() %>:</strong> <%= mineral.getMineralAmount() %> <%= mineral.getMineralUnit() %></li>
		                            <% } %>
		                        </ul>
		                    <% } else { %>
		                        <p>No mineral data available.</p>
		                    <% } %>
		                    <br>
		                    
		                    <%
		                    	if(loggedUser.getRole().equalsIgnoreCase("owner") || loggedUser.getRole().equalsIgnoreCase("admin")){
		                    		%>
		                    			<a href="/environment/update/<%=env.getId()%>" class="btn btn-primary">Update Environment</a>
		                    		<%	
		                    	}else{
		                    		out.print("<div class='text-muted font-10'>Want to update this environment? <a href='contact-us'>Contact Us</a></div>");
		                    	}
		                    %>
		                    
		                    
		                <% } else { %>
		                    <h1 class="text-danger text-center">Nothing found or Unauthorized!!</h1>
		                <% } %>
		            </div>
		            <br>
		            
		            <!-- Environment data analysis -->
		            <div class="bg-white p-20 bordered">
		            	
           				<div class="card">
                            <div class="card-header">
                                <h5 class="card-header-text">Bar chart : ENV_<%=env.getId() %></h5>			                                
                            </div>
                            <div class="card-block">
                                <div id="barchart_ENV_<%=env.getId()%>" style="min-width: 250px; height: 330px; margin: 0 auto"></div>
                            </div>
                        </div>   
		            	
		            	
		            </div>
		        </section>
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

	<script src="${pageContext.request.contextPath}/assets/plugins/charts/highchart/highcharts.js"></script>
    <script src="${pageContext.request.contextPath}/assets/plugins/charts/highchart/modules/exporting.js"></script>
    <script src="${pageContext.request.contextPath}/assets/plugins/charts/highchart/highcharts-3d.js"></script>

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
	
	
	<% 		
	
			EnvAndFieldData envFieldData = (EnvAndFieldData) request.getAttribute("envFieldData");
       
       		List<FieldData> fieldDatas = envFieldData.getFieldData();     	
 			        
 			        
 			List<String> mineralNames = new ArrayList<>();
 		    List<List<Double>> mineralValuesList = new ArrayList<>();
 		    
 		    
 			int count = 0;
 			for (FieldData fieldData : fieldDatas) {				
 			 	//getting the mineral names from first index only
 				if (count == 0) {
 					List<MineralData> mineralDataList = fieldData.getMineralDataList();
     				for (MineralData mineralData : mineralDataList) {
     					mineralNames.add("'" + mineralData.getMineral().getMineralName() + "'");
     				}
 				}
 				
 				List<Double> mineralValues = new ArrayList<>();
 	            for (MineralData mineralData : fieldData.getMineralDataList()) {
 	                mineralValues.add(mineralData.getMineralValue());
 	            }
 	            mineralValuesList.add(mineralValues);			
 				
     			count++;
 			}
 		%>
	<script type="text/javascript">
	    Highcharts.chart('barchart_ENV_<%=env.getId()%>', {
	        title: {
	            text: 'Data Analysis for ENV_<%=env.getId()%>'
	        },
	        xAxis: {
	            categories: [<%
	                for (FieldData fieldData : fieldDatas) {
	                    // Format timestamp as "hh:mm a, dd MMM, yyyy"
	                    String formattedTimestamp = new java.text.SimpleDateFormat("hh:mm a; dd MMM, yyyy")
	                        .format(fieldData.getTimestamp());
	                    out.print("'" + formattedTimestamp + "', ");
	                }
	            %>]
	        },
	        labels: {
	            items: [{
	                html: 'Field Data Analysis HTML',
	                style: {
	                    left: '130px',
	                    top: '18px',
	                    color: (Highcharts.theme && Highcharts.theme.textColor) || 'black'
	                }
	            }]
	        },
	        series: [{
	            type: 'column',
	            name: 'Light Duration',
	            data: [<%
	                for (FieldData fieldData : fieldDatas) {
	                    out.print(fieldData.getLightDuration() + ", ");
	                }
	            %>],
	            color: '#f57c00'
	        }, {
	            type: 'column',
	            name: 'Water PH',
	            data: [<%
	                for (FieldData fieldData : fieldDatas) {
	                    out.print(fieldData.getWaterPH() + ", ");
	                }
	            %>],
	            color: '#2BBBAD'
	        }, {
	            type: 'column',
	            name: 'Water Tempareture',
	            data: [<%
	                for (FieldData fieldData : fieldDatas) {
	                    out.print(fieldData.getTemperatureC() + ", ");
	                }
	            %>],
	            color: '#39444e'
	        }, {
	            type: 'column',
	            name: 'Humidity',
	            data: [<%
	                for (FieldData fieldData : fieldDatas) {
	                    out.print(fieldData.getHumidity() + ", ");
	                }
	            %>]
	        	
	        },
	        
	        <%for (int i = 0; i < mineralNames.size(); i++) {
	        	
	               	String valueSet = "";	       	             
       	          for (FieldData fieldData : fieldDatas) {
       	              for (MineralData mineralData : fieldData.getMineralDataList()) {
       	                  if (mineralData.getMineral().getMineralName().equals(mineralNames.get(i).replace("'", ""))) {
       	                      valueSet += mineralData.getMineralValue() + ",";
       	                  }
       	              }
       	          }
				%>
        		{
        	        type: 'column',
        	        name: <%= mineralNames.get(i) %>,
        	        data: [<%=valueSet%>]			        	        
        	    },
        		<%
	        	}
	        %>
		        			        
	        ]
	    });
	</script>
	
</body>

</html>

<%!
    private String formatDate(Date date) {
        SimpleDateFormat sdf = new SimpleDateFormat("dd MMMM, yyyy", new Locale("en"));
        return sdf.format(date);
    }
%>