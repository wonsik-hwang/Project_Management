<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.sun.org.apache.bcel.internal.generic.Select"%>
<%@ page import = "java.util.regex.Pattern" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "ProjectManagement.MySQLConnect" %>
<!DOCTYPE HTML>
<html>
	<head>
		<title>(주)하이데이타</title>
	
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
		
	<!-- Bootstrap CSS -->
	<link rel="stylesheet" href="CSS/bootstrap.min.css">
	<link rel="stylesheet" href="https://i.icomoon.io/public/temp/e5c48413e3/UntitledProject/style.css">
	<link rel="stylesheet" href="CSS/main.css" />
	<link rel="stylesheet" href="CSS/mouseover3.css" />
	
		<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic" rel="stylesheet">
		<script src="https://code.jquery.com/jquery-3.5.1.js"  integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU=" crossorigin="anonymous"></script>
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
				text-align: center;
				width: auto;
				padding-left: 5%;
				padding-right: 5%;
				min-width: 80px;
				font-size: 1em
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

		details summary::-webkit-details-marker {
			display: none;
		}
		</style>
	
		<%
		    //로그인 유무 확인
			request.setCharacterEncoding("UTF-8");
			ArrayList<String[]> CostInfo = new ArrayList<String[]>();
			String UserNm = session.getAttribute("UserNm") == null ? "" : (String)session.getAttribute("UserNm");
			String Rank = session.getAttribute("Rank") == null ? "" : (String)session.getAttribute("Rank");
			
			if (UserNm.equals(""))
			{
				out.println("<script>alert('로그인하여 주십시오.'); location.href = 'ProjectLogin.jsp'</script>");
				return;
			}
			
		try{
			Connection conn =  MySQLConnect.getMySQLConnection();
			String sql = "SELECT * FROM MA_Cost mc, MA_Project mp, members mem WHERE mc.PJTNo = mp.PJTNo AND mc.InsertUserID = mem.id";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			while (rs.next())
			{
				String InsertDate = sdf.format(rs.getDate("InsertDt"));
				CostInfo.add(new String[] {rs.getString("CostNm"), rs.getString("CostNo"), rs.getString("PJTNo"), rs.getString("PJTNm"), rs.getString("CostType"), rs.getString("name"), InsertDate, rs.getString("CostContent")});
			}
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
								<h1 class="nanum"  style="font-size:28px; color:black; margin-left:5%;">프로젝트 목록</h1>
							</div>
						</div>
					</div>
					<br />
					<hr style="border: solid 1px black;">
				</div>
				
				<!-- Banner -->
				<div class="row" style="width: 90%; height: 80%; margin: 40px 30% 3% 5%; padding: 10px; background-color: white; border-radius: 10px;">
					<div style="width: 100%; height: 50px;">
						<input class="nanum" id="Nm" type="text" style="float:left; width: 15%; margin: 10px;" placeholder="제목">
						<input class="nanum" id="InsertUser" type="text" style="float:left; width: 15%; margin: 10px;" placeholder="작성자">
						<input type="button" value="검색" style="margin: 10px;">
						<input type="button" value="프로젝트 등록"  onClick="location.href='ProjectCreate.jsp'" style="float: right; margin: 10px;">
					</div>
					
					<!--산출물 정보 팝업 -->
					<div class="modal fade" id="ApprovalInfo" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
						<div class="modal-dialog" role="document">
							<div class="modal-content">
								<div class="modal-header" style="padding: 1rem 1rem 0 1rem;">
									<h2 class="modal-title" id="exampleModalLabel">
										<label class="nanum">품의서 정보</label>
									</h2>
								</div>
								<div class="modal-body">
									<label class="nanum">제목</label> &nbsp;&nbsp;<label id="ApprovalNmLabel" style="margin-top: -6%"></label>
								</div>
								<div class="modal-body" style="margin-top: -3%">
									<label class="nanum">파일&nbsp;&nbsp;&nbsp;&nbsp;</label> <label id="ApprovalFileNmLabel"></label>
								</div>
								<div class="modal-body" style="margin-top: -3%">
									<label class="nanum">가격&nbsp;&nbsp;&nbsp;&nbsp;</label> <label id="ApprovalUseCost"></label>
								</div>
								<div class="modal-body">
									<label class="nanum" style="margin-top: -3%">내용</label> <label id="ApprovalContent" style="word-break: break-all"></label>
								</div>
								<div class="modal-footer">
									<button id="OKbtn" name="btnUpdate" class="btn" style="box-shadow: none" type="button">결재</button>
									<button id="Nobtn" name="btnUpdate" class="btn" style="box-shadow: none" type="button">반려</button>
									<button class="btn" style="box-shadow: none" type="button" data-dismiss="modal">닫기</button>
								</div>
							</div>
						</div>
					</div>
					
					<div id="grid" style="width: 100%; margin: 5px 5px 5px 5px; margin-top: -450px; background: white;">
						<table>
							<colgroup>
								<col style="width:30px" />
								<col style="width:30%" />
								<col style="width:20%" />
								<col style="width:15%" />
								<col style="width:15%" />
							</colgroup>
							<thead>
								<tr>
									<th data-field="PROJ_NAME" data-index="0" data-title="" id="28b4920c-f59e-4d15-aa06-3630ad36d243" scope="col">
										<span>
											&nbsp;
										</span>
									</th>
									<th data-field="PROJ_NAME" data-index="1" data-title="프로젝트" id="838d690c-5b5f-419a-99a9-1a8fbbfbb015" scope="col">
										<span>제목</span>
									</th>
									<th data-field="PROJ_PM" data-index="2" data-title="PM" id="399f3c50-afda-4c52-85d9-e7c527ce14ce" scope="col">
										<span>프로젝트 명</span>
									</th>
									<th data-field="PROJ_STATE" data-index="3" data-title="진행 상황" id="61a94629-97a3-4c89-949c-0e5815cfb721" scope="col">
										<span>구분</span>
									</th>
									<th data-field="PROJ_START_DATE" data-index="4" data-title="시작일" id="bce59831-42b4-44ec-9399-adae8ddcdd5f" scope="col">
										<span>등록 일자</span>
									</th>				
									<th data-field="PROJ_FINISH_DATE" data-index="5" data-title="완료일" id="c9ba7385-2956-46e8-a4f8-eaec4dbd5c90" scope="col">
										<span>등록자</span>
									</th>
								</tr>
							</thead>
							<tbody>		
								<%
									int rs_Count = 0; 
									for (int i = 0; i < CostInfo.size(); i++)
									{
										out.print("<tr>");
										out.print("<td>" + "<span>" + "&nbsp" + "</span>" + "</td>");
										out.println("<td><a class = 'btn' id = '" + CostInfo.get(i)[1] + "' name = '" + CostInfo.get(i)[1] + "' onclick = 'ApprovalInfo(this)' style = 'margin-left: -5%'><span>" + CostInfo.get(i)[0] + "</span></a></td>");
										out.print("<td>" + "<span>" + CostInfo.get(i)[3] + "</span>" + "</td>");
										if (CostInfo.get(i)[4].equals("0"))
										{
											out.print("<td>" + "<span>구매품의서</span>" + "</td>");
										}
										out.print("<td>" + "<span>" + CostInfo.get(i)[6] + "</span>" + "</td>");
										out.print("<td>" + "<span>" + CostInfo.get(i)[5] +"</span>" +  "</td>");
										out.print("<td id = '" + CostInfo.get(i)[1] + "Content" + "' hidden = 'hidden'>" + "<span>" + CostInfo.get(i)[7] +"</span>" +  "</td>");
										out.print("</tr>"); 
										rs_Count += 1;
									}
									
									if(rs_Count == 0)
									{
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
									rs.close();
									pstmt.close();
									conn.close();
								}
							catch(Exception ex){}
								%>
							</tbody>
						</table>
					</div>
				</div>
			</div>
			
			<!-- Sidebar -->
			<div id="sidebar">
				<div class="inner">
	
					<!-- Menu -->
					<nav id="menu">
						<header class="major">
							<h2 class="nanum"><a href="ProjectMain.jsp">HIDATA PROJECT CENTER</a></h2>
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
		<script src="js/jquery.min.js"></script>
		<script src="js/browser.min.js"></script>
		<script src="js/breakpoints.min.js"></script>
		<script src="js/util.js"></script>
		<script src="js/main.js"></script>
		<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
		<script src="js/bootstrap.min.js"></script>
		<script type="text/javascript">
			function ApprovalInfo(obj)
			{
				ClickId = document.getElementById(obj.getAttribute('id')).getAttribute('id');
				$('#ApprovalNmLabel').text($(obj).text());
				$('#ApprovalContent').text(document.getElementById(ClickId + "Content").outerText);
				$('#ApprovalInfo').modal({
					backdrop : 'static',
					keyboard : false
				})
			}
		</script>
	</body>
</html>
