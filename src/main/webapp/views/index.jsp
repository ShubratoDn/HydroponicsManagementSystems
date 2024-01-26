<!DOCTYPE html>
<%@page import="java.util.Date"%>
<%@page import="com.hydroponics.management.system.entities.Environment"%>
<%@page import="com.hydroponics.management.system.payloads.UserHomePageData"%>
<%@page import="java.util.Locale"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.hydroponics.management.system.entities.User"%>
<%@page import="com.hydroponics.management.system.servicesImple.HelperServices"%>
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
			HelperServices helperServices = new HelperServices();
			UserHomePageData reportData = new UserHomePageData();
			
			reportData = (UserHomePageData) request.getAttribute("reportData");
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
                            <span>Products</span>
                            <h2 class="dashboard-total-products">4500</h2>
                            <span class="label label-warning">Sales</span>Arriving Today
                            <div class="side-box">
                                <i class="ti-signal text-warning-color"></i>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="card dashboard-product">
                            <span>Products</span>
                            <h2 class="dashboard-total-products">37,500</h2>
                            <span class="label label-primary">Views</span>View Today
                            <div class="side-box ">
                                <i class="ti-gift text-primary-color"></i>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="card dashboard-product">
                            <span>Products</span>
                            <h2 class="dashboard-total-products">$<span>30,780</span></h2>
                            <span class="label label-success">Sales</span>Reviews
                            <div class="side-box">
                                <i class="ti-direction-alt text-success-color"></i>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="card dashboard-product">
                            <span>Products</span>
                            <h2 class="dashboard-total-products">$<span>30,780</span></h2>
                            <span class="label label-danger">Sales</span>Reviews
                            <div class="side-box">
                                <i class="ti-rocket text-danger-color"></i>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- 4-blocks row end -->

                <!-- 1-3-block row start -->
                <div class="row">
                    <div class="col-lg-4">                    	
                        <div class="card">
                            <div class="user-block-2">
                                <img class="img-fluid" style="height: 140px; width: 140px;" src="<%=loggedUser.getImage() == null? "assets/images/widget/user-1.png" : "assets/images/userimages/"+loggedUser.getImage() %>" alt="user-header">
                                <h5><%=loggedUser.getFirstName() + " " + loggedUser.getLastName() %></h5>
                                <h6><%=loggedUser.getRole() %></h6>
                            </div>
                            <div class="card-block">
                                <div class="user-block-2-activities">
                                    <div class="user-block-2-active">
                                        <i class="icofont icofont-clock-time"></i> Date Joined
                                        <label class="label label-primary">
                               				<%
                                          	if(loggedUser.getRegistrationDate() != null){
                                           	SimpleDateFormat sdf = new SimpleDateFormat("dd MMMM, yyyy", new Locale("en"));			                                                    
                                          		%>
                                          			<%=sdf.format(loggedUser.getRegistrationDate())%>
                                          		<%
                                          	}			                                                	
                                          	%>
										</label>
                                    </div>
                                </div>
                                <div class="user-block-2-activities">
                                    <div class="user-block-2-active">
                                        <i class="icofont icofont-envato"></i> Environment Owned
                                        <label class="label label-primary"><%=reportData.getAllEnvironmentsByUser().size() %></label>
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
                                        Note
                                    </button>
                                    <button type="button"
                                        class="btn btn-primary waves-effect waves-light text-uppercase">
                                        Update Profile
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-xl-8 col-lg-12">
                        <div class="card">
                            <div class="card-block">
                                <div class="table-responsive">
                                    <table class="table m-b-0 photo-table">
                                        <thead>
                                            <tr class="text-uppercase">
                                                <th>ID</th>
                                                <th>Plant Name</th>
                                                <th>Location</th>
                                                <th>Completed</th>
                                                <th>Plant Expiry</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        	<%
                                        		for(Environment environment :reportData.getAllEnvironmentsByUser()){
                                        	%>
                                        		
                                            <tr>
                                                <td>ENV_<%=environment.getId() %></td>
                                                <td><%=environment.getPlantName() %></td>
                                                <td><%=environment.getLocation().getFullAddress() %></td>
                                                <td><%=helperServices.calculateCompletionPercentage(environment.getPlantDate(), environment.getMaturityDate()) %>%</td>
                                                <td><%=this.formatDate(environment.getMaturityDate()) %></td>
                                            </tr>
                                            
                                        	<%
                                            	}
                                        	%>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    
                </div>
                <!-- 1-3-block row end -->

                <!-- 2-1 block start -->
                <div class="row">
                    
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


<%!
    private String formatDate(Date date) {
        SimpleDateFormat sdf = new SimpleDateFormat("dd MMMM, yyyy", new Locale("en"));
        return sdf.format(date);
    }
%>