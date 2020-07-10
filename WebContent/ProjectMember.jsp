<%@page import="com.sun.org.apache.xalan.internal.xsltc.compiler.sym"%>
<%@page import="ProjectManagement.JinjuDBConnect"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.util.Arrays" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.regex.Pattern" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.sql.*" %>
<%@ page import="ProjectManagement.MySQLConnect" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
<head>
<title>(주)하이데이타</title>

<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, user-scalable=no" />
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="CSS/bootstrap.min.css">
<link rel="stylesheet"
	href="https://i.icomoon.io/public/temp/e5c48413e3/UntitledProject/style.css">
<link rel="stylesheet" href="CSS/main.css" />
<link rel="stylesheet" href="CSS/mouseover3.css" />

<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic"
	rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.5.1.js"
	integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
	crossorigin="anonymous"></script>

<script>
	$(".hover").mouseleave(function() {
		$(this).removeClass("hover");
	});

	function home() {
		var msg = confirm("저장하지 않고 취소 하시겠습니까?");
		if (msg === true) {
			location.href = 'view_info.html';
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
		width: auto;
		padding-left: 5%;
		padding-right: 5%;
		min-width: 80px;
		font-size: 1em;
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

	body {
		scrollbar-face-color: #F6F6F6;
		scrollbar-highlight-color: #bbbbbb;
		scrollbar-3dlight-color: #FFFFFF;
		scrollbar-shadow-color: #bbbbbb;
		scrollbar-darkshadow-color: #FFFFFF;
		scrollbar-track-color: #FFFFFF;
		scrollbar-arrow-color: #bbbbbb;
		margin-left:"0px"; margin-right:"0px"; margin-top:"0px"; margin-bottom:"0px";
	}
	
	td {font-family: "Nanum Gothic"; font-size: 18px; color:#595959;}
	th {font-family: "Nanum Gothic"; font-size: 18px; color:#000000;}
	select {
		font-family: "Nanum Gothic";
		font-size: 15px;
		color:#595959;
		-webkit-appearance: none;
		-moz-appearance: none;
		appearance: none;
		background: white;
		border-radius: 0px;
	}
	select::-ms-expand {
		display: none;
	}
	
	.divDotText{
	overflow: hidden;
	text-overflow: ellipsis;
	}
	
	A:link {font-size: 18px; font-family: "Nanum Gothic"; color: #000000; text-decoration: none;}
	A:visited {font-size: 18px; font-family: "Nanum Gothic"; color: #000000; text-decoration: none;}
	A:active {font-size: 18px; font-family: "Nanum Gothic"; color: red; text-decoration: none;}
	A:hover {font-size: 18px; font-family: "Nanum Gothic"; color: red; text-decoration: none;} 
</style>

<%
	request.setCharacterEncoding("UTF-8");
	String PJTNo = request.getParameter("PJTNo");
	PJTNo = "158";
	
	String UserId = session.getAttribute("UserId") == null ? "0" : (String)session.getAttribute("UserId");
	
	// 프로젝트 참여 멤버 조회
	ArrayList<String[]> PJTMemInfo = new ArrayList<String[]>();
	Connection conn = MySQLConnect.getMySQLConnection();
	String sql = "SELECT mp.PJTNo, mp.UserID, mem.name FROM MA_Person mp, members mem WHERE mp.UserID = mem.id AND mp.PJTNo = " + PJTNo;
	PreparedStatement pstmt = conn.prepareStatement(sql);
	ResultSet rs = pstmt.executeQuery();
	
	while (rs.next())
	{
		PJTMemInfo.add(new String[] {rs.getString("PJTNo"), rs.getString("UserID"), rs.getString("name")});
	}
	
	// 선택된 멤버의 배정 현황 조회
	ArrayList<String[]> MemDtInfo = new ArrayList<String[]>();
	sql = "SELECT mw.PJTNo, mp.PJTNm, mw.UserID, mw.SetDt FROM MA_Work mw, MA_Project mp WHERE mw.PJTNo = mp.PJTNo AND mw.UserID = '" + UserId + "' ORDER BY SetDt ASC";
	pstmt = conn.prepareStatement(sql);
	rs = pstmt.executeQuery();
	
	while (rs.next())
	{
		String[] Dt = rs.getString("SetDt").split("-");
		MemDtInfo.add(new String[] { rs.getString("PJTNo"), rs.getString("PJTNm"), rs.getString("UserID"), Dt[0], Dt[1], Dt[2] });
	}
	
	sql = "SELECT * FROM MA_Project WHERE PJTNo = " + PJTNo;
	pstmt = conn.prepareStatement(sql);
	rs = pstmt.executeQuery();
	
	String PJTNm = "";
	
	while (rs.next())
	{
		PJTNm = rs.getString("PJTNm");
	}
	
	// ↓↓ 달력 ↓↓
	Calendar cal = Calendar.getInstance();
	String strYear = request.getParameter("year");
	String strMonth = request.getParameter("month");
	
	int year = cal.get(Calendar.YEAR);
	int month = cal.get(Calendar.MONTH);
	int date = cal.get(Calendar.DATE);
	
	if (strYear != null)
	{
		year = Integer.parseInt(strYear);
		month = Integer.parseInt(strMonth);
	}
	
	//년도/월 셋팅
	cal.set(year, month, 1);
	int startDay = cal.getMinimum(java.util.Calendar.DATE);
	int endDay = cal.getActualMaximum(java.util.Calendar.DAY_OF_MONTH);
	int start = cal.get(java.util.Calendar.DAY_OF_WEEK);
	int newLine = 0;
	
	//오늘 날짜 저장.
	Calendar todayCal = Calendar.getInstance();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyMMdd");
	int intToday = Integer.parseInt(sdf.format(todayCal.getTime()));
%>

</head>
<body>
	<!-- Wrapper -->
	<div id="wrapper">

		<!-- Main -->
		<div id="main" style="background: #F5F5F5">
			<div style="background: white">
				<div class="inner">

					<!-- Header -->
					<div id="main">
						<br />
						<div style="height: 3px">
							<h1 class="nanum" style="font-size: 28px; color: black; margin-left: 5%;">프로젝트 인원관리</h1>
						</div>
					</div>
				</div>
				<div>
					<div style="width: 74.7%; float: right">
						<ul class="snip1398 ">
							<li class="rowLi"><a href="ProjectInfo.jsp?PJTNo=<%=PJTNo%>"
								data-hover="기본정보"> 기본정보 </a></li>
							<li class="rowLi "><a
								href="ProjectDocument.jsp?PJTNo=<%=PJTNo%>" data-hover="문서관리">
									<span>문서관리</span>
							</a></li>
							<li class="rowLi"><a
								href="ProjectOutput.jsp?PJTNo=<%=PJTNo%>" data-hover="산출물관리">
									<span>산출물관리</span>
							</a></li>
							<li class="current rowLi"><a
								href="ProjectMember_Add.jsp?PJTNo=<%=PJTNo%>" data-hover="인원관리">
									<span>인원관리</span>
							</a></li>
							<li class="rowLi"><a href="ProjectCost.jsp?PJTNo=<%=PJTNo%>"
								data-hover="비용관리"> <span>비용관리</span>
							</a></li>
						</ul>
					</div>
				</div>
				<br />
				<hr style="border: solid 1px black;">
			</div>

			<div class="row" style="padding: 20px; margin-Left: 4%; margin-Right: 5%; margin-bottom: 2%; border-radius: 10px; background-color: white;">
				<div style="width:100%; margin-bottom: 5px;">
					<label class="nanum" style="float: left; font-size: 28px;"><%=PJTNm%></label>
					<input type="button" style="float: right;" value="검색" onclick="DateSearch()">
					<input id="DtSearch" type="date" style="float: right; margin-right: 10px; margin-top: 7px;">
				</div>
				<div style="float: left; min-width: 170px; width: 170px; height: 880px; margin-left: -20px;">
					<select id="MemberSelect" size="20" style="height: 100%;" onchange="SelectMemberChange()">
						<option value="0" selected="selected">프로젝트</option>
						<%
							for (int i = 0; i < PJTMemInfo.size(); i++)
							{
								out.println("<option value = '" + PJTMemInfo.get(i)[1] + "'>" + PJTMemInfo.get(i)[2] + "</option>");
								out.println("<script>if (document.getElementById('MemberSelect').options[" + (i + 1) + "].value == '" + UserId + "') { document.getElementById('MemberSelect').options[" + (i + 1) + "].selected = true }</script>");
							}
						%>
					</select>
				</div>
				<div style="width: 89%;">
					<form action="" method="post" name="calendarFrm" id="calendarFrm">
						<div id="content" style="width: 100%; float: left;">
							<!-- 날짜 네비게이션 -->
							<div style="height: 85px;">
								<table style="width: 100%; border: 1px solid #CED99C; background-color: #F3F9D7;" id="KOO">
									<tr>
										<td>
											<table style="width: 100%; height:10px; border: 0;">
												<tr>
													<td align="center">
														<!-- 이전 년도 -->
														<a href="<c:url value='ProjectMember.jsp' />?year=<%=year - 1%>&amp;month=<%=month%>" target="_self">&lt;&lt;&nbsp;&nbsp;</a>
														
														<!-- 이전 달 -->
														<%
															if (month > 0)
															{
														%>
														<a href="<c:url value='ProjectMember.jsp' />?year=<%=year%>&amp;month=<%=month - 1%>" target="_self">&lt;</a>
														<%
															}
															else if (month == 0)
															{
														%>
														<a href="<c:url value='ProjectMember.jsp' />?year=<%=year - 1%>&amp;month=<%=month + 11%>" target="_self">&lt;</a>
														<%
															}
														%>
														&nbsp;&nbsp;&nbsp;
														<%=year%>년
														<%=month + 1%>월
														&nbsp;&nbsp;&nbsp;
														<%
															if (month < 11)
															{
														%>
														<!-- 다음 달 -->
														<a href="<c:url value='ProjectMember.jsp' />?year=<%=year%>&amp;month=<%=month + 1%>" target="_self">&gt;&nbsp;&nbsp;</a>
														<%
															}
															else if (month == 11)
															{
														%>
														<a href="<c:url value='ProjectMember.jsp' />?year=<%=year + 1%>&amp;month=<%=month - 11%>" target="_self">&gt;&nbsp;&nbsp;</a>
														<%
															}
														%>
														
														<!-- 다음 년도 -->
														<a href="<c:url value='ProjectMember.jsp' />?year=<%=year + 1%>&amp;month=<%=month%>" target="_self">&gt;&gt;</a>
													</td>
												</tr>
											</table>
										</td>
									</tr>
								</table>
							</div>
							<table style="width: 100%; height: 800px; border: 0; background-color: #FFFFFF;">
								<thead>
									<tr bgcolor="#CECECE">
										<td>
											<div align="center"><font color="red">일</font></div>
										</td>
										<td>
											<div align="center">월</div>
										</td>
										<td>
											<div align="center">화</div>
										</td>
										<td>
											<div align="center">수</div>
										</td>
										<td>
											<div align="center">목</div>
										</td>
										<td>
											<div align="center">금</div>
										</td>
										<td>
											<div align="center"><font color="#529dbc">토</font></div>
										</td>
									</tr>
								</thead>
								<tbody>
									<tr>
										<%
											// 처음 빈 공란 표시
											for (int index = 1; index < start; index++)
											{
												out.println("<td>&nbsp;</td>");
												newLine++;
											}
											for (int index = 1; index <= endDay; index++)
											{
												String color = "";
												
												if (newLine == 0)
												{
													color = "RED";
												}
												else if (newLine == 6)
												{
													color = "#529DBC";
												}
												else
												{
													color = "BLACK";
												}
												
												String sUseDate = Integer.toString(year);
												sUseDate += Integer.toString(month + 1).length() == 1 ? "0" + Integer.toString(month + 1) : Integer.toString(month + 1);
												sUseDate += Integer.toString(index).length() == 1 ? "0" + Integer.toString(index) : Integer.toString(index);
												
												int iUseDate = Integer.parseInt(sUseDate);
												
												String backColor = "#EFEFEF";
												
												if (iUseDate == intToday)
												{
													backColor = "#EFEFEF";
												}
												
												out.println("<td valign = 'top' align = 'left' width = '50px' style = 'background-color: "+backColor+";' id = '" + index + "' onclick='ColorChange(this)' style='word-break: break-all'>");
												out.println("<font color = '" + color + "'>" + index + "</font>");
												out.println("<br>");
												
												for (int i = 0; i < MemDtInfo.size(); i++)
												{
													if (Integer.parseInt(MemDtInfo.get(i)[3]) == year && Integer.parseInt(MemDtInfo.get(i)[4]) == (month + 1) && Integer.parseInt(MemDtInfo.get(i)[5]) == index)
													{
														out.println("<script>document.getElementById('" + index + "').style.backgroundColor = '#FFA7A7'</script>");
														out.println("<label style='font-size: 15px'>");
														out.println("배정된 프로젝트 명<br>" + MemDtInfo.get(i)[1]);
														out.println("</label>");
													}
												}
												out.println("<br>");
												
												// 기능 제거
												out.println("</td>");
												newLine++;
												
												if (newLine == 7)
												{
													out.println("</tr>");
													
													if (index <= endDay)
													{
														out.println("<tr>");
													}
													
													newLine = 0;
												}
											}
											
											// 마지막 공란 Loop
											while (newLine > 0 && newLine < 7)
											{
												out.println("<td>&nbsp;</td>");
												newLine++;
											}
										%>
									</tr>
								</tbody>
							</table>
						</div>
					</form>
				</div>
				<div style="width: 100%; margin-bottom: 10px;">
					<input type="button" style="float: right;" value="인원 배치 수정" onclick="location.href = 'ProjectMember_Add.jsp'">
				</div>
			</div>
		</div>

		<!--Sidebar -->
		<div id="sidebar">
			<div class="inner">

				<!-- Menu -->
				<nav id="menu">
					<header class="major">
						<h2 class=nanum>HIDATA PROJECT CENTER</h2>
					</header>
					<ul>
						<li class="nanum"><a href="ProjectCreate.jsp">프로젝트 등록</a></li>
						<li class="nanum"><a href="ProjectList.jsp"> 프로젝트 목록</a></li>
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
		var sel = document.getElementById('MemberSelect');
		var SelectedValue = sel.options[sel.selectedIndex].value;
// 		document.getElementById("DtSearch").value = new Date().toISOString().substring(0, 10);;

		function ColorChange(obj) {
			// 인원이 선택됐는지 체크
			if (sel.value == '0')
				{
					alert("인원이 선택되지 않았습니다.");
					return false;
				}
			
			if (obj.style.backgroundColor == "rgb(239, 239, 239)")
				{
					if (confirm("해당 인원을 해당 일자에 배정 하시겠습니까?"))
					{
						$.ajax({
							url : "./ProjectMember_DateAdd.jsp",
							async : false,
							type : "POST",
							data : {
								UserID : SelectedValue,
								SetDt : <%=year%> + "-" + <%=month + 1%> + "-" + obj.id,
								PJTNo : <%=PJTNo%>
							},// 전송할 데이터
							success : function(data) {
								location.reload(true);
							}// 요청 완료 시
						});
					}
				}
			else if (obj.style.backgroundColor == "rgb(255, 167, 167)")
				{
				$.ajax({
					url : "./ProjectMember_DateCheck.jsp",
					async : false,
					type : "POST",
					data : {
						UserID : SelectedValue,
						SetDt : <%=year%> + "-" + <%=month + 1%> + "-" + obj.id,
						PJTNo : <%=PJTNo%>
					},// 전송할 데이터
					success : function(data) {
				    	if(data.indexOf("불합") != -1)
				    	{
				    		alert("다른 프로젝트에 배정되어 있습니다.");
			    		}
				    	else
				    	{
							if (confirm("해당 인원을 배정된 일자에서 제외하시겠습니까?"))
							{
								$.ajax({
									url : "./ProjectMember_DateDelete.jsp",
									async : false,
									type : "POST",
									data : {
										UserID : SelectedValue,
										SetDt : <%=year%> + "-" + <%=month + 1%> + "-" + obj.id,
										PJTNo : <%=PJTNo%>
									},// 전송할 데이터
									success : function(data) {
		 								location.reload(true);
									}// 요청 완료 시
								});
							}
				    	}
					}// 요청 완료 시
				});
			}
		}
		
		function SelectMemberChange() {
// 			var sel = document.getElementById('MemberSelect');
// 			var SelectedValue = sel.options[sel.selectedIndex].value;
			$.ajax({
				url : "./CalendarInfo.jsp",
				async : false,
				type : "POST",
				data : {
					UserID : sel.options[sel.selectedIndex].value
				},// 전송할 데이터					 
				success : function(data) {
					location.reload(true);
				}// 요청 완료 시
			});
		}
		
		function DateSearch() {
			if (document.getElementById('DtSearch').value == "")
				{
					return;
				}
			
			var Dt = document.getElementById('DtSearch').value.split('-');
			location.href = 'ProjectMember.jsp?year=' + Dt[0] + '&month=' + (Dt[1] - 1);
		}
	</script>
</body>
</html>