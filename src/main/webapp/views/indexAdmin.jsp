<!DOCTYPE html>
<%@page import="java.util.Locale"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="com.hydroponics.management.system.entities.User"%>
<%@page import="com.hydroponics.management.system.payloads.AdminHomePageData"%>
<html lang="en">

<head>
    <title>LeafLab - a Hydroponics Management System</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1.0, user-scalable=no">
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="description" content="Leaf Lab - a Hydroponics Management System solution">
    <meta name="keywords"
        content="Hydroponics, Register, Shubrato, Hydroponics Management System, KYAU Hydroponics,  KYAU">
    <meta name="author" content="Shubrato Debnath">
	<!-- Favicon icon -->
	<link rel="shortcut icon" href="assets/images/favicon.png" type="image/x-icon">
	<link rel="icon" href="assets/images/favicon.ico" type="image/x-icon">
	
	
    <!-- Google font-->
    <link href="https://fonts.googleapis.com/css?family=Ubuntu:400,500,700" rel="stylesheet">

    <!-- themify -->
    <link rel="stylesheet" type="text/css" href="assets/icon/themify-icons/themify-icons.css">

    <!-- iconfont -->
    <link rel="stylesheet" type="text/css" href="assets/icon/icofont/css/icofont.css">

    <!-- simple line icon -->
    <link rel="stylesheet" type="text/css" href="assets/icon/simple-line-icons/css/simple-line-icons.css">

    <!-- Required Fremwork -->
    <link rel="stylesheet" type="text/css" href="assets/plugins/bootstrap/css/bootstrap.min.css">

    <!-- Chartlist chart css -->
    <link rel="stylesheet" href="assets/plugins/chartist/dist/chartist.css" type="text/css" media="all">

    <!-- Weather css -->
    <link href="assets/css/svg-weather.css" rel="stylesheet">


    <!-- Style.css -->
    <link rel="stylesheet" type="text/css" href="assets/css/main.css">

    <!-- Responsive.css-->
    <link rel="stylesheet" type="text/css" href="assets/css/responsive.css">

</head>

<body class="sidebar-mini fixed">
    <div class="loader-bg">
        <div class="loader-bar">
        </div>
    </div>
    <div class="wrapper">
        
        <!-- Nav top included -->
        <%@include file="partials/util/nav-top.jsp" %>

        <!-- side nav bar -->
		<%@include file="partials/util/sidenav.jsp" %>
		
		
		<!-- Side bar chat -->
		<%@include file="partials/util/sidebar-chat.jsp" %>
		
		
		<%
			AdminHomePageData reportData = new AdminHomePageData();
			
			reportData = (AdminHomePageData) request.getAttribute("reportData");
		%>

        <div class="content-wrapper">
            <!-- Container-fluid starts -->
            <!-- Main content starts -->
            <div class="container-fluid">
                <div class="row">
                    <div class="main-header">
                        <h4>Dashboard</h4>
                    </div>
                </div>
                <!-- 4-blocks row start -->
                <div class="row dashboard-header">
                    <div class="col-lg-3 col-md-6">
                        <div class="card dashboard-product">
                            <span>Our total active Users</span>
                            <h2 class="dashboard-total-products"><%=reportData.getActiveUsers() %></h2>
                            <span class="label label-warning">Users</span>Activate user
                            <div class="side-box">
                                <i class="ti-user text-warning-color"></i>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="card dashboard-product">
                            <span>Total activate environment</span>
                            <h2 class="dashboard-total-products"><%=reportData.getActiveEnvironment() %></h2>
                            <span class="label label-primary">Environment</span>Active environment
                            <div class="side-box ">
                                <i class="ti-jsfiddle text-primary-color"></i>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="card dashboard-product">
                            <span>New users added today</span>
                            <h2 class="dashboard-total-products"><%=reportData.getUsersRegisterToday().size() %></h2>
                            <span class="label label-success">Users</span>Users join us
                            <div class="side-box">
                                <i class="ti-face-smile text-success-color"></i>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="card dashboard-product">
                            <span>Available Location to plant</span>
                            <h2 class="dashboard-total-products"><%=reportData.getAvailableLocation() %></h2>
                            <span class="label label-danger">Location</span>Available location
                            <div class="side-box">
                                <i class="ti-layout text-danger-color"></i>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- 4-blocks row end -->

                <!-- 1-3-block row start -->
                <div class="row">
                    
                    <%
                    
                    	if(reportData.getUserWithMostAddedUser() != null){
                    		 Map<User, Long> userTopMap = reportData.getUserWithMostAddedUser();
                   	        List<Map.Entry<User, Long>> entryList = new ArrayList<>(userTopMap.entrySet());
                   	        
                   	        if (entryList.size() > 0) {
                   	            Map.Entry<User, Long> thirdEntry = entryList.get(0);
                   	            User userTop = thirdEntry.getKey();
                   	            Long count = thirdEntry.getValue();
                    		%>
                    		<div class="col-lg-4">
		                        <div class="card">
		                            <div class="user-block-2">
		                                <img class="img-fluid" style="height: 140px; width: 140px; object-fit:cover" src="<%=userTop.getImage() == null? "assets/images/widget/user-1.png" : "assets/images/userimages/"+userTop.getImage() %>" alt="user-header">
		                                <h5><%=userTop.getFirstName() + " " + userTop.getLastName() %></h5>
		                                <h6><%=userTop.getRole() %><span class="text-muted">(Added most users)</span></h6>
		                            </div>
		                            <div class="card-block">
		                                
		                                <div class="user-block-2-activities">
		                                    <div class="user-block-2-active">
		                                        <i class="icofont icofont-users"></i> Added User
		                                        <label class="label label-primary"><%=count %></label>
		                                    </div>
		                                </div>
		
		
										<div class="user-block-2-activities">
		                                    <div class="user-block-2-active">
		                                        <i class="icofont icofont-clock-time"></i> Recent Activities
		                                        <label class="label label-primary">480</label>
		                                    </div>
		                                </div>
		
		                                <div class="user-block-2-activities">
		                                    <div class="user-block-2-active">
		                                        <i class="icofont icofont-ui-user"></i> Following
		                                        <label class="label label-primary">485</label>
		                                    </div>
		
		                                </div>
		                                <div class="user-block-2-activities">
		                                    <div class="user-block-2-active">
		                                        <i class="icofont icofont-picture"></i> Pictures
		                                        <label class="label label-primary">506</label>
		                                    </div>
		                                </div>
		                                <div class="text-center">
		                                    <button type="button"
		                                        class="btn btn-warning waves-effect waves-light text-uppercase m-r-30">
		                                        Follows
		                                    </button>
		                                    <button type="button"
		                                        class="btn btn-primary waves-effect waves-light text-uppercase">
		                                        Message
		                                    </button>
		                                </div>
		                            </div>
		                        </div>
		                    </div>
                    		<%
                    		}
                    	}
                    %>
                    
                    
                    <div class="col-lg-8">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="card-header-text">Bar chart</h5>
                            </div>
                            <div class="card-block">
                                <div id="barchart" style="min-width: 250px; height: 330px; margin: 0 auto"></div>
                            </div>
                        </div>
                    </div>
                    <div class="col-xl-4 col-lg-12 grid-item">
                        <div class="card">
                            <div class="card-block horizontal-card-img d-flex">
                                <img class="media-object img-circle" src="assets/images/avatar-3.png"
                                    alt="Generic placeholder image">
                                <div class="d-inlineblock  p-l-20">
                                    <h6>Josephin Doe</h6>
                                    <a href="#">contact@admin.com</a>
                                </div>
                                <h6 class="txt-warning rotate-txt">Designer</h6>
                            </div>
                        </div>
                    </div>
                    <div class="col-xl-4 col-lg-12 grid-item">
                        <div class="card">
                            <div class="card-block horizontal-card-img d-flex">
                                <img class="media-object img-circle" src="assets/images/lockscreen.png"
                                    alt="Generic placeholder image">
                                <div class="d-inlineblock  p-l-20">
                                    <h6>Josephin Doe</h6>
                                    <a href="#">contact@admin.com</a>
                                </div>
                                <h6 class="txt-danger rotate-txt">Developer</h6>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- 1-3-block row end -->

                <!-- 2-1 block start -->
                <div class="row">
                    <div class="col-xl-8 col-lg-12">
                        <div class="card">
                            <div class="card-block">
                            	<h5 class="card-header-text">ENVIRONMENt ANALYSIS</h5>
                                <div class="table-responsive">
                                    <table class="table m-b-0 photo-table">
                                        <thead>
                                            <tr class="text-uppercase">
                                                <th>Photo</th>
                                                <th>Name</th>
                                                <th>Environment Owned</th>
                                                <th>Date Joined</th>                                                   
                                            </tr>
                                        </thead>
                                        <tbody>
                                        	<%
                                        		if(reportData.getUsersWithEnvironmentCount().size() > 0){
                                        			Map<User, Long> userEnvironmentCountMap = reportData.getUsersWithEnvironmentCount(); 
		                                        	for (Map.Entry<User, Long> entry : userEnvironmentCountMap.entrySet()) {
		                                        	    User user = entry.getKey();
		                                        	    Long environmentCount = entry.getValue();
		                                        	    
		                                        	    %>
		                                        	    <tr>
			                                                <th>
			                                                    <img class="img-fluid img-circle" style="height: 40px; width: 40px; object-fit:cover" src="<%=user.getImage() == null? "assets/images/widget/user-1.png" : "assets/images/userimages/"+user.getImage() %>"
			                                                        alt="User">
			                                                </th>
			                                                <td>
			                                                	<%=user.getFirstName() +" " + user.getLastName() %>			                                                	
			                                                	<p class="text-muted"><i class="icofont icofont-user"></i><%=user.getRole() %></p>
			                                                </td>
			                                                <td>
			                                                    <%=environmentCount %>
			                                                </td>			                                                
			                                                <td>
			                                                	<%
			                                                	if(user.getRegistrationDate() != null){
				                                                	SimpleDateFormat sdf = new SimpleDateFormat("dd MMMM, yyyy", new Locale("en"));			                                                    
			                                                		%>
			                                                			<%=sdf.format(user.getRegistrationDate())%>
			                                                		<%
			                                                	}			                                                	
			                                                	%>
			                                                </td>
			                                            </tr>
                                            
		                                        	    <%
		                                        	}
                                        		}
                                        	%>                                        
                                            
                                            
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-xl-4 col-lg-12">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="card-header-text">Bar chart</h5>
                            </div>
                            <div class="card-block">
                                <div id="piechart" style="min-width: 250px; height: 460px; margin: 0 auto"></div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- 2-1 block end -->
            </div>
            <!-- Main content ends -->
            <!-- Container-fluid ends -->
            <div class="fixed-button">
                <a href="#!" class="btn btn-md btn-primary">
                    <i class="fa fa-shopping-cart" aria-hidden="true"></i> Add Environment
                </a>
            </div>
        </div>
    </div>


    <!-- Required Jqurey -->
    <script src="assets/plugins/Jquery/dist/jquery.min.js"></script>
    <script src="assets/plugins/jquery-ui/jquery-ui.min.js"></script>
    <script src="assets/plugins/tether/dist/js/tether.min.js"></script>

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

    <script src="https://code.highcharts.com/highcharts.js"></script>
    <script src="https://code.highcharts.com/modules/exporting.js"></script>
    <script src="https://code.highcharts.com/highcharts-3d.js"></script>

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
	
	
    <script>
        var $window = $(window);
        var nav = $('.fixed-button');
        $window.scroll(function () {
            if ($window.scrollTop() >= 200) {
                nav.addClass('active');
            }
            else {
                nav.removeClass('active');
            }
        });
    </script>

</body>

</html>