<%@ page language="java" contentType="text/html; charset=US-ASCII"
	pageEncoding="US-ASCII"%>

<!DOCTYPE html>
<html class="no-js" lang="en">
<head>
    <meta charset="utf-8" />

    
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <title>Create - BOSCH</title>
      <link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css'>
    <link href="css/foundation.css" rel="stylesheet">
    <link href="css/foundation.mvc.css" rel="stylesheet"/>
    <link href="css/normalize.css" rel="stylesheet"/>
    <link href="css/responsive-tables.css" rel="stylesheet"/>
	

    <script src="js/Chart.min.js" type="text/javascript">  <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/1.0.2/Chart.min.js" type="text/javascript">
    </script>
    
    <script src="/bundles/modernizr?v=inCVuEFe6J4Q07A0AcRsbJic_UE5MwpRMNGcOtk94TE1"></script>

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
        .chart-legend li span{
    display: inline-block;
    width: 12px;
    height: 12px;
    margin-right: 5px;
}
        .pie-legend 
        {
            list-style:none;
        }

        .file-upload {
  position: relative;
  overflow: hidden;
  margin: 10px; }

.file-upload input.file-input {
  position: absolute;
  top: 0;
  right: 0;
  margin: 0;
  padding: 0;
  font-size: 20px;
  cursor: pointer;
  opacity: 0;
  filter: alpha(opacity=0); }
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
                    <h1><a href="Dashboard.jsp"> <img style="width:230px; height:70px;"src="Content/Images/Bosch_logo.png"/></a></h1>
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
        <nav id="topMenu-2" class="top-bar five-up hide" data-topbar role="navigation" style="min-height:100px">
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
            #topMenu-2,#topMenu-1,.top-bar-section ul li > a{
                background: #fff !important;
                color: #000 !important;
            }
            #topMenu-1{
                height: 100px;
            }
        </style>
</div>
</div>

<div class="row">
    <div class="large-12 columns">
        <div class="panel">
            &nbsp;
	<form action="CreateNewRequestServlet" method="post">
	<input type="hidden" name="Email" value="<%=user %>" />
	<input name="__RequestVerificationToken" type="hidden" value="" />                
	<div class="form-horizontal">
                    <h4>Generate Report Request Form</h4>
                    <hr />
                    
                    <div class="form-group">
                        <label>Patient Name</label>
                        <div class="col-md-10">
                            <input class="form-control text-box single-line" data-val="true" data-val-length="The PatientName must be at least 3 characters long." data-val-length-max="100" data-val-length-min="3" data-val-required="The PatientName field is required." id="PatientName" name="PatientName" type="text" value="" />
                            <span class="field-validation-valid text-danger" data-valmsg-for="PatientName" data-valmsg-replace="true"></span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label>Patient Reference Id</label>
                        <div class="col-md-10">
                            <input class="form-control text-box single-line" id="PatientRef" name="PatientRef" type="text" value="" />
                            <span class="field-validation-valid text-danger" data-valmsg-for="PatientRef" data-valmsg-replace="true"></span>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="col-md-6">
                            <input type="submit" value="Create" class="button success" style="font-size:inherit" />                         
                        </div>
                    </div>
                </div>
</form>            <a class="button" href="/">Back</a>
        </div>
    </div>
</div>

    <script src="/bundles/jquery?v=gkWyJthHPtwkFjvHuNinBjchIfwLwc_KbE-H26J2kAI1"></script>

    <script src="/bundles/foundation?v=KOjn9Kbhp56QPUoVqb7GrHaoNItfHXJZkZRfUS31Hr01"></script>

    <script>
        $(document).foundation();
    </script>
    
    
    <script src="/bundles/jqueryval?v=liFQDLl2DYXeEfda_Lo9HxMCJUnZ2Adg-vEhq6ZMqpo1"></script>


</body>
</html>