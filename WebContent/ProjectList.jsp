<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.regex.Pattern" %>
<%@page import="java.sql.*"%>   
<%
 response.setHeader("Cache-Control","no-cache");
 response.setHeader("Pragma","no-cache");
 response.setDateHeader("Expires",0);
%>
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

		function home() {
			var msg = confirm("저장하지 않고 취소 하시겠습니까?");
			if (msg === true) {
				location.href = 'ProjectList.jsp';
			} else {
				return;
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
						<div style="height:2px;">
							<br />
							<a1 class="nanum" ; style="font-size:28px; color:black; margin-left:5%;">프로젝트 목록</a1>
						</div>
						<div>
							<br />
						</div>
					</div>
				</div>

				<br />
				<hr style="border: solid 1px black;">
			</div>
				<!-- Banner -->

				<div class="row" style="margin-Left:5%; padding-top:50px; background-color: white; margin-Right:5%">
					<div>
						<select>
							<option value="">프로젝트 상태를 선택하세요</option>
							<option value="시작전">시작전</option>
							<option value="정상진행">정상진행</option>
							<option value="지연진행">지연진행</option>
							<option value="완료">Success</option>
							<option value="홀드">홀드</option>
							<option value="드롭">드롭</option>
							<option value="종료">종료</option>
						</select>
					</div>
					&nbsp &nbsp &nbsp &nbsp &nbsp
					<div>
						<select>
							<option value="">부서를 선택하세요</option>
							<option value="afc2df2d-4577-47ef-b449-174b78a8a8bf">솔루션 사업부</option>
							<option value="26280bbc-eea2-4fb6-8ee4-b4daba1cd0e7">팀프로젝트</option>
							<option value="351ea3d6-762e-4ece-bf0d-e54faa4794b0">팀클라우드</option>
							<option value="639f1cd3-e4c8-48ed-85d0-96ee4ffa2901">디자인 사업부</option>
							<option value="8d334f75-ebb2-4f8b-a069-5b1820aa56d9">템플릿 디자인팀</option>
							<option value="9a8251b4-daac-4a0d-8e81-632f01cd922b">간트차트 디자인팀</option>
							<option value="7b9568c5-9cae-41bd-829b-69a471a22306">집에가고싶어요</option>
							<option value="f3ef5eb3-beb0-4a7d-b014-56560472e890">시스템 사업부</option>
						</select>
					</div>
					&nbsp &nbsp &nbsp &nbsp &nbsp
					<div>
						<input id="search" type="text" class="form-control" placeholder="Search...">
						<span>
							<span><i class="la la-search"></i></span>
						</span>
					</div>
					&nbsp &nbsp &nbsp &nbsp &nbsp
					<div style="float:left; padding-left:20px">
						<input type="button" value="검색">
					</div>
					&nbsp &nbsp &nbsp &nbsp &nbsp
						<div style="width:80px; float:right;">
					<input type="button" value="프로젝트 등록"  onClick="location.href='ProjectCreate.jsp'">
					</a>
				</div>

				</div>


				<!-- Section -->
				<section>

					<div id="grid" style="margin-Left:5%; padding-top:50px; background-color: white; margin-Right:5%">
						<table>
							<colgroup>
								<col style="width:30px" />
								<col style="width:25%" />
								<col style="width:100px" />
								<col style="width:100px" />
								<col style="width:100px" />
								<col style="width:100px" />
								<col style="width:100px" />
								<col style="width:70px" />
								<col style="width:70px" />
							</colgroup>
							<thead>
								<tr>
									<th data-field="PROJ_NAME" data-index="0" data-title="" id="28b4920c-f59e-4d15-aa06-3630ad36d243" scope="col">
										<span>
											&nbsp;
										</span>
									</th>
									<th data-field="PROJ_NAME" data-index="1" data-title="프로젝트" id="838d690c-5b5f-419a-99a9-1a8fbbfbb015" scope="col">
										<span>
											프로젝트명
										</span>
									</th>
									<th data-field="PROJ_PM" data-index="2" data-title="PM" id="399f3c50-afda-4c52-85d9-e7c527ce14ce" scope="col">
										<span>
											PM
										</span>
									</th>
									<th data-field="PROJ_STATE" data-index="3" data-title="진행 상황" id="61a94629-97a3-4c89-949c-0e5815cfb721" scope="col">
										<span>
										 진행 상황
										</span>
									</th>
									<th data-field="PROJ_START_DATE" data-index="4" data-title="시작일" id="bce59831-42b4-44ec-9399-adae8ddcdd5f" scope="col">
										<span>
											시작일
										</span>
									</th>				
									<th data-field="PROJ_FINISH_DATE" data-index="5" data-title="완료일" id="c9ba7385-2956-46e8-a4f8-eaec4dbd5c90" scope="col">
										<span>
											완료일
										</span>
									</th>
								</tr>
							</thead>
							<tbody>		
<% 
try{
	
	String dbURL="jdbc:mysql://192.168.0.71:3306/ProjectManagement"; 
	String dbID="hidata"; 
	String dbPassword="hidata2312357!";
	
	Class.forName("com.mysql.jdbc.Driver");
	System.out.println("드라이버 로드를 완료 하였습니다.");
	
	ResultSet rs = null;
	Connection conn=DriverManager.getConnection(dbURL, dbID, dbPassword);
	System.out.println("MySQL 데이터베이스 db에 성공적으로 접속했습니다. ");
								   
	Statement stmt = conn.createStatement();
	String sql = "SELECT * FROM MA_Project ORDER BY PJNo DESC";
	rs = stmt.executeQuery(sql);
	
	int rs_Count = 0; 
	while(rs.next()){
		out.print("<tr>");
		out.print("<td>" + "<span>" + "&nbsp" + "</span>" + "</td>");
		out.print("<td>  <a href='ProjectInfo.jsp?PJNo="+ rs.getString("PJNo") +"'>" + "<span>" + rs.getString("PJNm") + "</span>" + " </a></td>");
		out.print("<td>" + "<span>" + rs.getString("PJPM") + "</span>" + "</td>");
		out.print("<td>" + "<span>" + rs.getString("PJState") + "</span>" + "</td>");
		out.print("<td>" + "<span>" + rs.getString("PJStartDt") + "</span>" + "</td>");
		out.print("<td>" + "<span>" + rs.getString("PJEndDt") +"</span>" +  "</td>");
		out.print("</tr>"); 
		rs_Count += 1;
	} 
	
	if(rs_Count == 0)
	{
		%>
			<tr>
									<td colspan="9">
										<div style="margin:0 auto;position:static;text-align:center">
											No records available.
										</div>
									</td>
								</tr>
								<%
	}
}

catch(ClassNotFoundException ex) {
		System.out.println("드라이버 로드에 실패하였습니다.");
		System.out.println(ex);
		%>
										<tr>
									<td colspan="9">
										<div style="margin:0 auto;position:static;text-align:center">
											저장된 데이터가 없습니다.
										</div>
									</td>
								</tr>
	<%
	}
catch(SQLException ex) {
		System.out.println("DB 접속에 실패 하였습니다.");
		System.out.println(ex.getMessage());
		ex.printStackTrace();
		%>
										<tr>
									<td colspan="9">
										<div style="margin:0 auto;position:static;text-align:center">
											저장된 데이터가 없습니다.
										</div>
									</td>
								</tr>
						<%
	}
// finally{}				
	
%>
</tbody>
	</table>
	</section>
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
<!-- 						<li class="nanum"><a href="project_user.html">사용자 관리</a></li> -->
						<li class=nanum><a></a></li>
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
</body>

</html>
