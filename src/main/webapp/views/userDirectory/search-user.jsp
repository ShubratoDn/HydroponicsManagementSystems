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


    
<!DOCTYPE html>
<html>
<head>
<title>Search User</title>
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
						<h4>Search Users</h4>
					</div>
				</div>
				<section class="min-h-80vh">
		            <div class="bg-white p-20 bordered">	
		            
			            <div class="form-gorup border m-b-30">
							<label>Search Query</label>
							<div class="d-flex">
								<input placeholder="Search Query" type="search" class="form-control m-r-10" id="search_query_input">
								<button class="btn btn-success" id="search_btn">Search</button>	
							</div>					
						</div>
		            	
		            	<div class="border">
		            		<h4>Search Result</h4>						
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
		                        <tbody id="search_result">
		                        	<tr><td colspan="10" class="text-primary text-center" style="font-size: 30px;">Insert search query tag</td></tr>			            	      
		                        </tbody>
		                    </table>
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
    <script src="${pageContext.request.contextPath}/assets/plugins/websocket/sockjs.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/plugins/websocket/stomp.min.js"></script>    

    <script type="text/javascript">
        // Include the base context path in a JavaScript variable
        var contextPath = '<%= request.getContextPath() %>';
        var userId = '<%=loggedUser != null ? loggedUser.getId() : null %>';
    </script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/notification.js"></script>
	
	

<script>
    $(document).ready(function () {	
    	
        // Capture the value change event of the search input
        $('#search_query_input').on('input', function () {
            // Get the search query value
            var searchQuery = $(this).val();

            // Make an AJAX request to the server
            $.ajax({
                type: 'POST',
                url: '/api/user/search/result',
                data: { search_query: searchQuery },
                success: function (data) {
                    // Update the table with the search results
                    updateTable(data);
                },
                error: function (error) {
                    console.error('Error:', error);
                }
            });
        });

        $('#search_btn').on('click', function () {    		
    		var searchQuery = $("#search_query_input").val();
    		// Make an AJAX request to the server
            $.ajax({
                type: 'POST',
                url: '/api/user/search/result',
                data: { search_query: searchQuery },
                success: function (data) {
                    // Update the table with the search results
                    updateTable(data);
                },
                error: function (error) {
                    console.error('Error:', error);
                }
            });
    	});
        
        // Function to update the table with search results
        function updateTable(data) {
            // Clear existing table rows
            $('#search_result').empty();

            if (data.length === 0) {
                // Display a single row with "Not Found" message
                var notFoundRow = '<tr><td colspan="10" class="text-danger text-center" style="font-size: 30px;">No Match Found</td></tr>';
                $('#search_result').append(notFoundRow);
            }else{
            	 // Iterate through the search results and append rows to the table
                $.each(data, function (index, user) {
                    var row = '<tr>' +
                        '<td>' + user.id + '</td>' +
                        '<td>' + user.firstName + ' ' + user.lastName + '</td>' +
                        '<td><img class="user-table-image" src="<%=request.getContextPath() %>/assets/images/userimages/'+user.image+'"></td>' +
                        '<td>' + user.role + '</td>' +
                        '<td>' + user.phone + '</td>' +
                        '<td>' + user.email + '</td>' +
                        '<td>' + user.address + '</td>' +
                        '<td>' + formatDate(user.registrationDate) + '</td>' +
                        '<td>' + (user.addedBy ? user.addedBy.firstName + ' ' + user.addedBy.lastName : '') + '</td>' +
                        '<td class="d-flex"><a href="/user/'+user.id+'" class="btn btn-primary m-r-5"><i class="icon icofont-expand"></i></a><a href="/user/update/'+user.id+'" class="btn btn-success m-r-5"><i class="icon icon-pencil"></i></a><button class="btn btn-danger delete-btn" data-toggle="modal" data-target="#deleteConfirmationModal" data-env-id="" data-env-short-id=""><i class="icon icofont-bin"></i></button></td>'
                        '</tr>';

                    $('#search_result').append(row);
                });
            }
           
        }

       
        
        // Function to format date as "17 October, 2024"
        function formatDate(dateString) {
            const options = { day: 'numeric', month: 'long', year: 'numeric' };
            return new Date(dateString).toLocaleDateString('en-US', options);
        }
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