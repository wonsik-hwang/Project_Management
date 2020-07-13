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
				Connection conn = MySQLConnect.getMySQLConnection();
				
				String PJTNo = request.getParameter("PJTNo");
				String sql = "SELECT * FROM MA_Cost WHERE PJTNo = " + PJTNo + " ORDER BY CostNo DESC";
				PreparedStatement pstmt = conn.prepareStatement(sql);
				ResultSet rs = pstmt.executeQuery();
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
										<div class="modal-body" style="margin-top: -10px;">
											<label class="nanum">비용 구분</label> <select id="CostGB" name="CostGB">
												<option value="0">구매품의서</option>
												<option value="1">지출결의서</option>
											</select>
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
											<span>
												&nbsp;
											</span>
										</th>
										<th data-field="CostNm" data-index="1" data-title="산출물 명" id="838d690c-5b5f-419a-99a9-1a8fbbfbb015" scope="col">
											<span>
												비용 명
											</span>
										</th>
										<th data-field="InsertDt" data-index="2" data-title="등록 일자" id="399f3c50-afda-4c52-85d9-e7c527ce14ce" scope="col">
											<span>
												등록 일자
											</span>
										</th>
										<th data-field="InsertNm" data-index="3" data-title="등록자" id="61a94629-97a3-4c89-949c-0e5815cfb721" scope="col">
											<span>
											 등록자
											</span>
										</th>
										<th data-field="UpdateDt" data-index="4" data-title="수정 일자" id="bce59831-42b4-44ec-9399-adae8ddcdd5f" scope="col">
											<span>
												수정 일자
											</span>
										</th>
										<th data-field="UpdateNm" data-index="5" data-title="수정자" id="c9ba7385-2956-46e8-a4f8-eaec4dbd5c90" scope="col">
											<span>
												수정자
											</span>
										</th>
									</tr>
								</thead>
								<tbody>		
									<% 
											int rs_Count = 0; 
											while(rs.next()){
												out.print("<tr>");
												out.print("<td>" + "<span>" + "&nbsp" + "</span>" + "</td>");
												out.print("<td>  <a href='ProjectInfo.jsp?PJNo="+ rs.getString("OPNo") +"'>" + "<span>" + rs.getString("OPNm") + "</span>" + " </a></td>");
												out.print("<td>" + "<span>" + rs.getDate("InsertDt") + "</span>" + "</td>");
												out.print("<td>" + "<span>" + rs.getString("InsertNm") + "</span>" + "</td>");
												out.print("<td>" + "<span>" + rs.getDate("UpdateDt") + "</span>" + "</td>");
												out.print("<td>" + "<span>" + rs.getString("UpdateNm") +"</span>" +  "</td>");
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
				$('#PJTCostCreate').submit();
			})
		</script>
	</body>
</html>