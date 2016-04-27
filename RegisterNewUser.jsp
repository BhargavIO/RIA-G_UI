<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html class="no-js" lang="en">
<head>
<meta charset="utf-8" />


<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<title>Register - BOSCH</title>
<link href='http://fonts.googleapis.com/css?family=Open+Sans'
	rel='stylesheet' type='text/css'>
<link href="css/foundation.mvc.css" rel="stylesheet" />
<link href="css/normalize.css" rel="stylesheet" />
<link href="css/responsive-tables.css" rel="stylesheet" />
<link href="css/foundation.css" rel="stylesheet" />
<link href="css/foundation_icons.css" rel="stylesheet" />
<link href="css/Site.css" rel="stylesheet" />


<script src="js/Chart.min.js" type="text/javascript">
    </script>

<script src="js/modernizr-2.8.3.js" type="text/javascript"></script>

<script language="JavaScript">
function point_it(event){
	pos_x = event.offsetX?(event.offsetX):event.pageX-document.getElementById("pointer_div").offsetLeft;
	pos_y = event.offsetY?(event.offsetY):event.pageY-document.getElementById("pointer_div").offsetTop;
	document.getElementById("cross").style.left = (pos_x-1) ;
	document.getElementById("cross").style.top = (pos_y-15) ;
	document.getElementById("cross").style.visibility = "visible" ;
	document.pointform.form_x.value = pos_x;
	document.pointform.form_y.value = pos_y;
	document.pointform.scale_x.value = document.getElementById("cross").clientWidth;
	document.pointform.scale_y.value = document.getElementById("cross").clientHeight;
}
    </script>
<style type="text/css">
.fullWidth {
	width: 100%;
	margin-left: auto;
	margin-right: auto;
	max-width: initial;
}

.chart-legend li span {
	display: inline-block;
	width: 12px;
	height: 12px;
	margin-right: 5px;
}

.pie-legend {
	list-style: none;
}

.file-upload {
	position: relative;
	overflow: hidden;
	margin: 10px;
}

.file-upload input.file-input {
	position: absolute;
	top: 0;
	right: 0;
	margin: 0;
	padding: 0;
	font-size: 20px;
	cursor: pointer;
	opacity: 0;
	filter: alpha(opacity = 0);
}
</style>
</head>
<body>


	<div class="row fullWidth">
		<div class="large-12 columns">
			<nav id="topMenu-1" class="top-bar" data-topbar role="navigation">
				<ul class="title-area">
					<li class="name">
						<h1>
							 <img style="width: 230px; height: 70px;"
								src="Content/Images/Bosch_logo.png" />
						</h1>
					</li>
					<!-- Remove the class "menu-icon" to get rid of menu icon. Take out "Menu" to just have icon alone -->
					<li class="<!--toggle-topbar --> menu-icon hide"><a href="#"><span>Menu</span></a></li>
				</ul>

				<section class="top-bar-section">
					<!-- Right Nav Section -->
					<ul class="right">
						<li><a href="Register.html" id="registerLink">Create
								Account</a></li>
						<li><a href="Login.html" id="loginLink">Log in</a></li>
					</ul>


					<!-- Left Nav Section -->
					<ul class="left">

					</ul>
				</section>
			</nav>
			<nav id="topMenu-2" class="top-bar five-up hide" data-topbar
				role="navigation" style="min-height: 100px">
				<ul class="title-area">
					<!-- Remove the class "menu-icon" to get rid of menu icon. Take out "Menu" to just have icon alone -->
					<li class="toggle-topbar menu-icon"><a href="#"><span>Menu</span></a></li>
				</ul>

				<section class="top-bar-section">
					<!-- Left Nav Section -->

					<ul class="right hide">
						<li class="has-form">
							<div class="row collapse">

								<div class="large-8 small-8 medium-8 columns">
									<input type="text" placeholder="search" name="search"
										id="search">
								</div>
								<div class="large-4 small-4 medium-4 columns">
									<input type="button" value="Search" class="alert button expand" />
								</div>

							</div>
						</li>
					</ul>
				</section>
			</nav>
			<style>
#topMenu-2, #topMenu-1, .top-bar-section ul li>a {
	background: #fff !important;
	color: #000 !important;
}

#topMenu-1 {
	height: 100px;
}
</style>
		</div>
	</div>


	<div class="row">
		<div class="large-8 columns">
			<div class="panel">
				<form action="CreateNewUserServlet" class="form-horizontal"
					method="post" role="form">
					<input name="__RequestVerificationToken" type="hidden" value="" />
					<h4>Create a new account.</h4>
					<hr />
					<div class="validation-summary-valid text-danger"
						data-valmsg-summary="true">
						<ul>
							<li style="display: none"></li>
						</ul>
					</div>
					<div class="form-group">
						<label class="col-md-2 control-label" for="FirstName">First
							Name</label>
						<div class="col-md-10">
							<input class="form-control" data-val="true"
								data-val-length="The First Name must be at least 6 characters long."
								data-val-length-max="100" data-val-length-min="6"
								data-val-required="The First Name field is required."
								id="FirstName" name="FirstName" type="text" value="" />
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-2 control-label" for="LastName">Last
							Name</label>
						<div class="col-md-10">
							<input class="form-control" data-val="true"
								data-val-length="The Last Name must be at least 6 characters long."
								data-val-length-max="100" data-val-length-min="6"
								data-val-required="The Last Name field is required."
								id="LastName" name="LastName" type="text" value="" />
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-2 control-label" for="Email">Email</label>
						<div class="col-md-10">
							<input class="form-control" data-val="true"
								data-val-email="The Email field is not a valid e-mail address."
								data-val-required="The Email field is required." id="Email"
								name="Email" type="text" value="" />
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-2 control-label" for="Password">Password</label>
						<div class="col-md-10">
							<input class="form-control" data-val="true"
								data-val-length="The Password must be at least 6 characters long."
								data-val-length-max="100" data-val-length-min="6"
								data-val-required="The Password field is required."
								id="Password" name="Password" type="password" />
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-2 control-label" for="ConfirmPassword">Confirm
							password</label>
						<div class="col-md-10">
							<input class="form-control" data-val="true"
								data-val-equalto="The password and confirmation password do not match."
								data-val-equalto-other="*.Password" id="ConfirmPassword"
								name="ConfirmPassword" type="password" />
						</div>
					</div>
					<div class="form-group">
						<div class="col-md-offset-2 col-md-10">
							<input type="submit" class="button" value="Register" />
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>

	<script
		src="/bundles/jquery?v=gkWyJthHPtwkFjvHuNinBjchIfwLwc_KbE-H26J2kAI1"></script>

	<script
		src="/bundles/foundation?v=KOjn9Kbhp56QPUoVqb7GrHaoNItfHXJZkZRfUS31Hr01"></script>

	<script>
        $(document).foundation();
    </script>


	<script
		src="/bundles/jqueryval?v=liFQDLl2DYXeEfda_Lo9HxMCJUnZ2Adg-vEhq6ZMqpo1"></script>


</body>
</html>