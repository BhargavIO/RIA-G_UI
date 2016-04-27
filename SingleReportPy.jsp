<%@ page language="java" contentType="text/html; charset=US-ASCII"
pageEncoding="US-ASCII"%>
<%@ page import="riag.bootlogic.RIAGResult"%>
<%@ page import="riag.kalpah.client.PatientRequest"%>
<%@ page import="riag.kalpah.client.dao.RIAGResultDAO"%>
<%@ page import="riag.kalpah.client.dao.PatientRequestDAO"%>


<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="java.sql.Statement"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="org.apache.commons.io.FileUtils"%>
<!Doctype HTML>
<html lang="en">
<head>
	<title>Kalpah Eye Dashboard</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet"
	href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
	<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
	<script src="http://underscorejs.org/underscore-min.js"></script>
	<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/d3/3.5.5/d3.min.js"
	charset="utf-8"></script>
	<script src="http://d3js.org/d3.v3.min.js"></script>

	<style type="text/css">
		/* No style rules here yet */
		.path {
			stroke: #4DC65C;
			stroke-width: 1;
			fill: none;
		}
		@media print{@page {size: landscape}}
		.area {
			fill: #4DC65C;
			stroke-width: 0;
		}

		.areaOrange {
			fill: #D7D7D7;
			stroke-width: 0;
		}

		.axis path, .axis line {
			fill: none;
			stroke: black;
			stroke-width: 1;
			shape-rendering: crispEdges;
		}

		.scale {
			-ms-transform: scale(.8, .8); /* IE 9 */
			-webkit-transform: scale(.8, .8); /* Safari */
			transform: scale(.8, .8); /* Standard syntax */
		}
		div#overlay {

			display: none;
			z-index: 2;
			background: white;
			position: fixed;
			width: 100%;
			height: 100%;
			top: 0px;
			left: 0px;
			text-align: center;
		}


		div#popup {
			display: none;
			position: absolute;
			z-index: 1000;
			margin-left:25%;
			margin-top:10%;
			box-shadow: 0px 0px 30px 2px rgba(0,0,0,.5);
			width: 28%; 
			height: 200px;
			background: white;
			color: #000;
			background-color: white;
		}

		td {
			text-align: right;
		}
		#popup div{
			margin:50px;
			text-align:center;
		}

		.navbar {
			background-color: #000;
		}

		.navbar-brand {
			color: #fff !important;
		}

		.navbar-nav>li {
			background: #000;
		}

		.navbar-nav>li>a {
			color: #fff !important;
		}

		.navbar-nav>.active>a, .navbar-nav>.open>a {
			background: #fff !important;
			color: #000 !important;
		}

		.dropdown-menu>li>a:hover {
			background: #000 !important;
			color: #fff !important;
		}

		.spacer {
			margin-top: 75px;
		}

		#left-eye {
			position: relative;
			float: left;
		}

		#right-eye {
			position: relative;
			float: right;
		}

		#left-box {
			position: absolute;
			left: 250px;
			top: 100px;
			width: 150px;
			height: 150px;
		}

		#right-box {
			position: absolute;
			left: 250px;
			top: 100px;
			width: 150px;
			height: 150px;
		}

		.analysis th, .analysis td {
			text-align: center;
		}
	</style>
	<style type="text/css">
		/* No style rules here yet */
		.axis path, .axis line {
			fill: none;
			stroke: black;
			shape-rendering: crispEdges;
		}
		input[type="radio"] {
			display:none;

		}
		input[type="radio"] + label {
			color: #292321;
			font-family:Arial, sans-serif;
			font-size:14px;
			margin-left:30px;
		}
		input[type="radio"] + label span {
			display:inline-block;
			width:19px;
			height:19px;
			margin:-1px 4px 0 0;
			vertical-align:middle;
			cursor:pointer;
			-moz-border-radius:  50%;
			border-radius:  50%;
		}

		input[type="radio"] + label span {
			background-color:#292321;
		}

		input[type="radio"]:checked + label span{
			background-color:#CC3300;
			border:4px solid #292321;
		}

		input[type="radio"] + label span,
		input[type="radio"]:checked + label span {
			-webkit-transition:background-color 0.4s linear;
			-o-transition:background-color 0.4s linear;
			-moz-transition:background-color 0.4s linear;
			transition:background-color 0.4s linear;
		}
		a{
			text-decoration: none;
		}
		.success{
			background-color: #43AC6A;
			border-color: #368a55;
			color: #FFFFFF;
			padding:10px;

		}
		button{
			padding:3px 8px;
			border-radius:2px;

			background-color: #43AC6A;
			border:1px solid #368a55;
			color: #FFFFFF;}
		</style>
		<script>

			$(document).ready(function(){
	var element = $("#body"); // global variable
var getCanvas; // global variable

$("#save").on('click', function () {
	html2canvas(element, {
		onrendered: function (canvas) {
			$("#previewImage").append(canvas);
			getCanvas = canvas;
		}
	});
	toggleOverlay();
});
$("#download").on('click', function () {
	var imgageData = getCanvas.toDataURL("image/png");
    // Now browser starts downloading it instead of just showing it
    var newData = imgageData.replace(/^data:image\/png/, "data:application/octet-stream");
    $("#download").attr("download", "your_pic_name.png").attr("href", newData);
    document.getElementById('overlay').style.display = "none";;
    document.getElementById('popup').style.display = "none";;
});
function toggleOverlay(){
	var overlay = document.getElementById('overlay');
	var specialBox = document.getElementById('popup');
	overlay.style.opacity = .4;
	if(overlay.style.display == "block"){
		overlay.style.display = "none";
		specialBox.style.display = "none";
	} else {
		overlay.style.display = "block";
		specialBox.style.display = "block";

	}
}
});


</script>
</head>
<body style="width: 1200px; margin-left: auto; margin-right: auto;">
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

/* Dummy Data */
		//String user="Satya";
%>
<%
System.out.println("TEST1");
String gid = "";
		//gid="f78c8800-f7d8-11e5-b993-408d5c6348ff";
gid = request.getAttribute("generateid").toString();
System.out.println("Report for Gid:"+gid);
String patname = "dummy";
String patref = "dummy";
String patphno = "999999999";
String errorMsg = "Unknown Error";
double rimarea=0.0;
double discarea=0.0;
double avgcdratio=0.0;
double hcdr=0.0;
double vcdr=0.0;
double ddls_val=0.0;
double temporal = 0.0;
double superial = 0.0;
double nasal = 0.0;
double inferior = 0.0;
String outImage = "dummy";
String graphValuesStr[] = {};
List<String> items = null;
double[] scorevals = new double[360];

System.out.println("TEST2");
RIAGResult reportValues=new RIAGResult();
reportValues=RIAGResultDAO.getRIAGResult(user, gid);
PatientRequest pInfo=new PatientRequest();
pInfo=PatientRequestDAO.getPatientInfo(gid);

patname=pInfo.getPatientName();
patref=pInfo.getPatientRef();

System.out.println("TEST3");
try {
Map<String, String> values = new HashMap<String, String>();
try {
System.out.println("TEST4");
values = (Map<String, String>) request.getAttribute("outValues");
System.out.println("TEST5");

} catch (Exception ex) {
System.out.println("TypeCasting cannot done");
}
System.out.println("TEST6"+reportValues.getRim_Area_Global());
rimarea = reportValues.getRim_Area_Global();
System.out.println("TEST7");
discarea = reportValues.getDisc_Area_Global();
System.out.println("TEST8");
hcdr = reportValues.getHorizontal_CD_Ratio_Global();
System.out.println("TEST9");
vcdr = reportValues.getVertical_CD_Ratio_Global();
System.out.println("TEST10");
temporal = reportValues.getTemporal();
System.out.println("TEST11");
superial = reportValues.getSuperior();
System.out.println("TEST12");
nasal = reportValues.getNasal();
System.out.println("TEST13");
inferior = reportValues.getInferior();
System.out.println("TEST14");
avgcdratio = reportValues.getAvg_CD_Ratio_Global();
ddls_val = (int)reportValues.getDDLS_Global();
			//System.out.println("Graph Values are : ");
			System.out.println("TEST14a");
			System.out.println("Graph Vals: "+reportValues.getScores_Global());
			graphValuesStr = reportValues.getScores_Global().split(",");
			System.out.println("TEST14b");
			for (int i = 0; i < 35; i++) {
			System.out.println(graphValuesStr[i]);
		}
		System.out.println("TEST14c");
	} catch (Exception ex) {
	errorMsg = "Report cannot generated without proper inputs";
	request.setAttribute("errorMsg", errorMsg);
	request.getRequestDispatcher("ErrorServlet").forward(request, response);
}
%>
<div id="body">

	<div id="head"
	style="margin-top: 5px; height: 100px; border-bottom: 2px solid black;">
	<form action="<%=response.encodeURL("LogoutServlet")%>"
		class="navbar-right" id="logoutForm" method="post">
		<input name="__RequestVerificationToken" type="hidden" value="" />
		<input type="hidden" name="Email" value="<%=user%>" />
		<ul class="right">

			<!-- 							<li><a href="RolesAdmin.html">Roles</a></li> -->
			<!-- 							<li><a href="UsersAdmin.html">Users</a></li> -->
			<li><a href="Dashboard.jsp" title="Manage">Hello <%=user%></a></li>
			<li style="background: rgba(0, 0, 0, 0)"><input type="submit"
				value="Logout" style="background: rgba(0, 0, 0, 0); border: 0px;"></li>
			</ul>
		</form>
		<div class="details" style="float: left;">
			<span>Patient Name:</span><label><%=patname%></label><br> <span>Patient
			ID:</span><label><%=patref%></label><br> <span>Mobile Number:</span><label><%=patphno%></label>
		</div>
		<div style="float: right;">
			<img src="Content/Images/Bosch_logo.png" width="230px">
		</div>
		<div
		style="width: 1px; height: 100px; border: 1px solid black; margin-left: auto; margin-right: auto;"></div>
	</div>

	<%
	System.out.println("TEST15");
	%>

	<%
	String appDataPath = getServletContext().getInitParameter("APP_DATA_DIR");
	String outImgPath = appDataPath + File.separator + "outputDir" + File.separator + gid + ".jpg";
	System.out.println(appDataPath);
	FileUtils.copyFileToDirectory(new File(outImgPath),
		new File(getServletContext().getRealPath("/") + File.separator + "tempImgDir"));
		%>

		<div style='float: left; margin-left: 20px;'>
			<%-- 			<img src="/RIAGDemoApp/ImageDisplayServlet?gid=<%=gid%>" --%>
			<img
			src="${pageContext.request.contextPath}/tempImgDir/<%=gid %>.jpg"
			width="700px" style="margin-top: 30px" />
		</div>

		<table class="table table-condensed analysis"
		style="width: 33%; float: left; margin-left: 50px;">
		<thead>
			<tr>
				<th><font face="sans-serif">Feature Name</font></th>
				<th><font face="sans-serif">Left Eye</font></th>

			</tr>
		</thead>
		<tbody>
			<tr>
				<td style="background-color: #EEE; color: #000"><font
					face="sans-serif">Rim Area</font></td>
					<td style=""><font face="sans-serif"><%=rimarea%> </font></td>

				</tr>
				<tr>
					<td style="background-color: #EEE; color: #000;"><font
						face="sans-serif">Disc Area</font></td>
						<td style=""><font face="sans-serif"> <%=discarea%></font></td>


					</tr>
					<tr>
						<td style="background-color: #EEE; color: #000"><font
							face="sans-serif">Avg C/D ratio</font></td>

							<td style=""><font face="sans-serif"><%=avgcdratio%></font></td>

						</tr>
						<tr>
							<td style="background-color: #EEE; color: #000"><font
								face="sans-serif">Horizontal C/D ratio</font></td>

								<td style=""><font face="sans-serif"> <%=hcdr%></font></td>
							</tr>
							<tr>
								<td style="background-color: #EEE; color: #000"><font
									face="sans-serif">Vertical C/D ratio</font></td>

									<td style=""><font face="sans-serif"><%=vcdr%></font></td>
								</tr>
							</tbody>
						</table>
						<%
						System.out.println("TEST16");
						%>
						<div style="padding: 0 85px;">
							<a href="javascript:popup()" style="color: #ff3b30"> <font
								color="#ff3b30" style="" face="sans-serif" size="3"></font>
							</a>
						</div>
						<div style="padding: 0 10px;"></div>
						<svg xmlns="http://www.w3.org/2000/svg" width="120" height="160.0"
						style="margin-top: 5px; float: right; margin-right: 100px;">

						<g width="100.0000" height="100.0000" transform="translate(10, 28)">
							<g transform="rotate(-45 50 50)">
								<path
								d="M50.0000,50.0000 A0,0 0 0,0 50.0000,50.0000 L50.0000,10.0000 A40,40 0 0,1 90.0000,50.0000 z"
								stroke="#fff" stroke-width="2" fill="#4DC65C"></path>
								<path
								d="M50.0000,50.0000 A0,0 0 0,0 50.0000,50.0000 L10.0000,50.0000 A40,40 0 0,1 50.0000,10.0000 z"
								stroke="#fff" stroke-width="2" fill="#4DC65C"></path>
								<path
								d="M50.0000,50.0000 A0,0 0 0,0 50.0000,50.0000 L50.0000,90.0000 A40,40 0 0,1 10.0000,50.0000 z"
								stroke="#fff" stroke-width="2" fill="#D7D7D7" data-toggle="tooltip"
								title="ISNT Rule Violates Here!"></path>
								<path
								d="M50.0000,50.0000 A0,0 0 0,0 50.0000,50.0000 L90.0000,50.0000 A40,40 0 0,1 50.0000,90.0000 z"
								stroke="#fff" stroke-width="2" fill="#4DC65C"></path>
								<text x="45" y="30" font-family="sans-serif" font-weight="bold"
								transform="rotate(45.0 50 50)">S</text>
								<text x="30" y="50" font-family="sans-serif" font-weight="bold"
								text-anchor="middle" dominant-baseline="middle"
								transform="rotate(45.0 50 50)">N</text>
								<text x="48" y="75" font-family="sans-serif" font-weight="bold"
								transform="rotate(45.0 50 50)">I</text>
								<text x="70" y="50" font-family="sans-serif" font-weight="bold"
								text-anchor="middle" dominant-baseline="middle"
								transform="rotate(-315.0 50 50)">T</text>
							</g>
							<text x="45" y="105" font-family="sans-serif" font-weight="bold"><%=(int) inferior%></text>
							<text x="45" y="5" font-family="sans-serif" font-weight="bold"><%=(int) superial%> </text>
							<text x="-5" y="55" font-family="sans-serif" font-weight="bold"><%=(int) nasal%> </text>
							<text x="90" y="55" font-family="sans-serif" font-weight="bold">  <%=(int) temporal%> </text>
						</g>

						<text x="15" y="160" font-family="sans-serif" font-size="18"
						font-weight="bold">ISNT RULE</text>
					</svg>

					<svg width="200px" height="145px" viewBox="0 0 180 145" version="1.1"
					xmlns="http://www.w3.org/2000/svg"
					xmlns:xlink="http://www.w3.org/1999/xlink"
					xmlns:sketch="http://www.bohemiancoding.com/sketch/ns"
					style="float: right;">
					<!-- Generator: Sketch 3.3.2 (12043) - http://www.bohemiancoding.com/sketch -->
					<g transform="translate(0, 50)">
						<defs></defs>
						<g id="Page-1" stroke="none" stroke-width="1" fill="none"
						fill-rule="evenodd" sketch:type="MSPage">
						<g id="Delete-Button-Copy" sketch:type="MSLayerGroup"
						transform="translate(8.000000, 5.000000)">
						<rect rx="0" ry="0" id="Background" fill="#4DC65C"
						sketch:type="MSShapeGroup" x="0" y="0" width="61.5" height="56"></rect>
						<text id="Type-something" sketch:type="MSTextLayer"
						font-family="sans-serif" font-size="18" font-weight="bold"
						fill="#ffffff">
						<tspan x="8" y="35">DDLS</tspan>
					</text>
				</g>
				<g class="scale" transform="translate(-25.000000, -11.000000)">
					<g id="Activity-Icon-(Share-Sheet)-Copy"
					sketch:type="MSLayerGroup"
					transform="translate(110.000000, 14.000000)" stroke="green"
					fill="#FFFFFF">
					<path
					d="M20.9185,0 L39.0815,0 C45.105,0 48.116,0 51.3585,1.025 C54.8985,2.3135 57.6865,5.1015 58.975,8.6415 C60,11.8835 60,14.8955 60,20.9185 L60,39.0815 C60,45.105 60,48.116 58.975,51.3585 C57.6865,54.8985 54.8985,57.6865 51.3585,58.9745 C48.116,60 45.105,60 39.0815,60 L20.9185,60 C14.895,60 11.8835,60 8.6415,58.9745 C5.1015,57.6865 2.3135,54.8985 1.025,51.3585 C0,48.116 0,45.105 0,39.0815 L0,20.9185 C0,14.8955 0,11.8835 1.025,8.6415 C2.3135,5.1015 5.1015,2.3135 8.6415,1.025 C11.8835,0 14.895,0 20.9185,0 L20.9185,0"
					id="Icon-Shape" sketch:type="MSShapeGroup"></path>
				</g>


				<g id="Notification-Copy" sketch:type="MSLayerGroup"
				transform="translate(129.000000, 32.000000)">
				<circle id="Notification-Bubble" fill="#4DC65C"
				sketch:type="MSShapeGroup" cx="11" cy="11" r="20"></circle>
				<text id="Number" sketch:type="MSTextLayer"
				font-family="sans-serif" font-size="24" font-weight="bold"
				fill="white">
				<tspan x="5" y="18"><%=ddls_val %></tspan>
			</text>
			<%
			System.out.println("TEST17");
			%>
		</g>
		<text id="Number" sketch:type="MSTextLayer"
		font-family="sans-serif" font-size="16" font-weight="260"
		fill="black">
		<tspan x="135" y="49"></tspan>
	</text>
</g>
</g>
</g>
</svg>
<div style="margin: 10 0 0 20px; float: left;">
	<canvas id="graph" width="380" height="230" style=""></canvas>
	<%
	System.out.println("TEST18");
	%>
	<%
	for (int i = 0; i < 35; i++) {
	System.out.println();
	if (i == 0) {
	graphValuesStr[i] = graphValuesStr[i].substring(graphValuesStr[i].indexOf("[") + 1,
	graphValuesStr[i].length());
}
if (i == 35) {
graphValuesStr[i] = graphValuesStr[i].substring(0, graphValuesStr[i].indexOf("]") - 1);
}
scorevals[i] = Double.parseDouble(graphValuesStr[i]);
					//scorevals[i] = new Random().nextInt((160-1)+1)+1;
				}
				%>
				<%
				System.out.println("TEST19");
				%>
				<script>
					var jsArray = [];
					<%for (int i = 1; i < 35; i++) {%>
						jsArray.push("<%=scorevals[i]%>");
						<%}%>
						var c = document.getElementById("graph");
						var ctx = c.getContext("2d");
						var ctx1 = c.getContext("2d");
						var ctx2 = c.getContext("2d");
						ctx1.beginPath();
						ctx1.font = "10pt Open San";
						ctx1.moveTo(20, 200);
						ctx1.lineTo(20, 0);

						ctx1.moveTo(20, 160);
						ctx1.lineTo(15, 160);
						ctx1.fillText("20", 3, 160);

						ctx1.moveTo(20, 120);
						ctx1.lineTo(15, 120);
						ctx1.fillText("40", 3, 120);

						ctx1.moveTo(20, 80);
						ctx1.lineTo(15, 80);
						ctx1.fillText("60", 3, 80);

						ctx1.moveTo(20, 40);
						ctx1.lineTo(15, 40);
						ctx1.fillText("80", 3, 40);

						ctx1.moveTo(20, 200);
						ctx1.lineTo(20, 207);
						ctx1.fillText("0", 23, 212);
						ctx1.fillText("Temporal", 0, 224);
						ctx1.moveTo(110, 200);
						ctx1.lineTo(110, 207);
						ctx1.fillText("90", 113, 212);
						ctx1.fillText("Superior", 90, 224);
						ctx1.moveTo(200, 200);
						ctx1.lineTo(200, 207);
						ctx1.fillText("180", 203, 212);
						ctx1.fillText("Nasal", 200, 224);
						ctx1.moveTo(290, 200);
						ctx1.lineTo(290, 207);
						ctx1.fillText("270", 293, 212);
						ctx1.fillText("Inferior", 290, 224);
						ctx1.moveTo(380, 200);
						ctx1.lineTo(380, 207);
						ctx1.fillText("360", 360, 212);

						ctx1.strokeStyle = "black";
						ctx1.stroke();
						ctx.stroke();
						for (var i = 20, j = 0; i < 380 && j < 35; i += 10, j++) {
							k = 200 - (2 * Math.round(jsArray[j]));
					//j=160-Math.floor((Math.random() * 160) + 1);
					ctx.beginPath();
					ctx.moveTo(i, 200);
					//ctx2.moveTo(i,200);
					ctx.lineTo(i, k);
					//ctx2.lineTo(i,k);
					ctx.strokeStyle = "green";
					ctx.stroke();
				}
				ctx2.beginPath();

				prevk = 200 - (2 * Math.round(jsArray[0]));
				;
				for (var i = 20, j = 0; i < 380 && j < 35; i += 10, j++) {
					k = 200 - (2 * Math.round(jsArray[j]));
					ctx2.moveTo(i - 10, prevk);
					ctx2.lineTo(i, k);

					ctx2.strokeStyle = "green";
					ctx2.stroke();
					prevk = k;
				}
			</script>
		</div>
		<%
		System.out.println("TEST20");
		%>

	</div>
	<div id="previewImage">
</div>
<div id="popup">
	<div>
		<input type="radio" name="format_type" id="pdf"  /><label for="pdf"><span></span>PDF Format</label>
		<input type="radio" name="format_type" id="png" checked/><label for="png"><span></span>PNG Format</label>
	</div>
	<div>
		<a class="success" href="" id="download">Download</a>
	</div>
</div>
<div id="overlay">
</div>	<!--      D3 Script-->

	<footer
	style="width: 100%; margin-top: 650px; margin-left: auto; margin-right: auto;">

	<button style="margin-left: auto; margin-right: auto; right: 100;"
	id="print"
	onClick="this.style.display='none';document.getElementById('logoutForm').style.display='none';window.print()">Print</button>

	<button style="margin-left: auto; margin-right: auto; right: 100;"
	id="save"
	onClick="">Save</button>

	<button style="margin-left: auto; margin-right: auto; right: 100;"
	id="email"
	onClick="">Email</button>

</footer>
<script type="text/javascript">
	function myClickFunction(character) {

		if (character == 'S')
			document.getElementById("SuperiorRect").innerHTML = '23';
		else if (character == 'I')
			document.getElementById("InferiorRect").innerHTML = '9';
		else if (character == 'N')
			document.getElementById("NasalRect").innerHTML = '14';
		else if (character == 'T')
			document.getElementById("TemporalRect").innerHTML = '29';

	}

	function myOverFunction(character) {

		if (character == 'S')
			document.getElementById("Superior").innerHTML = '23';
		else if (character == 'I')
			document.getElementById("Inferior").innerHTML = '9';
		else if (character == 'N')
			document.getElementById("Nasal").innerHTML = '14';
		else if (character == 'T')
			document.getElementById("Temporal").innerHTML = '29';

	}

	function myOutFunction(character) {

		if (character == 'S')
			document.getElementById("Superior").innerHTML = 'S';
		else if (character == 'I')
			document.getElementById("Inferior").innerHTML = 'I';
		else if (character == 'N')
			document.getElementById("Nasal").innerHTML = 'N';
		else if (character == 'T')
			document.getElementById("Temporal").innerHTML = 'T';

	}
</script>

<script>
	function gokalpah(e) {
		console.log(e.target.className)
	}

	function graymove(d, i) {

		pos = d3.mouse(this)
		$(this.nextElementSibling).css('left', pos[0] + 'px')
		$(this.nextElementSibling).css('top', pos[1] + 'px')
		$(this.nextElementSibling).css(
		{
			'background-position' : '-' + pos[0] + 'px -'
			+ (pos[1] - 0) + 'px'
		});
	}

	$('body').tooltip({
		selector : '[title]',
		html : true,
		container : 'body'
	}).on('click', '.eye-blue, .eye-green', function(e) {
		gokalpah(e)
	}).on('click', '#left-eye svg, #right-eye svg', function(e) {
		d3.select(this).on("click", graymove)
	});
</script>
<script type="text/javascript">
	function popup() {

		var w = 600;
		var h = 660;

		var left = (screen.width / 2) - (w / 2);
		var top = (screen.height / 2) - (h / 2) - 50;
		var targetWin = window
		.open(
			"intereye.html",
			"Pop up",
			'toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=no, resizable=no, copyhistory=no, width='
			+ w
			+ ', height='
			+ h
			+ ', top='
			+ top
			+ ', left=' + left);

	}
</script>


</body>
</html>
<!--{#
- Notes
 - Animate dash-stroke of blue and green paths
 - On hover eye: shoe grayscale section

left-box { position: absolute; top: 100px; left: 200px; height: 150px; width: 150px;
    background: transparent url(data/processed/p1.jpg?v=1) no-repeat scroll;
    background-size: 600px;
    background-position:-200px -66px;
  }
$('#left-box').css({'background-position':'-200px -62px'})
#}-->