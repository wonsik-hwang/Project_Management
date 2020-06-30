<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.regex.Pattern" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "ProjectManagement.JinjuDBConnect" %>
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
		<script>
			$(".hover").mouseleave(
				function() {
					$(this).removeClass("hover");
				}
			);
	
			function update() {
				location.href = 'update_info.html';
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
		</style>
		<%
			try
			{
				ArrayList<String[]> member = new ArrayList<String[]>();
				Connection conn = JinjuDBConnect.getJinjuDBConnection();
				
				String sql = "SELECT mem.id, mem.name FROM members mem";
				PreparedStatement pstmt = conn.prepareStatement(sql);
				ResultSet rs = pstmt.executeQuery();
				
				String sql2 = "SELECT mem.id, mem.name FROM members mem WHERE mem.rank = '사장'";
				PreparedStatement pstmt2 = conn.prepareStatement(sql2);
				ResultSet rs2 = pstmt2.executeQuery();
				
				while (rs.next())
				{
					member.add(new String[]{rs.getString("id"), rs.getString("name")});
				}
		%>
	</head>
	<body  class="is-preload">
		<!-- Wrapper -->
		<div id="wrapper">
	
			<!-- Main -->
			<div id="main" style="background:#F5F5F5">
				<div style="background: white">
					<div class="inner">
	
						<!-- Header -->
						<div id="main">
							<br>
							<div style="height:2px;">
								<h1 class="nanum"  style="font-size:28px; color:black; margin-left:5%;">프로젝트 등록</h1>
							</div>
							<br>
						</div>
					</div>
					<hr style="border: solid 1px black;">
				</div>
	
				<form id="PJTCreate" name="PJTCreate" action="ProjectCreate_OK.jsp"  method="post">
					<div class="row" style="margin-Left:5%; margin-right:5%; padding-top:30px;background: #FFFFFF; border-radius: 10px;">
						<div style="width: 48%;">
							<label>프로젝트명</label>
							<input name = "PJTNm"  id="PJTNm"  type="text">
		
							<label class="toppadding">업체 명</label>
							<input type="text" id="PartnerNm" name="PartnerNm">
		
							<label class="toppadding">주관 담당자(정)</label>
							<input type="text" id="HostManager" name="HostManager">
		
							<div>
								<label class="toppadding" id="DATE">기간</label>
								<input name = "PJTStartDt"  id="PJTStartDt"  type="date" style="border: 1px solid">
								&nbsp;&nbsp;~&nbsp;&nbsp;
								<input name = "PJTEndDt"  id="PJTEndDt"  type="date" style="border: 1px solid">
							</div>
							
							<details class="toppadding" open="open" style="width: 88%">
								<summary><b>결재자</b></summary>
								<label class="toppadding">1차 결재자</label>
								<select id="Approval1" name="Approval1">
								<%
									out.println("<option value = '0'>선택 없음</option>");
									for (int i = 0; member.size() > i; i++)
									{
										out.println("<option value = '" + member.get(i)[0] + "'>" + member.get(i)[1] + "</option>");
									}
								%>
								</select>
								<label class="toppadding">2차 결재자</label>
								<select id="Approval2" name="Approval2">
								<%
									out.println("<option value = '0'>선택 없음</option>");
									for (int i = 0; member.size() > i; i++)
									{
										out.println("<option value = '" + member.get(i)[0] + "'>" + member.get(i)[1] + "</option>");
									}
								%>
								</select>								
								<label class="toppadding">3차 결재자</label>
								<select id="Approval3" name="Approval3">
								<%
									out.println("<option value = '0'>선택 없음</option>");
									for (int i = 0; member.size() > i; i++)
									{
										out.println("<option value = '" + member.get(i)[0] + "'>" + member.get(i)[1] + "</option>");
									}
								%>
								</select>
								<label class="toppadding">4차 결재자</label>
								<select id="Approval4" name="Approval4">
								<%
									out.println("<option value = '0'>선택 없음</option>");
									for (int i = 0; member.size() > i; i++)
									{
										out.println("<option value = '" + member.get(i)[0] + "'>" + member.get(i)[1] + "</option>");
									}
								%>
								</select>
								<label class="toppadding">최종 결재자</label>
								<select id="Approval5" name="Approval5">
								<%
									while (rs2.next())
									{
										out.println("<option value = '" + rs2.getString("id") + "'>" + rs2.getString("name") + "</option>");
									}
								%>
								</select>
							</details>
						</div>
						<%
						}
						catch (Exception e)
						{
							e.getStackTrace();
						}
						%>
		
						<div style="width: 48%; margin-left: 1%">
							<label>프로젝트 PM</label>
							<input name = "PJTPMID" id= "PJTPMID" type="text">
		
							<label class="toppadding">주관 명</label>
							<input name = "HostNm" id="HostNm" type="text">
		
							<label class="toppadding">주관 담당자(부)</label>
							<input name = "HostSubManager" id="HostSubManager" type="text">
						</div>
		
						<div style="width: 97%">
							<label class="toppadding">프로젝트 내용</label>
							<textarea name = "PJTContent" id="PJTContent" rows="5"> </textarea>
							<div style="height: 100px; float:right; padding-top: 15px;">
								<button id = "btnSave" name = "btnSave" class="primary" type="button">등록</button>
								&nbsp;&nbsp;
								<input type="button" value="취소"  onclick="location.href = 'ProjectList.jsp'">
							</div>
						</div>
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
		<script src="js/jquery.min.js"></script>
		<script src="js/browser.min.js"></script>
		<script src="js/breakpoints.min.js"></script>
		<script src="js/util.js"></script>
		<script src="js/main.js"></script>
		<script type="text/javascript" >
		$(function () {
			$("#btnSave").click(function () {
				if ($("#PJTNm").val() == "")
				{
					alert('프로젝트 명이 기입되지 않았습니다.');
					return;
				}
				if ($("#PJTPM").val() == "")
				{
					alert('프로젝트 PM이 기입되지 않았습니다.');
					return;
				}
				if ($("#PartnerNm").val() == "")
				{
					alert('업체 명이 기입되지 않았습니다.');
					return;
				}
				if ($("#HostNm").val() == "")
				{
					alert('주관 명이 기입되지 않았습니다.');
					return;
				}
				if ($("#HostManager").val() == "")
				{
					alert('주관 담당자(정)이 기입되지 않았습니다.');
					return;
				}
				if ($("#HostSubManager").val() == "")
				{
					alert('주관 담당자(부)가 기입되지 않았습니다.');
					return;
				}
				if ($("#PJTStartDt").val() == "")
				{
					alert('시작 일자가 기입되지 않았습니다.');
					return;
				}
				if ($("#PJTEndDt").val() == "")
				{
					alert('종료 일자가 기입되지 않았습니다.');
					return;
				}
				$.ajax({
				    url:"./ProjectCreate_Check.jsp",
				    async:false,
				    type:"POST",
				    data: { PJTNm: $("#PJTNm").val() },// 전송할 데이터					 
				    success:function(data) {
				    	if(data.indexOf("중복") != -1) {
			    			alert("중복된 프로젝트 명이 존재합니다.");
			    		}
				    	else {
				    		$("#PJTCreate").submit();
				    	}
				    }// 요청 완료 시
				});
			})
		})
		</script>
		<script type="text/javascript">
			document.getElementById("PJTStartDt").value = new Date().toISOString().substring(0, 10);;
			document.getElementById("PJTEndDt").value = new Date().toISOString().substring(0, 10);;
		</script>
	</body>
</html>