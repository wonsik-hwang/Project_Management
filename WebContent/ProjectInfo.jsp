<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.regex.Pattern" %>
<%@page import="java.sql.*"%>
<!DOCTYPE HTML>
<html>

<head>
	<title>(주)하이데이타</title>

	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
	<link rel="stylesheet" href="CSS/main.css" />
	<link rel="stylesheet" href="CSS/mouseover3.css" />


	<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic" rel="stylesheet">
	<script src="https://code.jquery.com/jquery-3.5.1.js" integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU=" crossorigin="anonymous">
	</script>

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
							<a1 class="nanum"; style="font-size:28px; color:black; margin-left:5%;">프로젝트 정보</a1>
						</div>
					</div>
				</div>
					<div>
						<div style="width:74.7%; float:right;">
							<ul class="snip1398">
								<li class="rowLi">
										<a href="ProjectInfo.jsp" data-hover="프로젝트">
										프로젝트
									</a>
								</li>
								<li class="rowLi ">
									<a href="ProjectDocument1.jsp" data-hover="서류관리">
										<span>서류관리</span>
									</a>
								</li>
								<li class="rowLi">
									<a href="ProjectOutput1.jsp" data-hover="산출물관리">
										<span>산출물관리</span>
									</a>
								</li>
								<li class="rowLi">
									<a href="ProjectMember_Add.jsp" data-hover="인원관리">
										<span>인원관리</span>
									</a>
								</li>
								<li class="rowLi">
									<a href="project_work.html" data-hover="작업관리">
										<span>작업관리</span>
									</a>
								</li>
								<li class="rowLi">
									<a href="ProjectCost1.jsp" data-hover="비용관리">
										<span>비용관리</span>
									</a>
								</li>
							</ul>
						</div>
					</div>

					<br />
					<hr style="border: solid 1px black;">

			</div>
			<div class="row" style="margin-Left:5%; margin-right:5%;padding-top:30px; background: #FFFFFF; border-radius: 10px;">
				<div style="width: 100%;">
				
				<%
				try{
					String PJNo = request.getParameter("PJNo");
					String dbURL="jdbc:mysql://192.168.0.71:3306/ProjectManagement?serverTimezone=UTC"; 
				   	String dbID="hidata"; 
				  	String dbPassword="hidata2312357!";
			 	    Class.forName("com.mysql.jdbc.Driver");
				    	
				    ResultSet rs = null;
				    Connection conn=DriverManager.getConnection(dbURL, dbID, dbPassword);
				   
				    Statement stmt = conn.createStatement();
				    String sql = "SELECT * FROM MA_Project WHERE PJNo=" + PJNo;
				    rs = stmt.executeQuery(sql);
				   
				   while(rs.next()){
				%>
				<div style="width:50%; float: left">
						<div>
						<label class="toppadding">프로젝트명</label>
						<label id="PJNm" class="txtlabel"><%=rs.getString("PJNm")%></label>
	
						<label class="toppadding">업체 명</label>
						<label id="PartnerNm" class="txtlabel"><%=rs.getString("PartnerNm")%></label>
	
						<label class="toppadding">주관 담당자(정)</label>
						<label id="HostManager" class="txtlabel"><%=rs.getString("HostManager")%></label>
						</div>
						<div>
							<label class="toppadding" id="DATE">기간</label>
							
							<label><%= rs.getString("PJStartDt").split(" ")[0]%></label>
							&nbsp&nbsp~&nbsp&nbsp
							<label><%= rs.getString("PJEndDt").split(" ")[0]%></label>
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

				<div style="width: 100%;">
					<div>
						<label class="toppadding">프로젝트 내용</label>
						<label class="txtlabel" style="min-height: 100px; word-wrap: break-word; padding-right: 20px"><%=rs.getString("PJContent")%></label>
					</div>
					<div style="float:right; padding: 0px 20px 20px 0px ;">
						<input class="primary" type="button" value="수정" onClick="location.href = 'ProjectInfo_Modify.jsp'">
						<input class="primary" type="button" value="삭제" onClick="location.href = 'ProjectDelete.jsp'">
						<input type="button" value="목록" onClick="location.href = 'ProjectList.jsp'">
					</div>
				</div>
		</div>
		
<%
		 }
        conn.close();
    }
catch(ClassNotFoundException ex) {
	   	System.out.println("드라이버 로드에 실패하였습니다.");
	   	System.out.println(ex);
		}

catch(SQLException ex) {
	   	System.out.println("DB 접속에 실패 하였습니다.");
	   	System.out.println(ex.getMessage());
	   	ex.printStackTrace();
		}
%>
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
		<!-- 						<li class="nanum"><a href="project_user.html">사용자 관리</a></li> -->
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
<<<<<<< HEAD
			<script src="js/main.js"></script>		
=======
			<script src="js/main.js"></script>
>>>>>>> branch 'master' of https://github.com/wonsik-hwang/Project_Management.git
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