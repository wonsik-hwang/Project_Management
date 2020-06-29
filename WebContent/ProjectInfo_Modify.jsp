<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.regex.Pattern" %>
<%@ page import = "java.sql.*" %>
<%@page import = "java.util.*" %>
<%@ page import = "ProjectManagement.MySQLConnect" %>
<%@page import = "java.text.DecimalFormat" %>
<%@page import = "java.text.SimpleDateFormat" %>
<%@page import="java.text.DateFormat"%>
<%@page import="com.mysql.jdbc.Messages"%>
<%@page import= "java.sql.Date"%>
<%@page import = "java.sql.DriverManager" %>
<%@page import = "java.sql.PreparedStatement" %>
<%@page import = "java.sql.Connection" %>
<%@page import = "java.sql.Timestamp" %>

<!DOCTYPE HTML>
<html>
	<head>
		<title>(주)하이데이타</title>
	
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
		<link rel="stylesheet" href="CSS/main.css" />
		<link rel="stylesheet" href="CSS/mouseover3.css" />
	
		<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic" rel="stylesheet" />
		<script src="https://code.jquery.com/jquery-3.5.1.js"  integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU=" crossorigin="anonymous"></script>
		<script>
			$(".hover").mouseleave(
				function() {
					$(this).removeClass("hover");
				}
			);
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
				padding-top: 15px
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
		</style>

		<% 
			try{
				request.setCharacterEncoding("UTF-8");
				Connection conn = MySQLConnect.getMySQLConnection();
				
				String PJNo = request.getParameter("PJNo");
				String sql = "SELECT * FROM MA_Project WHERE PJNo =" + PJNo;
				PreparedStatement pstmt = conn.prepareStatement(sql);
				ResultSet rs = pstmt.executeQuery();
		%>

	</head>
	<body>
		<!-- Wrapper -->
		<div id="wrapper">
	
			<!-- main -->
			<div id="main" style="background:#F5F5F5">
				<div style="background: white">
					<div class="inner">
	
						<!-- Header -->
						<div id="main">
							<br />
							<div style="height:2px;">
								<h1 class="nanum"  style="font-size:28px; color:black; margin-left:5%;">프로젝트 수정</h1>
							</div>
						</div>
					</div>
					<br />
					<hr style="border: solid 1px black;">
				</div>

				<form name="sub1" id="sub1" method="post" action="Info_Modify_Confirm.jsp" onSubmit="return false;">
				<div class="row" style="margin-Left:5%; margin-right:5%; padding-top:30px;background: #FFFFFF; border-radius: 10px;">
					<div class="col-5">
						
							<label>프로젝트명</label>
							<input name = "PJNm"  id="PJNm"  type="text" value= <%=rs.getString("PJNm")%>>
		
							<label class="toppadding">업체 명</label>
							<input type="text" id="PartnerNm" name="PartnerNm"  value= <%=rs.getString("PartnerNm")%>>
		
							<label class="toppadding">주관 담당자(정)</label>
							<input type="text" id="HostManager" name="HostManager"  value= <%=rs.getString("HostManager")%>>
		
							<div>
								<label class="toppadding" id="DATE">기간</label>
								<input name = "StartDt"  id="StartDt"  type="date" value=<%=rs.getString("PJStartDt")%>>
								&nbsp;&nbsp;~&nbsp;&nbsp;
								<input name = "EndDt"  id="EndDt"  type="date" value= <%=rs.getString("PJEndDt")%>>
							</div>
						</div>
			
						<div class="col-5">
							<label>프로젝트 PM</label>
							<input name = "PJPM" id="PJPM" type="text" value= <%=rs.getString("PJPM")%>>
		
							<label class="toppadding">주관 명</label>
							<input name = "HostNm" id="HostNm" type="text" value= <%=rs.getString("HostNm")%>>
		
							<label class="toppadding">주관 담당자(부)</label>
							<input name = "HostSubManager" id="HostSubManager" type="text" value= <%=rs.getString("HostSubManager")%>>
						</div>
			
						<div class="col-10">
							<label class="toppadding">프로젝트 내용</label>
							<textarea name = "PJContent" id="PJContent" rows="5" ><%=rs.getString("PJContent")%></textarea>
							<div style="height: 100px; float:right; padding-top: 15px;">
								<button id = "btnSave" name = "btnSave" class="primary"onClick="btnClick()">등록</button>
								&nbsp;
								<button type="button" value="취소"  onclick="location.href = 'ProjectInfo.jsp?PJNo=<%= PJNo %>'">취소</button>
							</div>
						</div>
						<input name = "PJNo" id="PJNo" type="text" value= <%=PJNo%> style="display:none">
						
						<%
							}
							catch(Exception ex)
							{
								
							}
						%>
				</div>
				</form>
			</div>
	
			<!-- Sidebar -->
			<div id="sidebar">
				<div class="inner">
	
					<!-- Menu -->
					<nav id="menu">
						<header class="major">
							<h2 class=nanum> HIDATA PROJECT CENTER</h2>
						</header>
						<ul>
							<li class="nanum"><a href="ProjectCreate.jsp">프로젝트 등록</a></li>
							<li class="nanum"><a href="ProjectList.jsp"> 프로젝트 목록</a></li>
						</ul>
					</nav>
				</div>
			</div>
		</div>

		<!-- Scripts -->
		<script src="js/jquery.min.js"></script>
		<script src="js/browser.min.js"></script>
		<script src="js/breakpoints.min.js"></script>
		<script src="js/util.js"></script>
		<script src="js/main.js"></script>
		<script>
					function btnClick(){
					        if (document.getElementById("PJNm").value == "") {
					            alert("내용을 입력해주세요");
					            return false;
					  			 }
					       else{
						   		document.sub1.submit();
						   		}
	  					}
		</script>
	</body>
</html>