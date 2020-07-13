<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.ArrayList"%>
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
	
		<!-- Bootstrap CSS -->
		<link rel="stylesheet" href="CSS/bootstrap.min.css">
		<link rel="stylesheet" href="https://i.icomoon.io/public/temp/e5c48413e3/UntitledProject/style.css">
		<link rel="stylesheet" href="CSS/main.css" />
		<link rel="stylesheet" href="CSS/mouseover3.css" />
		
		<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic" rel="stylesheet">
		<script src="https://code.jquery.com/jquery-3.5.1.js" integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU=" crossorigin="anonymous"></script>
		<script>
			$(".hover").mouseleave(
				function() {
					$(this).removeClass("hover");
				}
			);
	
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
				text-align: center;
				width: auto;
				padding-left: 5%;
				padding-right: 5%;
				min-width: 80px;
				font-size: 1em
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
		</style>
		
		<% 
			try{
				ArrayList<String[]> CostInfo = new ArrayList<String[]>();
				ArrayList<String[]> Approval = new ArrayList<String[]>();
				String PJTNo = request.getParameter("PJTNo");
				PJTNo = "160";
				
				Connection conn = MySQLConnect.getMySQLConnection();
				
				// 비용 정보 조회
				String sql =	"SELECT * FROM MA_Cost mc, CommonCode cc, members mem WHERE mc.PJTNo = ? " +
									"AND mc.CostCd = cc.CodeValue AND mc.InsertUserID = mem.id " +
									"ORDER BY mc.CostNo DESC";
				PreparedStatement pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, Integer.parseInt(PJTNo));
				ResultSet rs = pstmt.executeQuery();
				
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				String CostType = "";
				while (rs.next())
				{
					if (rs.getString("CostType").equals("0"))
					{
						CostType = "구매품의서";
					}
					else if (rs.getString("CostType").equals("1"))
					{
						CostType = "지출결의서";
					}
					
					String InsertDt = sdf.format(rs.getDate("InsertDt"));
					CostInfo.add(new String[] {rs.getString("CostNo"), rs.getString("CostNm"), rs.getString("DisplayValue"), rs.getString("ApprovalCnt"), InsertDt, rs.getString("name"), CostType, rs.getString("CostContent")});
				}
				
				// 프로젝트 결재자 조회
				for (int i = 1; i <= 5; i++)
				{
					sql = "SELECT mp.PJTNo, mp.Approval_line" + i + ", mem.name, mem.rank FROM MA_Project mp, members mem WHERE mp.PJTNo = " + PJTNo + " AND mp.Approval_line" + i + " = mem.id";
					pstmt = conn.prepareStatement(sql);
					rs = pstmt.executeQuery();
					
					while (rs.next())
					{
						Approval.add(new String[] {rs.getString("Approval_line" + i), rs.getString("name"), rs.getString("rank")});
					}
				}
				
				// 공통 코드 조회
				String sql2 = "SELECT * FROM CommonCode WHERE PCodeValue = ?";
				PreparedStatement pstmt2 = conn.prepareStatement(sql2);
				pstmt2.setString(1, "PurRequest");
				ResultSet rs2 = pstmt2.executeQuery();
		%>
	</head>
	<body>
		<!-- Wrapper -->
		<div id="wrapper">
	
			<!-- Main -->
			<div id="main" style="background:#F5F5F5">
				<div style="background: white">
					<div class="inner">
	
						<!-- Header -->
						<div id="main">
							<br>
							<div style="height:3px">
								<h1 class="nanum" style="font-size:28px; color:black; margin-left:5%;">프로젝트 비용관리</h1>
							</div>
						</div>
					</div>
					<div>
						<div style="width:74.7%; float:right">
							<ul class="snip1398 ">
								<li class="rowLi">
									<a href="ProjectInfo.jsp?PJNo=<%= PJTNo%>" data-hover="기본정보">
										기본정보
									</a>
								</li>
								<li class="rowLi ">
									<a href="ProjectDocument.jsp?PJNo=<%= PJTNo %>" data-hover="서류관리">
										<span>문서관리</span>
									</a>
								</li>
								<li class="rowLi">
									<a href="ProjectOutput.jsp?PJNo=<%= PJTNo %>" data-hover="산출물관리">
										<span>산출물관리</span>
									</a>
								</li>
								<li class="rowLi">
									<a href="ProjectMember_Add.jsp?PJNo=<%= PJTNo %>" data-hover="인원관리">
										<span>인원관리</span>
									</a>
								</li>
								<li class="current rowLi">
									<a href="ProjectCost.jsp?PJNo=<%= PJTNo %>" data-hover="비용관리">
										<span>비용관리</span>
									</a>
								</li>
							</ul>
						</div>
					</div>
					<br>
					<hr style="border: solid 1px black;">
				</div>

				<div class="row" style="margin: 0% 4% 0% 4%; padding-top:40px; background-color: white; border-radius:10px;">
					<div style="width:100%; margin-top: -1%;">
						<!-- 그리드 -->
						<div style="float:left; padding-left:20px">
							<input type="text" name="query" placeholder="제목을 입력해 주십시오">
						</div>
	
						<div style="float:left; padding-left:20px">
							<input type="text" name="query" id="query" placeholder="작성자를 입력해 주십시오">
						</div>
	
						<div style="float:left; padding-left:20px">
							<input type="button" value="검색">
						</div>

						<!--비용 등록 팝업 -->
						<div style="float: right; padding-right: 2%;">
							<input type="button" id="CostCreatebtn" value="+ 비용 등록">
						</div>
						<form id="PJTCostCreate" name="PJTCostCreate" action="ProjectCost_OK.jsp" method="post" enctype="multipart/form-data">
							<div class="modal fade" id="CostCreate" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
								<div class="modal-dialog" role="document">
									<div class="modal-content">
										<div class="modal-header" style="padding: 1rem 1rem 0 1rem;">
											<h2 class="modal-title" id="exampleModalLabel">
												<label class="nanum">비용 등록</label>
											</h2>
										</div>
										<div class="modal-body">
											<label class="nanum">비용 명</label>
											<input class="nanum" id="CostNm" name="CostNm" type="text" placeholder="제목을 입력해 주십시오">
										</div>
										<div class="modal-body" style="float: left; margin-top: -10px;">
											<div style="float: left; width: 45%">
												<label class="nanum">비용 구분</label>
												<select id="CostGB" name="CostGB" onchange="CostGBChange(this)">
													<option value="0">구매품의서</option>
													<option value="1">지출결의서</option>
												</select>
											</div>
											
											<div style="float: right; width: 45%">
												<label class="nanum">비용 종류</label>
												<select id="CostCd" name="CostCd">
													<%
														while (rs2.next())
														{
															out.println("<option value = '" + rs2.getString("CodeValue") + "'>" + rs2.getString("DisplayValue") + "</option>");
														}
													%>
												</select>
											</div>
										</div>
										<div class="modal-body">
											<label class="nanum">파일&nbsp;&nbsp;&nbsp;&nbsp;<input type="file" id="CostFileNm" name="CostFileNm" class="upload-hidden" onchange="javascript: document.getElementById('CoFileNm').value = document.getElementById('CostFileNm').value.split('\\')[2]"></label>
											<input id="CoFileNm" name="CoFileNm" type="text" hidden="hidden">
										</div>
										<div class="modal-body" style="margin-top: -20px">
											<label class="nanum">가격</label>
											<input id="CostPrice" name="CostPrice" type="text" placeholder="가격을 입력해 주십시오">
										</div>
										<div class="modal-body" style="margin-top: -15px;">
											<label class="nanum">비용 내용</label>
											<textarea id="CostContent" name="CostContent" rows="5" style="resize: none;"> </textarea>
										</div>
										<div class="modal-footer">
											<button id="btnInsert" name="btnInsert" class="btn" style="box-shadow: none" type="button">등록</button>
											<button class="btn" style="box-shadow: none" type="button" data-dismiss="modal">취소</button>
										</div>
									</div>
								</div>
							</div>
						</form>

						<!--비용 정보 팝업-->
							<div class="modal fade" id="CostInfo" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
								<div class="modal-dialog" role="document">
									<div class="modal-content">
										<div class="modal-header" style="padding: 1rem 1rem 0 1rem;">
											<h2 class="modal-title" id="exampleModalLabel">
												<label class="nanum">비용 정보</label>
											</h2>
										</div>
										<div class="modal-body">
											<label class="nanum">비용 명</label>
											<label id="CostNmLabel"></label>
										</div>
										<div class="modal-body" style="float: left; margin-top: -20px;">
											<div style="float: left; width: 45%">
												<label class="nanum">비용 구분</label>
												<label id="CostGBLabel"></label>
											</div>
											
											<div style="float: right; width: 45%">
												<label class="nanum">비용 종류</label>
												<label id="CostCdLabel"></label>
											</div>
										</div>
										<div class="modal-body">
											<label class="nanum">파일&nbsp;&nbsp;&nbsp;&nbsp;<input type="file" id="CostFileNm" name="CostFileNm" class="upload-hidden" onchange="javascript: document.getElementById('CoFileNm').value = document.getElementById('CostFileNm').value.split('\\')[2]"></label>
											<input id="CoFileNm" name="CoFileNm" type="text" hidden="hidden">
										</div>
										<div class="modal-body" style="margin-top: -20px">
											<label class="nanum">가격</label>
											<label id="CostPriceLabel"></label>
										</div>
										<div class="modal-body" style="margin-top: -15px;">
											<label class="nanum">비용 내용</label>
											<label id="CostContentLabel" style="word-break: break-all;"></label>
										</div>
										<div class="modal-body">
											<label class="nanum">결재</label>
											<table>
												<%
													for (int i = 0; i < Approval.size(); i++)
													{
														out.println("<tr>");
														out.println("<td style = 'width: 20%; text-align: center;'>" + Approval.get(i)[2] + "</td>");
														out.println("<td style = 'width: 30%; text-align: center;'>" + Approval.get(i)[1] + "</td>");
														out.println("<td style = 'width: 50%; text-align: center;'></td>");
														out.println("</tr>");
													}
												%>
											</table>
										</div>
										<div class="modal-footer">
<!-- 											<button id="btnInsert" name="btnInsert" class="btn" style="box-shadow: none" type="button">등록</button> -->
											<button class="btn" style="box-shadow: none" type="button" data-dismiss="modal">닫기</button>
										</div>
									</div>
								</div>
							</div>
						
						<div style="padding-top: 25px">
							<colgroup>
								<col style="width:100%">
							</colgroup>
		
							<thead role="rowgroup">
								<tr role="row">
									<th class="k-header" data-field="FILE_NAME" data-index="0" data-title="" id="06997ae4-69df-4f5f-a11c-4ca8c18366d8" scope="col"><br/></th>
								</tr>
							</thead>
						</div>
						<section style="margin-right: 20px">
							<table>
								<colgroup>
									<col style="width:30px" />
									<col style="width:25%" />
									<col style="width:100px" />
									<col style="width:100px" />
									<col style="width:100px" />
									<col style="width:100px" />
								</colgroup>
								<thead>
									<tr>
										<th data-field="PROJ_NAME" data-index="0" data-title="" id="28b4920c-f59e-4d15-aa06-3630ad36d243" scope="col">
											<span>&nbsp;</span>
										</th>
										<th data-field="CostNm" data-index="1" data-title="산출물 명" id="838d690c-5b5f-419a-99a9-1a8fbbfbb015" scope="col">
											<span>비용 명</span>
										</th>
										<th data-field="InsertDt" data-index="2" data-title="등록 일자" id="399f3c50-afda-4c52-85d9-e7c527ce14ce" scope="col">
											<span>비용 구분</span>
										</th>
										<th data-field="InsertNm" data-index="3" data-title="등록자" id="61a94629-97a3-4c89-949c-0e5815cfb721" scope="col">
											<span>결재 상태</span>
										</th>
										<th data-field="UpdateDt" data-index="4" data-title="수정 일자" id="bce59831-42b4-44ec-9399-adae8ddcdd5f" scope="col">
											<span>등록 일자</span>
										</th>
										<th data-field="UpdateNm" data-index="5" data-title="수정자" id="c9ba7385-2956-46e8-a4f8-eaec4dbd5c90" scope="col">
											<span>등록자</span>
										</th>
									</tr>
								</thead>
								<tbody>		
									<% 
											int rs_Count = 0; 
											for (int i = 0; i < CostInfo.size(); i++)
											{
												out.println("<tr>");
												out.println("<td>" + "<span>" + "&nbsp" + "</span>" + "</td>");
												out.println("<td><a class = 'btn' id = '" + CostInfo.get(i)[0] + "' name = '" + CostInfo.get(i)[0] + "' onclick = 'CostInfo(this)' style = 'margin-left: -5%;'><span>" + CostInfo.get(i)[1] + "</span></a></td>");
												out.println("<td id = '" + CostInfo.get(i)[0] + "GB" + "'>" + CostInfo.get(i)[6] + "</td>");
												out.println("<td id = '" + CostInfo.get(i)[0] + "Cd" + "' hidden = 'hidden'>" + CostInfo.get(i)[2] + "</td>");
												out.println("<td>" + CostInfo.get(i)[3] + "</td>");
												out.println("<td>" + CostInfo.get(i)[4] + "</td>");
												out.println("<td>" + CostInfo.get(i)[5] + "</td>");
												out.println("<td id = '" + CostInfo.get(i)[0] + "Content" + "' hidden = 'hidden'>" + CostInfo.get(i)[7] + "</td>");
												out.println("</tr>");
												rs_Count++;
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
									%>
								</tbody>
							</table>
						</section>					
					</div>
				</div>
			</div>
			
			<!--Sidebar -->
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
		<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
		<script src="js/bootstrap.min.js"></script>
		<script type="text/javascript">
			$('#CostCreatebtn').click(function() {
				$('#CostNm').val("");
				$('#CostPrice').val("");
				$('#CostContent').val("");
				$('#CostFileNm').val("");
				$('#CoFileNm').val("");
				$('#CostCreate').modal({
					backdrop : 'static',
					keyboard : false
				});
			});
			
			$('#btnInsert').click(function() {
				if ($('#CostNm').val() == "")
				{
					alert('제목을 입력해 주십시오.');
					return;
				}
				if ($('#CoFileNm').val() == "")
				{
					alert('파일을 등록해 주십시오.');
					return;
				}
				if ($('#CostPrice').val() == "")
				{
					alert('가격을 입력해 주십시오.');
					return;
				}
				$('#PJTCostCreate').submit();
			})
			
			function CostGBChange(obj)
			{
				$('#CostCd').empty();
				<%
				%>
				if ($('#CostGB').val() == "0")
				{
					<%
						ArrayList<String[]> CostCd = new ArrayList<String[]>();
						Connection conn = MySQLConnect.getMySQLConnection();
						String sql = "SELECT * FROM CommonCode WHERE PCodeValue = ?";
						PreparedStatement pstmt = conn.prepareStatement(sql);
						pstmt.setString(1, "PurRequest");
						ResultSet rs = pstmt.executeQuery();
						
						while (rs.next())
						{
							CostCd.add(new String[] {rs.getString("CodeValue"), rs.getString("DisplayValue")});
						}
						
						for (int i = 0; i < CostCd.size(); i++)
						{
							out.println("$('#CostCd').append(" + '"' + "<option value = '" + CostCd.get(i)[0] + "'>" + CostCd.get(i)[1] + "</option>" + '"' + ")");
						}
					%>
				}
				else if ($('#CostGB').val() == "1")
				{
				<%
					CostCd = new ArrayList<String[]>();
					conn = MySQLConnect.getMySQLConnection();
					sql = "SELECT * FROM CommonCode WHERE PCodeValue = ?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, "SpenResolution");
					rs = pstmt.executeQuery();
					
					while (rs.next())
					{
						CostCd.add(new String[] {rs.getString("CodeValue"), rs.getString("DisplayValue")});
					}
					
					for (int i = 0; i < CostCd.size(); i++)
					{
						out.println("$('#CostCd').append(" + '"' + "<option value = '" + CostCd.get(i)[0] + "'>" + CostCd.get(i)[1] + "</option>" + '"' + ")");
					}
				%>
				}
			}
			
			function CostInfo(obj)
			{
				ClickId = document.getElementById(obj.getAttribute('id')).getAttribute('id');
				$('#CostNmLabel').text(document.getElementById(ClickId).outerText);
				$('#CostGBLabel').text(document.getElementById(ClickId + "GB").outerText);
				$('#CostCdLabel').text(document.getElementById(ClickId + "Cd").outerText);
				$('#CostContentLabel').text(document.getElementById(ClickId + "Content").outerText);
				
				$('#CostInfo').modal({
					backdrop : 'static',
					keyboard : false
				})
			}
		</script>
	</body>
</html>