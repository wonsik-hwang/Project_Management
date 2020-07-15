<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@ page import = "ProjectManagement.JinjuDBConnect" %>
<%@ page import = "ProjectManagement.MySQLConnect" %>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>

<head>
	<title>프로젝트 관리 솔루션</title>

	<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
		<link rel="stylesheet" href="CSS/main.css" />
		<link rel="stylesheet" href="CSS/mouseover3.css" />
	
		<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic" rel="stylesheet">
		<script src="https://code.jquery.com/jquery-3.5.1.js"  integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU=" crossorigin="anonymous"></script>
		<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
   		<script type="text/javascript">
//     	 	 google.charts.load("current", {packages:["corechart"]});
//     		 google.charts.setOnLoadCallback(drawChart);
//     	 	 function drawChart() {
//          	    var data = google.visualization.arrayToDataTable([
//          		 ['Task', 'Hours per Day'],
//       		     ['Work',     11],
//    		         ['Eat',      2],
//        		     ['Commute',  2],
//       		     ['Watch TV', 2],
//         		 ['Sleep',    7]
//         		]);

//      		    var options = {
//           			  pieHole: 0.4,
//         		};

//         var chart = new google.visualization.PieChart(document.getElementById('donutchart'));
//         chart.draw(data, options);
//       }
    </script>
		<script>
		$(".hover").mouseleave(
			function() {
				$(this).removeClass("hover");
			}
		);

		function home() {
			location.href = 'project_list.html';
		}

		function update() {
			location.href = 'update_info.html';
		}
		
// 		function logoutPro(){
// 			location.href="member/pro/LogoutPro.jsp";
// 				}

		function showClock(){
        var currentDate = new Date();
        var divClock = document.getElementById("divClock");

        var msg = "현재 시간 : "+currentDate.getHours()+"시 "
        msg += currentDate.getMinutes()+"분 ";
        msg += currentDate.getSeconds()+"초 ";

        divClock.innerText = msg;
        setTimeout(showClock,1000);
    	}
		
		function Logout(){
			var answer = confirm("로그아웃 하시겠습니까?")
			
			if(answer==true)
			{
<%-- 				<%session.setAttribute("UserId", "");%> --%>
				location.href = 'ProjectLogin.jsp';
			}
		}
		
	    </script>

	<style>
		.body {
			font-family: 'Nanum Gothic', sans-serif;
			font-size: 15pt;
		}


		.btn {
			margin-right: 3%;
			height: 50px;
			line-height: 50px;
			text-align: center;
			width: auto;
			padding-left: 5%;
			padding-right: 5%;
			min-width: 80px;
			font-size: 1.2em
		}

		.toppadding {
			font-size: 18px;
			font-weight: bold;
			padding-top: 20px;
		}

		.rowLi {
			float: left;
			list-style-type: none;
			margin-left: 5%
		}

		.txtbox {
			border-style: solid;
			border-width: 1px;
			border-color: gray;
		}

		.nanum {
			font-family: 'Nanum Gothic', sans-serif;
			font-size: 18px;
		}

		.txtlabel {
			font-size: 15px;
			font-weight: normal;
			height: auto;
			width: auto;
		}

		input[type=button] {
			background-color: #4F5467;
			box-shadow: none;
			color: white !important;
		}

		.div_type1 {
			margin-left: 2%;
			margin-right: 1%;
			margin-bottom: 1%;

			padding: 0px 10px 10px 10px;
			text-align: center;

			align: Right;
			word-wrap: break-word;

			background-color: white;

			border-radius: 10px;

			height: auto;
			min-height: 400px;
			width: 93%;
			min-width: 500px;

			float: left;
		}

		.div_type2 {
			margin-left: 2%;
			margin-right: 1%;
			margin-bottom: 1%;

			padding: 0px 10px 10px 10px;
			text-align: center;

			background-color: white;

			border-radius: 10px;

			word-wrap: break-word;

			height: auto;
			min-height: 400px;
			width: 45%;
			min-width: 500px;

			float: left;
		}

		.div_type3 {
			margin-left: 2%;
			margin-right: 0%;
			margin-bottom: 1%;

			padding: 0px 10px 10px 10px;
			text-align: center;

			background-color: white;

			border-radius: 10px;

			word-wrap: break-word;

			height: auto;
			min-height: 400px;
			width: 46%;
			min-width: 500px;

			float: left;
		}

		.div_type4 {
			margin-left: 1%;
			margin-right: 1%;
			margin-bottom: 1%;

			padding: 0px 10px 10px 10px;
			text-align: center;

			background-color: white;

			border-radius: 10px;
			display: inline-block;

			word-wrap: break-word;

			height: auto;
			min-height: 400px;
			width: 46%;
			min-width: 500px;

			float: left;
			
		}
			
		.more_info {
			text-align : right;
			font-size : 20px;
			font-color : blue;
		}
		
		details summary::-webkit-details-marker {
			display: none;
		}
	</style>

</head>

<%
    //로그인 유무 확인
	request.setCharacterEncoding("UTF-8");
	String UserNm = session.getAttribute("UserNm") == null ? "" : (String)session.getAttribute("UserNm");
	String Rank = session.getAttribute("Rank") == null ? "" : (String)session.getAttribute("Rank");
	
	if (UserNm.equals(""))
	{
		out.println("<script>alert('로그인하여 주십시오.'); location.href = 'ProjectLogin.jsp'</script>");
		return;
	}

	// 창원 DB 연결
	Connection conn = MySQLConnect.getMySQLConnection();
	
	// 로그인한 사용자가 속한 프로젝트를 찾는 쿼리문
// 	String projectjoin = "SELECT ";
%>

<body onload="showClock()">
	<!--  -->
	<div id="wrapper">

		<!-- main -->
		<div id="main" style="background:#F5F5F5">
			<div style="background: white">
 

				<!-- Header -->
				<div class="inner">
					<div id="main">
						<div style="height:2px;">
							<br />
							<H1 class="nanum" style="font-size:28px; color:black; margin-left:5%;">메인 페이지</H1>
						</div>
						<div>
							<br />
						</div>
					</div>
				</div>
				<!-- 상단바 -->


				<br />

				<!--경계선-->
				<hr style="border: solid 1px black;">
				<!-- 상단 흰색 배경 -->
			</div>
			<!-- 내부 요소 추가 -->
			<div class="row" style="font-family:Nanum Gothic; font-size:1.5em; color:#000000; margin-left:4%; margin-bottom:2%;">
				 <%=UserNm%>님 안녕하세요.
				<div id="divClock" class= "clock">
				</div>

				<div>

				</div>
			</div>

			<div>
				<div class="div_type1">
					<div style="float:left; font-weight:700;font-size:40px; color:black; margin-left:3%; padding-top:10px;">
					 참여 프로젝트 목록
					</div>
					 <div class = more_info style= "float:right; margin: 10px 20px 10px 10px">
						more
					</div>
					<hr style="margin-top:-1.2%; border:solid 2px #f5f5f5; margin-top: 85px">
					<div class="nanum" style="margin-left:3%;">
					   
					

					</div>
				</div>

				<div class="div_type3">
					<H1 class="nanum" style="font-size:40px; color:black; margin-left:3%; text-align:left; padding: 10px;">
						나의 변경 내역
					</h1>
					<hr style="margin-top: -20px; border:solid 2px #f5f5f5;">

					<div class="nanum" style="margin-left:5%; float:left; font-size:25px">
						산출물 : _건
					</div><br /><br />
					<div class="nanum" style="margin-left:5%; float:left; font-size:25px">
						문서 : _건
					</div><br><br>
					<div class="nanum" style="margin-left:5%; float:left; font-size:25px">
						구매품의서 : _건
					</div><br /><br />
				</div>
			</div>

			<div style="margin-top: 2%">
				<div class="div_type4">
					<H1 class="nanum" style="font-size:40px; color:black; margin-left:3%; text-align:left; padding: 10px;">
						전체 프로젝트 현황
					</h1>
					<hr style="margin-top:-20px; border:solid 2px #f5f5f5;">
					
					<div id="donutchart" style="width:100%; height:120%"></div>
				</div>

			</div>



		<!--전체 회색 배경 -->
		</div>
		<!-- Sidebar -->
		<div id="sidebar">
			<div class="inner">

				<!-- Menu -->

				<nav id="menu">
					<header class="major">
						<h2 class="nanum"> HIDATA PROJECT CENTER</h2>
					</header>
					<ul>
						<li class="nanum"><a href="ProjectList.jsp">프로젝트 목록</a></li>
						<li class="nanum"><a href="ProjectCreate.jsp">프로젝트 등록</a></li>
						<%
							if (!Rank.equals("사원"))
							{
								out.println("<li class = 'nanum'>");
								out.println("<details open = 'open'>");
								out.println("<summary style = 'margin: 9px 0px 16px 0px'>관리 페이지</summary>");
								out.println("<ul>");
								out.println("<li class = 'nanum'><a href = 'ProjectApproval.jsp'>결재 목록</a></li>");
								out.println("<li class = 'nanum'><a href = '#'>양식 목록</a></li>");
								out.println("</ul>");
								out.println("</details>");
								out.println("</li>");
							}
						%>
						<li class="nanum"><a onclick="Logout()">로그아웃</a></li>
						<li></li>
					</ul>
				</nav>
			</div>
		</div>
	</div>



	<!-- Scripts -->
	<script src="assets/js/jquery.min.js"></script>
	<script src="assets/js/browser.min.js"></script>
	<script src="assets/js/breakpoints.min.js"></script>
	<script src="assets/js/util.js"></script>
	<script src="assets/js/main.js"></script>
	<script>
	
	
	</script>

</body>

</html>
