<%@page import="java.util.List"%>
<%@page import= "ProjectManagement.MemberDao" %>
<%@page import= "ProjectManagement.MemberDto" %>
<%@page import= "ProjectManagement.ProjectDao" %>
<%@page import= "ProjectManagement.ProjectDto" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.regex.Pattern" %>
<%@page import="java.sql.*"%>
<!DOCTYPE HTML>
<!--
	Editorial by HTML5 UP
	html5up.net | @ajlkn
	Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
-->
<html>

<head>
	<title>(주)하이데이타</title>

	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
	<link rel="stylesheet" href="CSS/main.css" />
	<link rel="stylesheet" href="CSS/mouseover3.css" />
	<link rel="stylesheet" type="text/css" href="CSS/multi-select.css">
	<link rel="stylesheet" type="text/css" href="CSS/option_height.css">

	<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic" rel="stylesheet">
	<script src="https://code.jquery.com/jquery-3.5.1.js" integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU=" crossorigin="anonymous"></script>
	<script type="text/javascript" src="js/ProjectMember_Add.js"></script>
<%
    request.setCharacterEncoding("UTF-8");
%>
<%
	
    ProjectDao pdao = ProjectDao.getInstance();
    ProjectDto pdto = new ProjectDto();
    
    MemberDao mdao = MemberDao.getInstance();
    MemberDto mdto = new MemberDto();
    
    List<MemberDto> memlist = mdao.user_name();

//     ProjectDao projectDao = new ProjectDao();
//     List<ProjectDto> plist = projectDao.user_name();
//     ProjectDto projectDto;

//     List<ProjectDto> list = pdao.getprj_name(Integer.parseInt((String)session.getAttribute("user_num")));
	
%>
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

		input[type=button] {
			background-color: #4F5467;
			box-shadow: none;
			color: white !important;
		}
	</style>
	
<%
try{
	String PJNo = request.getParameter("PJNo");
	String dbURL="jdbc:mysql://192.168.0.71:3306/ProjectManagement"; 
	String dbID="hidata"; 
	String dbPassword="hidata2312357!";
    Class.forName("com.mysql.jdbc.Driver");

	ResultSet rs = null;
    Connection conn=DriverManager.getConnection(dbURL, dbID, dbPassword);
   
    Statement stmt = conn.createStatement();
    String sql = "SELECT * FROM MA_Person WHERE PJNo=" + PJNo  + " ORDER BY UserId DESC";
    rs = stmt.executeQuery(sql);
%>
	
</head>

<body>

	<!-- Wrapper -->
	<div id="wrapper">

		<!-- Main -->
		<div id="main">
			<div class="inner">

				<!-- Header -->
				<div id="main">
					<div style="height:3px">
						<br />
						<a1 class=nanum; style="font-size:28px; color:black; margin-left:2%; padding-top: 250px">인원 관리</a1>
					</div>
					<div>
						<br />
					</div>
				</div>
			</div>

			<div>
				<div style="width:74.7%; float:right">
					<ul class="snip1398 ">
						<li class="rowLi">
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
						<li class="current rowLi">
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
		<br />
		<hr style="1px;">
		
		<!-- Section -->
<!-- 		<section> -->

			<div id="grid" style="height: 70%; margin-Left:5%; padding-top:50px; background-color: white; margin-Right:5%">
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
				</table>
				<div class="form-group">
                   	<select id="referers_view1" multiple="multiple" name="referers1" class="referers">
						<%
							for (MemberDto mem : memlist) {
						%>
							<option value="<%= mem.getMember_num() %>"><%= mem.getName() %>
							(<%=mem.getEmp_no()%>)
						</option>
							<%
								}
							%>
					</select>
				</div>				
				<div class="k-pager-wrap k-grid-pager">
					<a aria-label="Go to the first page" class="k-link k-pager-nav k-state-disabled k-pager-first" data-page="1" href="#" title="Go to the first page">
						<span class="k-icon k-i-arrow-end-left">
						</span>
					</a>
					<a aria-label="Go to the previous page" class="k-link k-pager-nav k-state-disabled" data-page="0" href="#" title="Go to the previous page">
						<span class="k-icon k-i-arrow-60-left">

						</span>
					</a>
				</div>
				<div style="float: right; margin-top: 20px">
					<button id = "btnSave" name = "btnSave" class="primary" type="button">등록</button>
					&nbsp&nbsp
					<input type="reset" value="취소"  onclick="location.href = 'ProjectMember_Add.jsp'">
<!-- 		            <input class="btn btn-primary" type="button" value="저장" onclick="infoConfirm()" style="float: left"> -->
<!-- 		            <input class="btn btn-primary" type="reset" value="취소" onclick="location.href = 'ProjectMember_Add.jsp'" style="float: left"> -->
		        </div>
			</div>
			<%
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
// 			finally {}
			%>

<!-- 		</section> -->
	</div>
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
		<!-- 		<li class="nanum"><a href="project_user.html">사용자 관리</a></li> -->
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
	<script src="js/jquery.multi-select.js"></script>
	<script type="text/javascript">
	</script>
</body>
</html>