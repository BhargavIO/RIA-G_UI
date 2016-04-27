<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html class="no-js" lang="en">
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>- BOSCH</title>
<link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css'>
<link href="css/foundation.css" rel="stylesheet">
<link href="css/foundation.mvc.css" rel="stylesheet" />
<link href="css/normalize.css" rel="stylesheet" />
<link href="css/responsive-tables.css" rel="stylesheet" />
<script src="js/jquery-2.1.4.min.js" type="text/javascript"></script>
<script src="js/Chart.min.js" type="text/javascript"></script>
<script>
	var selectedfile;
	var flag=0;
	var pos_x=0;
	var pos_y=0;
    $(function () {      
    	$(":file").change(function (e) {
        	if (this.files && this.files[0]) {
	            var reader = new FileReader();            
	            document.getElementById("left_form_x").value = 0;
				document.getElementById("left_form_y").value = 0;
	            reader.onload = imageIsLoaded;
	            reader.readAsDataURL(this.files[0]);      
        	}
		});
	}); 
 	var y;
	var x;
	function imageIsLoaded(e) {
    	$(".left").attr('src',e.target.result);
    	x=0;
    	y=0;
		flag=1;
		y = document.getElementById("left").height;
		x = document.getElementById("left").width;
		x*=0.6;
		y*=0.6;
	};
	function point_it(event){	
    	if(flag==1){
			document.getElementById("left").style.height = y ;	
			pos_x = event.offsetX?(event.offsetX):event.pageX-document.getElementById("left").offsetLeft;
			pos_y = event.offsetY?(event.offsetY):event.pageY-document.getElementById("left").offsetTop;
			document.getElementById("left").style.left = (pos_x-1) ;
			document.getElementById("left").style.top = (pos_y-15) ;	
			document.getElementById("left_form_x").value = pos_x;
			document.getElementById("left_form_y").value = pos_y;
			document.getElementById("left_scale_x").value = document.getElementById("cross").clientWidth;
			document.getElementById("left_scale_y").value = document.getElementById("cross").clientHeight;
	    }    
	}

	function toggleOverlay(){
		var overlay = document.getElementById('overlay');
		var specialBox = document.getElementById('specialBox');
		overlay.style.opacity = .4;
		if(overlay.style.display == "block"){
			overlay.style.display = "none";
			specialBox.style.display = "none";
		} else {
			overlay.style.display = "block";
			specialBox.style.display = "block";
			$("#cross").attr("width",x);
			$("#cross").attr("height",y);
		}
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
	margin-left: 50px;
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

div#overlay {
	display: none;
	z-index: 2;
	background: #000;
	position: fixed;
	width: 100%;
	height: 100%;
	top: 0px;
	left: 0px;
	text-align: center;
}

div#specialBox {
	display: none;
	position: absolute;
	z-index: 100000;
	margin: 0px 0px 0px 300px;
	top: 20;
	background: #FFF;
	color: #000;
	background-color: #333232;
}

div#specialBox1 {
	display: none;
	position: absolute;
	z-index: 100000;
	margin: 0px 0px 0px 300px;
	top: 20;
	background: #FFF;
	color: #000;
	background-color: #333232;
}

input[type=text] {
	width: 80px;
	float: left;
}

#scale_y::before {
	content: "Y";
}

input[type=file] {
	width: 250px;
	height: 80px"
}
</style>
</head>
<body>
<%
		//allow access only if session exists
		String user = null;
		if (session.getAttribute("user") == null) {
			response.sendRedirect("index.jsp");
		} else
		user = (String) session.getAttribute("user");
		String userName = null;
		String sessionID = null;
		Cookie[] cookies = request.getCookies();
		if (cookies != null) {
			for (Cookie cookie : cookies) {
				if (cookie.getName().equals("user"))
					userName = cookie.getValue();
				if (cookie.getName().equals("JSESSIONID"))
					sessionID = cookie.getValue();
			}
		}
	%>
	<div class="row fullWidth">
		<div class="large-12 columns">
			<nav id="topMenu-1" class="top-bar" data-topbar role="navigation">
				<ul class="title-area">
					<li class="name">
						<h1> <a href="Dashboard.jsp"><img style="width: 230px; height: 70px;" src="Content/Images/Bosch_logo.png" /></a></h1>
					</li>
					<!-- Remove the class "menu-icon" to get rid of menu icon. Take out "Menu" to just have icon alone -->
					<li class="<!--toggle-topbar --> menu-icon hide"><a href="#"><span>Menu</span></a></li>
				</ul>
				<section class="top-bar-section">
					<!-- Right Nav Section -->
					<form action="<%=response.encodeURL("LogoutServlet") %>" class="navbar-right" id="logoutForm"
						method="post">
						<input name="__RequestVerificationToken" type="hidden" value="" />
						<input type="hidden" name="Email" value="<%=user %>" />
						<ul class="right">
								
<!-- 							<li><a href="RolesAdmin.html">Roles</a></li> -->
<!-- 							<li><a href="UsersAdmin.html">Users</a></li> -->
							<li><a href="Dashboard.jsp" title="Manage">Hello <%=user %></a></li>
							<li style="background:rgba(0,0,0,0)"><input type="submit" value="Logout" style="background:rgba(0,0,0,0); border:0px;"></li>
						</ul>
					</form>
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
									<input type="text" placeholder="search" name="search" id="search">
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

	<div class="row fullWidth">
		<div class="large-12 columns">
			<div class="panel">
				<form action="ImageUploadServlet" enctype="multipart/form-data" method="post">
					<input type="hidden" name="generateid" value="<%=request.getAttribute("generateid") %>" />
					<input type="hidden" name="single_scale_x" value="922" />
					<input type="hidden" name="single_scale_y" value="692" />
					<input name="__RequestVerificationToken" type="hidden" value="" />
					<div class="row">
						<div class="large-12 columns">

							<input data-val="true"
								data-val-number="The field PId must be a number."
								data-val-required="The PId field is required." id="PId"
								name="PId" type="hidden" value="10045" /> <input
								data-val="true"
								data-val-length="The PatientName must be at least 3 characters long."
								data-val-length-max="100" data-val-length-min="3"
								data-val-required="The PatientName field is required."
								id="PatientName" name="PatientName" type="hidden" value="abc" />
						</div>
					</div>
					<div class="row">


						<div class="row" style="width: 100%; margin: 0 auto;">
							<div id="points">
								<!--points-->

							</div>
							<img src="" class="left" id="left" width="922px" height="692px"
								style="margin: 0 0px 50px 50px;" onclick="point_it(event)">
							<table style="margin-top: 0px;">
								<thead>
									<th>PatientName:</th>
									<td style="font-weight: 20"><%= request.getAttribute("patientname") %></td>
								</thead>
								<thead>
									<th>Reference:</th>
									<td><%=request.getAttribute("patientref") %></td>
								</thead>
								<tr>
									<th colspan="2">Selected Point</th>
								</tr>
								<tr>
									<td><input type="text" name="single_form_x" id="left_form_x"
										size="4" readonly="readonly" /></td>
								</tr>
								<tr>
									<td><input type="text" name="single_form_y" id="left_form_y"
										size="4" readonly="readonly" /></td>
								</tr>
								<tr>
									<td>
										<button class="file-upload success">
											<input type="file" class="file-input file-upload success"
												name="lefteyefile" id="singleeyefile" onclick="" required
												style="padding: 20px;">Choose Eye Image(.jpg) File
										</button>
									</td>
								</tr>
								<tr>
									<td><input type="submit" value="Upload"
										class="button success" /></td>
								</tr>
								<tr>
									<td><a class="button" href="/" style="width: 100px">Back</a></td>
								</tr>
							</table>
						</div>
						<div class="row" style="width: 50%; margin: 0 auto;"></div>
						<div class="row">&nbsp;</div>
						<div class="row">&nbsp;</div>
						<div class="row">&nbsp;</div>
				</form>
				<div id="overlay"></div>
</body>
</html>