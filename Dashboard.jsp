<%@ page language="java" contentType="text/html; charset=US-ASCII"
	pageEncoding="US-ASCII"%>

<%@ page import="java.util.*"%>
<%@ page import="riag.kalpah.client.dao.*"%>
<%@ page import="riag.kalpah.client.*"%>
<!DOCTYPE html>
<html class="no-js" lang="en">
<head>
<meta charset="utf-8" />


<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<title>Dashboard - BOSCH</title>
<link href='http://fonts.googleapis.com/css?family=Open+Sans'
	rel='stylesheet' type='text/css'>
<link href="css/foundation.css" rel="stylesheet">
<link href="css/foundation.mvc.css" rel="stylesheet" />
<link href="css/normalize.css" rel="stylesheet" />
<link href="css/responsive-tables.css" rel="stylesheet" />


<script src="js/Chart.min.js" type="text/javascript"></script>
<script src="js/modernizr-2.8.3.js" type="text/javascript"></script>
<script src="js/jquery-2.1.4.min.js" type="text/javascript"></script>
<script src="js/_references.js" type="text/javascript"></script>
<script src="js/foundation.js" type="text/javascript"></script>
<script src="js/jquery-2.1.4.js" type="text/javascript"></script>
<script src="js/jquery-2.1.4.min.map" type="text/javascript"></script>
<script src="js/jquery.validate.js" type="text/javascript"></script>
<script src="js/jquery.validate.min.js" type="text/javascript"></script>
<script src="js/jquery.validate.unobtrusive.js" type="text/javascript"></script>
<script src="js/jquery.validate.unobtrusive.min.js"
	type="text/javascript"></script>
<script src="js/foundation/fastclick.js" type="text/javascript"></script>
<script src="js/foundation/foundation.abide.js" type="text/javascript"></script>
<script src="js/foundation/foundation.accordion.js"
	type="text/javascript"></script>
<script src="js/foundation/foundation.alert.js" type="text/javascript"></script>
<script src="js/foundation/foundation.clearing.js"
	type="text/javascript"></script>
<script src="js/foundation/foundation.clearing.js"
	type="text/javascript"></script>
<script src="js/foundation/foundation.js" type="text/javascript"></script>
<script src="js/foundation/foundation.dropdown.js"
	type="text/javascript"></script>
<script src="js/foundation/foundation.interchange.js"
	type="text/javascript"></script>
<script src="js/foundation/foundation.joyride.js" type="text/javascript"></script>
<script src="js/foundation/jquery.cookie.js" type="text/javascript"></script>
<script src="js/foundation/foundation.topbar.js" type="text/javascript"></script>
<script src="js/foundation/foundation.tooltip.js" type="text/javascript"></script>
<script src="js/foundation/foundation.tab.js" type="text/javascript"></script>
<script src="js/foundation/foundation.slider.js" type="text/javascript"></script>
<script src="js/foundation/foundation.reveal.js" type="text/javascript"></script>
<script src="js/foundation/foundation.responsive-tables.js"
	type="text/javascript"></script>
<script src="js/foundation/foundation.orbit.js" type="text/javascript"></script>
<script src="js/foundation/foundation.offcanvas.js"
	type="text/javascript"></script>
<script src="js/foundation/foundation.magellan.js"
	type="text/javascript"></script>
<script src="js/foundation" type="text/javascript"></script>
<script src="js/foundation" type="text/javascript"></script>


<script
	src="/bundles/modernizr?v=inCVuEFe6J4Q07A0AcRsbJic_UE5MwpRMNGcOtk94TE1"></script>

<script language="JavaScript">
	function point_it(event) {
		pos_x = event.offsetX ? (event.offsetX) : event.pageX
				- document.getElementById("pointer_div").offsetLeft;
		pos_y = event.offsetY ? (event.offsetY) : event.pageY
				- document.getElementById("pointer_div").offsetTop;
		document.getElementById("cross").style.left = (pos_x - 1);
		document.getElementById("cross").style.top = (pos_y - 15);
		document.getElementById("cross").style.visibility = "visible";
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
						<h1>
							<a href="Dashboard.jsp"> <img style="width: 230px; height: 70px;"
								src="Content/Images/Bosch_logo.png" /></a>
						</h1>
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



	<div class="row fullWidth">
		<div class="large-12 columns">
			<div class="panel">
				&nbsp;
				<h2>Dashboard</h2>
			</div>
		</div>
	</div>
	<div class="row fullWidth">
		<div class="large-12 columns">
			<div class="panel">
				<span> <a class="button">Reports</a> <a
					class="button success" style="float: right" href="Create.jsp">Generate
						New Report</a>
				</span>
				<ul class="tabs" data-tab>
					<li class="tab-title active"><a href="#InProgressPanel">In
							Progress</a></li>
					<li class="tab-title"><a href="#AvailablePanel">Available</a></li>
					<li class="tab-title"><a href="#PendingPanel">Pending</a></li>
					<li class="tab-title"><a href="#DeletedPanel">Deleted</a></li>
				</ul>

				<div class="tabs-content">
					<%
						List<PatientRequest> inProgressList;
						inProgressList = PatientRequestDAO.getInprogressRequests(user);
					%>
					<div class="content active" id="InProgressPanel">
						<div class="row">
							<div class="large-12 columns">
								<div>
									<div class="row">
										<div class="large-12 columns">
											<div class="panel">
												<table class="responsive">
													<tbody>
														<tr>
															<th><label>Patient Name</label></th>
															<th><label>PatID</label></th>
<!-- 															<th><label>Generated ID</label></th> -->
<!-- 															<th><label>Generated ?</label></th> -->
<!-- 															<th><label>Deleted ?</label></th> -->
															<th><label>Created On</label></th>
															
															<th><label>Request By</label></th>
															<th></th>
														</tr>
														<%
															for (PatientRequest preq : inProgressList) {
														%>
														<tr>
															<td><%=preq.getPatientName()%></td>
															<td><%=preq.getPatientRef()%></td>
<%-- 															<td><%=preq.getGenereteID()%></td> --%>
<!-- 															<td><select class="tri-state list-box" -->
<!-- 																disabled="disabled"> -->
<!-- 																	<option value="">Not Set</option> -->
<!-- 																	<option selected="selected" value="true">True</option> -->
<!-- 																	<option value="false">False</option> -->
<!-- 															</select></td> -->
<!-- 															<td><select class="tri-state list-box" -->
<!-- 																disabled="disabled"> -->
<!-- 																	<option selected="selected" value="">Not Set</option> -->
<!-- 																	<option value="true">True</option> -->
<!-- 																	<option value="false">False</option> -->
<!-- 															</select></td> -->
															<td><%=preq.getCreatedOn()%></td>
															
															<td><%=preq.getRequestBy()%></td>
															<td><form action="ProcessPatientRequestServlet"
																	method="post">
																	<input type="hidden" name="generateid"
																		value="<%=preq.getGenereteID()%>"> <input
																		type="hidden" name="patientname"
																		value="<%=preq.getPatientName()%>"> <input
																		type="hidden" name="patientref"
																		value="<%=preq.getPatientRef()%>"> <input
																		class="button success tiny" type="submit"
																		name="uploadimages" value="Upload Images" /> 
																	<input class="button alert tiny" type="submit"
																		name="deleterequest" value="Delete" />
																</form></td>
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
						</div>
					</div>
					<%
						List<PatientRequest> availableList;
						availableList = PatientRequestDAO.getAvailableRequests(user);
					%>
					<div class="content" id="AvailablePanel">
						<div class="row">
							<div class="large-12 columns">
								<div>
									<div class="row">
										<div class="large-12 columns">
											<div class="panel">
												<table class="responsive">
													<tbody>
														<tr>
															<th><label>Patient Name</label></th>
															<th><label>PRef.</label></th>
<!-- 															<th><label>Generated ID</label></th> -->
<!-- 															<th><label>Generated ?</label></th> -->
<!-- 															<th><label>Deleted ?</label></th> -->
															<th><label>Created On</label></th>
															
															<th><label>Request By</label></th>
															<th></th>
														</tr>
														<%
															for (PatientRequest preq : availableList) {
														%>
														<tr>
															<td><%=preq.getPatientName()%></td>
															<td><%=preq.getPatientRef()%></td>
<%-- 															<td><%=preq.getGenereteID()%></td> --%>
<!-- 															<td><select class="tri-state list-box" -->
<!-- 																disabled="disabled"> -->
<!-- 																	<option value="">Not Set</option> -->
<!-- 																	<option selected="selected" value="true">True</option> -->
<!-- 																	<option value="false">False</option> -->
<!-- 															</select></td> -->
<!-- 															<td><select class="tri-state list-box" -->
<!-- 																disabled="disabled"> -->
<!-- 																	<option selected="selected" value="">Not Set</option> -->
<!-- 																	<option value="true">True</option> -->
<!-- 																	<option value="false">False</option> -->
<!-- 															</select></td> -->
															<td><%=preq.getCreatedOn()%></td>
															
															<td><%=preq.getRequestBy()%></td>
															<td><form action="ProcessPatientRequestServlet"
																	method="post">
																	<input type="hidden" name="generateid"
																		value="<%=preq.getGenereteID()%>"> <input
																		type="hidden" name="patientname"
																		value="<%=preq.getPatientName()%>"> <input
																		type="hidden" name="patientref"
																		value="<%=preq.getPatientRef()%>"> 
																	<input class="button info tiny" type="submit"
																		name="viewreportrequest" value="View Report" /> 
																	<input class="button alert tiny" type="submit"
																		name="deleterequest" value="Delete" />
																</form></td>
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
						</div>
					</div>
					<%
						List<PatientRequest> pendingList;
						pendingList = PatientRequestDAO.getPendingRequests(user);
					%>

					<div class="content" id="PendingPanel">
						<div class="row">
							<div class="large-12 columns">
								<div>
									<div class="row">
										<div class="large-12 columns">
											<div class="panel">
												<table class="responsive">
													<tbody>
														<tr>
															<th><label>Patient Name</label></th>
															<th><label>PRef.</label></th>
<!-- 															<th><label>Generated ID</label></th> -->
<!-- 															<th><label>Generated ?</label></th> -->
<!-- 															<th><label>Deleted ?</label></th> -->
															<th><label>Created On</label></th>
															
															<th><label>Request By</label></th>
															<th></th>
														</tr>
														<%
															System.out.println("Pending List size : "+pendingList.size());
															for (PatientRequest preq : pendingList) {
														%>
														<tr>
															<td><%=preq.getPatientName()%></td>
															<td><%=preq.getPatientRef()%></td>

															<td><%=preq.getCreatedOn()%></td>
															
															<td><%=preq.getRequestBy()%></td>
															<td><form action="ProcessPatientRequestServlet"
																	method="post">
																	<input type="hidden" name="user"
																		value="<%=preq.getRequestBy()%>">
																	<input type="hidden" name="generateid"
																		value="<%=preq.getGenereteID()%>"> <input
																		type="hidden" name="patientname"
																		value="<%=preq.getPatientName()%>"> <input
																		type="hidden" name="patientref"
																		value="<%=preq.getPatientRef()%>"> <input
																		class="button info tiny" type="submit"
																		name="reuploadimages" value="Generate Report" /> <input
																		class="button alert tiny" type="submit"
																		name="deleterequest" value="Delete" />
																</form></td>
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
						</div>
					</div>

					<%
						List<PatientRequest> deletedList;
						deletedList = PatientRequestDAO.getDeletedRequests(user);
					%>
					<div class="content" id="DeletedPanel">
						<div class="row">
							<div class="large-12 columns">
								<div>
									<div class="row">
										<div class="large-12 columns">
											<div class="panel">
												<table class="responsive">
													<tbody>
														<tr>
															<th><label>Patient Name</label></th>
															<th><label>PRef.</label></th>
<!-- 															<th><label>Generated ID</label></th> -->
<!-- 															<th><label>Generated ?</label></th> -->
<!-- 															<th><label>Deleted ?</label></th> -->
															<th><label>Created On</label></th>
															
															<th><label>Request By</label></th>
														</tr>
														<%
															for (PatientRequest preq : deletedList) {
														%>
														<tr>
															<td><%=preq.getPatientName()%></td>
															<td><%=preq.getPatientRef()%></td>
<%-- 															<td><%=preq.getGenereteID()%></td> --%>
<!-- 															<td><select class="tri-state list-box" -->
<!-- 																disabled="disabled"> -->
<!-- 																	<option value="">Not Set</option> -->
<!-- 																	<option selected="selected" value="true">True</option> -->
<!-- 																	<option value="false">False</option> -->
<!-- 															</select></td> -->
<!-- 															<td><select class="tri-state list-box" -->
<!-- 																disabled="disabled"> -->
<!-- 																	<option selected="selected" value="">Not Set</option> -->
<!-- 																	<option value="true">True</option> -->
<!-- 																	<option value="false">False</option> -->
<!-- 															</select></td> -->
															<td><%=preq.getCreatedOn()%></td>
															
															<td><%=preq.getRequestBy() %></td>
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
						</div>
					</div>
				</div>
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


</body>
</html>