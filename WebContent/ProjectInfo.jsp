<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.regex.Pattern" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "ProjectManagement.MySQLConnect" %>
<!DOCTYPE HTML>
<html>

<head>
	<title>(주)하이데이타</title>

	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
	<link rel="stylesheet" href="CSS/main.css" />
	<link rel="stylesheet" href="CSS/mouseover3.css" />

	<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic" rel="stylesheet">
	<script src="https://code.jquery.com/jquery-3.5.1.js"  integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU=" crossorigin="anonymous"></script>
	<script src="js/jquery.min.js"></script>
	<script src="js/browser.min.js"></script>
	<script src="js/breakpoints.min.js"></script>
	<script src="js/util.js"></script>
	<script src="js/main.js"></script>

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
			height: 5%;
			width: auto;
		}

		input[type=button] {
			background-color: #4F5467;
			box-shadow: none;
			color: white !important;
		}
	</style>

<% 
try{
	Connection conn = MySQLConnect.getMySQLConnection();
	
	String PJNo = request.getParameter("PJNo");
	String sql = "SELECT * FROM MA_Project WHERE PJNo = '" + PJNo + "'";
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
							<h1 class="nanum"; style="font-size:28px; color:black; margin-left:5%;">프로젝트 정보</h1>
						</div>
					</div>
				</div>
				<div>
					<div style="width:74.7%; float:right;">
						<ul class="snip1398 ">
							<li class="current rowLi">
								<a href="ProjectInfo.jsp?PJNo=<%= PJNo%>" data-hover="기본정보">
									기본정보
								</a>
							</li>
							<li class="rowLi ">
								<a href="ProjectDocument.jsp?PJNo=<%= PJNo %>" data-hover="서류관리">
									<span>서류관리</span>
								</a>
							</li>
							<li class="rowLi">
								<a href="ProjectOutput.jsp?PJNo=<%= PJNo %>" data-hover="산출물관리">
									<span>산출물관리</span>
								</a>
							</li>
							<li class="rowLi">
								<a href="ProjectMember_Add.jsp?PJNo=<%= PJNo %>" data-hover="인원관리">
									<span>인원관리</span>
								</a>
							</li>
							<li class="rowLi">
								<a href="project_work.html" data-hover="작업관리">
									<span>작업관리</span>
								</a>
							</li>
							<li class="rowLi">
								<a href="ProjectCost.jsp?PJNo=<%= PJNo %>" data-hover="비용관리">
									<span>비용관리</span>
								</a>
							</li>
						</ul>
					</div>
				</div>
				<br />
				<hr style="border: solid 1px black;">
			</div>
			<div class="row" style="margin-Left:4%; padding-top:30px; background-color: white; margin-Right:5%; border-radius: 10px;">
				<div style="width: 100%;">
					<%
						while(rs.next()) {
					%>
	
					<div style="width:50%; float: left;">
						<div>
							<label class="toppadding">프로젝트명</label>
							<label id="PJNm" class="txtlabel"><%=rs.getString("PJNm")%></label>
		
							<label class="toppadding">업체 명</label>
							<label id="PartnerNm" class="txtlabel"><%=rs.getString("PartnerNm")%></label>
		
							<label class="toppadding">주관 담당자(정)</label>
							<label id="HostManager" class="txtlabel"><%=rs.getString("HostManager")%></label>
						</div>
					</div>
							
					<div>
							<label class="toppadding">프로젝트 PM</label>
							<label id="PJPM" class="txtlabel"><%=rs.getString("PJPM")%></label>
		
							<label class="toppadding">주관 명</label>
							<label id="HostNm" class="txtlabel"><%=rs.getString("HostNm")%></label>
		
							<label class="toppadding">주관 담당자(부)</label>
							<label id="HostSubManager" class="txtlabel"><%=rs.getString("HostSubManager")%></label>
					</div>
				</div>
				<div style="width:100%">
					<div style="width:100%">
						<label class="toppadding" id="DATE">기간</label>
					</div>
					<label style="float: left;"><%= rs.getString("PJStartDt")%></label>
					<label style="width: 3%; float: left; text-align: center">~</label>
					<label style="float: left;"><%= rs.getString("PJEndDt")%></label>
				</div>
						
				<div style="width: 100%;">
					<div>
						<label class="toppadding">프로젝트 내용</label>
						<label class="txtlabel" style="min-height: 100px; word-wrap: break-word; padding-right: 20px"><%=rs.getString("PJContent")%></label>
					</div>
					<div style="float:right; padding: 0px 20px 20px 0px ;">

						<a href="ProjectInfo_Modify.jsp?PJNo=<%=PJNo%>"><input class="primary" type="button" value="수정"></a>
						<a href='ProjectDelete.jsp?PJNo=<%=PJNo%>'><input class="primary" type="button" value="삭제"></a>
						<input type="button" value="목록" onClick="location.href = 'ProjectList.jsp'">
					</div>
				</div>
				<%
						}
				        conn.close();
					}
					catch(SQLException ex) {
						   	System.out.println("DB 접속에 실패 하였습니다.");
						   	System.out.println(ex.getMessage());
						   	ex.printStackTrace();
							}
				%>
			</div>
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
						<li class="nanum"><a href="ProjectCreate.jsp">프로젝트 등록</a></li>
						<li class="nanum"><a href="ProjectList.jsp"> 프로젝트 목록</a></li>
					</ul>
				</nav>
			</div>
		</div>
	</div>
</body>
</html>
<!--   String PJNo = request.getParameter("PJNo"); -->
<!-- 				   PreparedStatement pstmt; -->
<!-- 				   String dbURL="jdbc:mysql://192.168.0.71:3306/ProjectManagement?serverTimezone=UTC";  -->
<!-- 				   String dbID="hidata";  -->
<!-- 				   String dbPassword="hidata2312357!"; -->
<!-- 				   Class.forName("com.mysql.jdbc.Driver"); -->
				   
<!-- 				   Connection conn=DriverManager.getConnection(dbURL, dbID, dbPassword); -->
				   
<!-- 				   Statement stmt = conn.createStatement(); -->
<!-- 				   String sql = "DELETE FROM MA_Project WHERE PJNo = " + PJNo; -->
<!-- 				   pstmt = conn.prepareStatement(sql); -->
<!-- 			       stmt.executeUpdate(sql); -->
			       
<!-- 			       pstmt.close(); -->
<!-- 			       stmt.close(); -->
<!-- 			       conn.close(); -->