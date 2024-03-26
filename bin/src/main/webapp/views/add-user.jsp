<!DOCTYPE html>
<%@page import="com.hydroponics.management.system.payloads.ServerMessage"%>
<%@page import="org.springframework.validation.FieldError"%>
<%@page import="org.springframework.validation.BindingResult"%>
<%@page import="com.hydroponics.management.system.DTO.UserDTO"%>
<html lang="en">
<%! String linkPrefix = ""; %>
<head>
    <title>LeafLab - Add User</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1.0, user-scalable=no">
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="description" content="Leaf Lab - a Hydroponics Management System solution">
    <meta name="keywords"
        content="Hydroponics, Register, Shubrato, Hydroponics Management System, KYAU Hydroponics,  KYAU">
    <meta name="author" content="Shubrato Debnath">
	<!-- Favicon icon -->
	<link rel="shortcut icon" href="${pageContext.request.contextPath}/assets/images/favicon.png" type="image/x-icon">
	<link rel="icon" href="${pageContext.request.contextPath}/assets/images/favicon.ico" type="image/x-icon">
	
	
    <!-- Google font-->
<!--     <link href="https://fonts.googleapis.com/css?family=Ubuntu:400,500,700" rel="stylesheet"> -->

    <!-- themify -->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/icon/themify-icons/themify-icons.css">

    <!-- iconfont -->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/icon/icofont/css/icofont.css">

    <!-- simple line icon -->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/icon/simple-line-icons/css/simple-line-icons.css">

    <!-- Required Fremwork -->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/plugins/bootstrap/css/bootstrap.min.css">

    <!-- Chartlist chart css -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/plugins/chartist/dist/chartist.css" type="text/css" media="all">

    <!-- Weather css -->
    <link href="${pageContext.request.contextPath}/assets/css/svg-weather.css" rel="stylesheet">


    <!-- Style.css -->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/main.css">

    <!-- Responsive.css-->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/responsive.css">
    
    <style type="text/css">
    	.error-message{
    		color: red;
    		font-size: 12px;
    	}
    
    </style>

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
		
		
		
        <div class="content-wrapper">
            <!-- Container-fluid starts -->
            <!-- Main content starts -->
            <div class="container-fluid">
                <div class="row">
                    <div class="main-header">
                        <h4>Add user</h4>
                    </div>
                </div>
                
		<section class="register">
        <!-- Container-fluid starts -->
        <div class="container-fluid">
            <div class="row">
                <div class="col-sm-12">
                    <div class="register-card card-block m-b-3">
                    
                 <%
                    UserDTO userDTO = null;
                    BindingResult inputErrors = null;

                    if (request.getAttribute("userDTO") != null) {
                        userDTO = (UserDTO) request.getAttribute("userDTO");
                    }

                    if (request.getAttribute("inputErrors") != null) {
                        inputErrors = (BindingResult) request.getAttribute("inputErrors");
                    }
                %>

                <form class="md-float-material" action="/add-user" enctype="multipart/form-data" method="post">
                    <div class="text-center">
                        <a href="/">
                            <img class="full-logo-lg" src="${pageContext.request.contextPath}/assets/images/logo-black.png" alt="logo">
                        </a>
                    </div>
                    <h3 class="text-center txt-primary m-y-2">Create an account </h3>
                    
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
					
                    
                    <div class="row">
                        <div class="col-md-6">
                            <div class="md-input-wrapper">
                                <input type="text" class="md-form-control" name="firstName"
                                    value="<%= userDTO != null ? userDTO.getFirstName() : "" %>">
                                <label>First Name</label>

                                <ul class="error-message">
                                    <%
                                        if (inputErrors != null && inputErrors.getFieldErrors("firstName").size() > 0) {
                                            for (FieldError error : inputErrors.getFieldErrors("firstName")) {
                                    %>
                                    <li><%= error.getDefaultMessage() %></li>
                                    <%
                                            }
                                        }
                                    %>
                                </ul>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="md-input-wrapper">
                                <input type="text" class="md-form-control" name="lastName"
                                    value="<%= userDTO != null ? userDTO.getLastName() : "" %>">
                                <label>Last Name</label>

                                <ul class="error-message">
                                    <%
                                        if (inputErrors != null && inputErrors.getFieldErrors("lastName").size() > 0) {
                                            for (FieldError error : inputErrors.getFieldErrors("lastName")) {
                                    %>
                                    <li><%= error.getDefaultMessage() %></li>
                                    <%
                                            }
                                        }
                                    %>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <!-- Add similar code for other input fields -->
                    
                      <div class="md-input-wrapper">
                         <input type="text" class="md-form-control" name="phone"
                             value="<%= userDTO != null ? userDTO.getPhone() : "" %>">
                         <label>Phone number</label>

                         <ul class="error-message">
                             <%
                                 if (inputErrors != null && inputErrors.getFieldErrors("phone").size() > 0) {
                                     for (FieldError error : inputErrors.getFieldErrors("phone")) {
                             %>
                             <li><%= error.getDefaultMessage() %></li>
                             <%
                                     }
                                 }
                             %>
                         </ul>
                     </div>
                     
                        <div class="md-input-wrapper">
                         <input type="email" class="md-form-control" name="email"
                             value="<%= userDTO != null ? userDTO.getEmail() : "" %>">
                         <label>Email</label>

                         <ul class="error-message">
                             <%
                                 if (inputErrors != null && inputErrors.getFieldErrors("email").size() > 0) {
                                     for (FieldError error : inputErrors.getFieldErrors("email")) {
                             %>
                             <li><%= error.getDefaultMessage() %></li>
                             <%
                                     }
                                 }
                             %>
                         </ul>
                     </div>
						
                     <div class="md-input-wrapper">
                         <input type="text" class="md-form-control" name="address"
                             value="<%= userDTO != null ? userDTO.getAddress() : "" %>">
                         <label>Address</label>

                         <ul class="error-message">
                             <%
                                 if (inputErrors != null && inputErrors.getFieldErrors("address").size() > 0) {
                                     for (FieldError error : inputErrors.getFieldErrors("address")) {
                             %>
                             <li><%= error.getDefaultMessage() %></li>
                             <%
                                     }
                                 }
                             %>
                         </ul>
                     </div>
                     
                        
					<div class="form-group">
					    <label>User image <span class="text-muted">(jpg/jpeg/png only)</span></label>
					    <input type="file" class="form-control" name="file" value="<%= userDTO != null ? userDTO.getFile() : "" %>">
					    
					    <ul class="error-message">
					        <%
					            if (inputErrors != null && inputErrors.getFieldErrors("file").size() > 0) {
					                for (FieldError error : inputErrors.getFieldErrors("file")) {
					        %>
					        <li><%= error.getDefaultMessage() %></li>
					        <%
					                }
					            }
					        %>
					    </ul>
					</div>


                    <!-- Add similar code for other input fields -->

                    <div class="md-input-wrapper">
                        <input type="password" class="md-form-control" name="password" value="<%= userDTO != null ? userDTO.getPassword() : "" %>">
                        <label>Password</label>

                        <ul class="error-message">
                            <%
                                if (inputErrors != null && inputErrors.getFieldErrors("password").size() > 0) {
                                    for (FieldError error : inputErrors.getFieldErrors("password")) {
                            %>
                            <li><%= error.getDefaultMessage() %></li>
                            <%
                                    }
                                }
                            %>
                        </ul>
                    </div>
                    <div class="md-input-wrapper">
                        <input type="password" class="md-form-control" name="confirmPassword" value="<%= userDTO != null ? userDTO.getConfirmPassword() : "" %>">
                        <label>Confirm Password</label>

                        <ul class="error-message">
                            <%
                                if (inputErrors != null && inputErrors.getFieldErrors("confirmPassword").size() > 0) {
                                    for (FieldError error : inputErrors.getFieldErrors("confirmPassword")) {
                            %>
                            <li><%= error.getDefaultMessage() %></li>
                            <%
                                    }
                                }
                            %>
                        </ul>
                    </div>

                    <!-- Add similar code for other input fields -->

                    <div class="form-group">
                        <label>User Role</label>
                        <select name="role" class="form-control">
                            <option value="">-- Select User Role --</option>
                            <option value="User"
                                <%= userDTO != null && "User".equals(userDTO.getRole()) ? "selected" : "" %>>User
                            </option>
                            <option value="Admin"
                                <%= userDTO != null && "Admin".equals(userDTO.getRole()) ? "selected" : "" %>>Admin
                            </option>
                            <option value="Staff"
                                <%= userDTO != null && "Staff".equals(userDTO.getRole()) ? "selected" : "" %>>Staff
                            </option>
                        </select>

                        <ul class="error-message">
                            <%
                                if (inputErrors != null && inputErrors.getFieldErrors("role").size() > 0) {
                                    for (FieldError error : inputErrors.getFieldErrors("role")) {
                            %>
                            <li><%= error.getDefaultMessage() %></li>
                            <%
                                    }
                                }
                            %>
                        </ul>
                    </div>

                    <!-- Add similar code for other input fields -->

                    <div class="rkmd-checkbox checkbox-rotate checkbox-ripple b-none m-b-20">
                        <label class="input-checkbox checkbox-primary">
                            <input type="checkbox" id="checkbox"
                                >
                            <span class="checkbox"></span>
                        </label>
                        <div class="captions">Agree with terms & condition</div>
                    </div>
                    <div class="col-xs-10 offset-xs-1">
                        <button type="submit"
                            class="btn btn-primary btn-md btn-block waves-effect waves-light m-b-20">Sign up
                        </button>
                    </div>
                    <div class="row">
                        <div class="col-xs-12 text-center">
                            <span class="text-muted">Already have an account?</span>
                            <a href="login1.html" class="f-w-600 p-l-5"> Sign In Here</a>
                        </div>
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


    <!-- Required Jqurey -->
    <script src="${pageContext.request.contextPath}/assets/plugins/Jquery/dist/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/plugins/jquery-ui/jquery-ui.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/plugins/tether/dist/js/tether.min.js"></script>

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
 // Select all input elements within .md-input-wrapper elements
    const inputs = document.querySelectorAll(".md-input-wrapper input");

    // Loop through each input
    inputs.forEach(input => {
      // Check if the input has a value
      if (input.value.trim()) {
        // Add the "md-valid" class
        input.classList.add("md-valid");
      }
    });

</script>
    
</body>

</html>