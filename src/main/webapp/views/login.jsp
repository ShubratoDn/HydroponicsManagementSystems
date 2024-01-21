<%! String linkPrefix = ""; %>
<!DOCTYPE html>
<%@page import="com.hydroponics.management.system.payloads.LoginRequest"%>
<%@page import="com.hydroponics.management.system.payloads.ServerMessage"%>
<html lang="en">
<head>
	<title>LeafLab - Login</title>
    <!-- Meta -->
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1.0, user-scalable=no">
	<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
	<meta name="description" content="Leaf Lab - a Hydroponics Management System solution">
	<meta name="keywords" content="Hydroponics, Login, Shubrato, Hydroponics Management System, KYAU Hydroponics,  KYAU">
	<meta name="author" content="Shubrato Debnath">

	<!-- Favicon icon -->
	<link rel="shortcut icon" href="${pageContext.request.contextPath}/assets/images/favicon.png" type="image/x-icon">
	<link rel="icon" href="${pageContext.request.contextPath}/assets/images/favicon.ico" type="image/x-icon">

	<!-- Google font-->
   <link href="https://fonts.googleapis.com/css?family=Ubuntu:400,500,700" rel="stylesheet">

	<!-- Font Awesome -->
	<link href="${pageContext.request.contextPath}/assets/css/font-awesome.min.css" rel="stylesheet" type="text/css">

	<!--ico Fonts-->
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/icon/icofont/css/icofont.css">

    <!-- Required Fremwork -->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/plugins/bootstrap/css/bootstrap.min.css">

	<!-- waves css -->
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/plugins/Waves/waves.min.css">

	<!-- Style.css -->
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/main.css">

	<!-- Responsive.css-->
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/responsive.css">

	<!--color css-->
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/color/color-1.min.css" id="color"/>

</head>
<body>
<section class="login p-fixed d-flex text-center bg-primary login-img-bg">
	<!-- Container-fluid starts -->
	<div class="container-fluid">
		<div class="row">

			<div class="col-sm-12">
				<div class="login-card card-block">
					<form class="md-float-material" method="post" action="/login">
						<div class="text-center">
							<a href="/">
								<img class="full-logo-lg" src="${pageContext.request.contextPath}/assets/images/logo-black.png" alt="logo">
							</a>
						</div>
						<h3 class="text-center txt-primary">
							Sign In to your account
						</h3>
						
						
						<%
						LoginRequest login = (LoginRequest) request.getAttribute("loginInfo");
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
							<div class="col-md-12">
								<div class="md-input-wrapper">
									<input type="text" class="md-form-control" name="username" value="<%= login != null ? login.getUsername() : ""%>">
									<label>Phone or email</label>
								</div>
							</div>
							<div class="col-md-12">
								<div class="md-input-wrapper">
									<input type="password" class="md-form-control" name="password"/>
									<label>Password</label>
								</div>
							</div>
							<div class="col-sm-6 col-xs-12">
							<div class="rkmd-checkbox checkbox-rotate checkbox-ripple m-b-25">
								<label class="input-checkbox checkbox-primary">
									<input type="checkbox" id="checkbox">
									<span class="checkbox"></span>
								</label>
								<div class="captions">Remember Me</div>

							</div>
								</div>
							<div class="col-sm-6 col-xs-12 forgot-phone text-right">
								<a href="forgot-password.html" class="text-right f-w-600"> Forget Password?</a>
								</div>
						</div>
						<div class="row">
							<div class="col-xs-10 offset-xs-1">
								<button type="submit" class="btn btn-primary btn-md btn-block waves-effect text-center m-b-20">LOGIN</button>
							</div>
						</div>
						<!-- <div class="card-footer"> -->
						<div class="col-sm-12 col-xs-12 text-center">
							<span class="text-muted">Don't have an account?</span>
							<a href="register2.html" class="f-w-600 p-l-5">Sign up Now</a>
						</div>

						<!-- </div> -->
					</form>
					<!-- end of form -->
				</div>
				<!-- end of login-card -->
			</div>
			<!-- end of col-sm-12 -->
		</div>
		<!-- end of row -->
	</div>
	<!-- end of container-fluid -->
</section>

<!-- Required Jqurey -->
<script src="${pageContext.request.contextPath}/assets/plugins/jquery/dist/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/plugins/jquery-ui/jquery-ui.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/plugins/tether/dist/js/tether.min.js"></script>

<!-- Required Fremwork -->
<script src="${pageContext.request.contextPath}/assets/plugins/bootstrap/js/bootstrap.min.js"></script>

<!-- waves effects.js -->
<script src="${pageContext.request.contextPath}/assets/plugins/Waves/waves.min.js"></script>
<!-- Custom js -->
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/pages/elements.js"></script>


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
