<%@page import="com.sun.xml.internal.txw2.Document"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.regex.Pattern" %>
<%@page import="java.sql.*"%>   

<!DOCTYPE HTML>
<html lang="en">

<head>
	<title>(주)하이데이타</title>

    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    
    
    <script src="js/jquery.min.js"></script>
	<script src="js/browser.min.js"></script>
	<script src="js/breakpoints.min.js"></script>
	<script src="js/util.js"></script>
	<script src="js/main.js"></script>
	

    <!-- Bootstrap CSS -->
 	<link rel="stylesheet" href="CSS/bootstrap.min.css">
	<link rel="stylesheet" href="https://i.icomoon.io/public/temp/e5c48413e3/UntitledProject/style.css">
	<link rel="stylesheet" href="CSS/main.css" />
	<link rel="stylesheet" href="CSS/mouseover3.css" />
   
	
	<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic" rel="stylesheet">
	
	
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
			height: 40px;
/* 			line-height: 10px; */
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
					<div style="height:3px">
						<br />
						<h1 class="nanum" style="font-size:28px; color:black; margin-left:5%;">프로젝트 서류관리</h1>
					</div>
					<div>
						<br />
					</div>
				</div>
			</div>
			<div>
				<div style="width:74.7%; float:right">
					<ul class="snip1398">
						<li class="rowLi">
								<a href="ProjectInfo.jsp" data-hover="기본정보">
								기본정보
							</a>
						</li>
						<li class="current rowLi ">
							<a href="ProjectDocument.jsp" data-hover="서류관리">
								<span>서류관리</span>
							</a>
						</li>
						<li class="rowLi">
							<a href="ProjectOutput.jsp" data-hover="산출물관리">
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
			<div class="row" style="margin-Left:5%; padding-top:50px; background-color: white; margin-Right:5%; border-radius: 10px">

				<div style="width:100%;">
					<!-- 그리드 -->
					<div style="float:left; padding-Left:50px"> <!-- 조회창 간격 -->
						<select name="project" >
							<option>프로젝트를 선택하세요</option>
						</select>
					</div>

					<div style="float:left; padding-left:20px">
						<input type="text" name="query" placeholder="서류명을 입력하세요">
					</div>

					<div style="float:left; padding-left:20px">
						<input type="text" name="query" id="query" placeholder="작성자를 입력하세요">
					</div>

					<div style="float:left; padding-left:20px">
						<input type="button" value="검색">
					</div>

					<!-- 파일 등록 버튼 -->
<!-- 					<div style="float:right; padding-right:10%;"> -->
<!-- 						<a id="btn" href="#layer2" class="btn-example"> -->
<!-- 							<input type="button" value="+ 파일 등록"> -->
<!-- 						</a> -->
<!-- 					</div> -->
				
<!-- 					<div class="dim-layer"> -->
<!-- 							<div class="dimBg"></div> -->
<!-- 							<div id="layer2" class="pop-layer"> -->
<!-- 								<div class="pop-container"> -->
<!-- 									<div class="pop-conts"> -->
<!-- 										content  -->
<!-- 										<form name = "sub1" id ="sub1" action="Document_Save.jsp" method="post" enctype="multipart/form-data" onSubmit="return false;"> -->
<!-- 										<p> -->
<!-- 										<div> -->
<!-- 											<label class="nanum" style="margin-top: -15px">파일 등록</label> -->
<!-- 											<hr style="border: solid 1px black; margin-top: 5px"> -->
<!-- 											<font class="nanum" style=""> -->
<!-- 												<label class="nanum" style="margin-top: -10px"><b>서류 명</b></label> -->
<!-- 												<input type = "text"  id="DocNm" name ="DocNm" style="margin-top: 15px"> -->
<!-- 												<br /> -->
<!-- 												<div> -->
<!-- 													<label class="nanum">파일 업로드&nbsp;&nbsp;&nbsp;&nbsp; <input type="file" id="ex_filename" name="ex_filename"class="upload-hidden"> </label> -->
<!-- 												</div> -->
<!-- 												<b>서류 내용</b> -->
<!-- 												<br /> -->
<!-- 												<br /> -->
<!-- 												<textarea rows="5"  style = "resize:none;" id="DocContent" name="DocContent"> </textarea> -->
<!-- 											</font> -->
<!-- 										</div> -->
<!-- 										</p> -->
<!-- 										<div type="button" style="float:right;"> -->
<!-- 											<button onclick='document.sub1.submit();'>등록</button> -->
<!-- 											<a href="#" class="btn-layerClose" >닫기</a> -->
<!-- 											<br /> -->
<!-- 											<br /> -->
<!-- 										</div> -->
<!-- 										</form> -->
<!-- 									</div> -->
<!-- 								</div> -->
<!-- 							</div> -->
<!-- 						</div> -->
						
						
   						<!--파일등록 팝업 -->
						<div style="float:right; padding-right:5%;">
						<input type="button" id="layer3" value="+파일 등록" > </div>
					
					
						<div class="modal fade" id="testModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
							<div class="modal-dialog" role="document">
								<div class="modal-content">
									<div class="modal-header" style="padding:1rem 1rem 0 1rem;">
									<h2 class="modal-title" id="exampleModalLabel"><label class="nanum" >파일 등록</label></h2>
<!-- 										<h5 class="modal-title" id="exampleModalLabel">서류 정보</h5> -->
<!-- 										<button class="close" type="button" data-dismiss="modal" aria-label="Close"> -->
<!-- 											<span aria-hidden="true">X</span> -->
<!-- 										</button> -->
									</div>
									<div class="modal-body"><label class="nanum">서류 명</label>
										<label><input type = "text" value="dasdasdasdasd"></label>
										</div>
										<div class="modal-body">
										<label class="nanum">파일 명 <input type="file" id="ex_filename" name="ex_filename"class="upload-hidden"> </label>
										</div>
										<div class="modal-body"><label class="nanum">파일 내용</label>
										<textarea rows="5"  style = "resize:none;" id="DocContent" name="DocContent"> </textarea>
									</div>
									<div class="modal-footer">
<!--  										<a class="btn" id="modalY" href="#">예</a> -->
										<button class="btn" style="box-shadow: none" type="button" data-dismiss="modal">등록</button>
										<button class="btn" style="box-shadow: none" type="button" data-dismiss="modal">취소</button>
									</div>
								</div>
							</div>
						</div>
	
						
						
						
						
<!-- 						<div>					   -->
<!-- 					  <a class = 'btn' id='myeong'><span>안녕디지몬</span></a> -->
<!-- 						</div> -->
						<!--서류 정보 팝업 -->
						<div class="modal fade" id="FileInfo" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
							<div class="modal-dialog" role="document">
								<div class="modal-content">
									<div class="modal-header" style="padding:1rem 1rem 0 1rem;">
									<h2 class="modal-title" id="exampleModalLabel"><label class="nanum" >서류 정보</label></h2>
									</div>
									<div class="modal-body"><label class="nanum">서류 명</label>
										<label><input type = "text" value="dasdasdasdasd"></label>
										</div>
										<div class="modal-body">
										<label class="nanum">파일 명 <input type="file" id="ex_filename" name="ex_filename"class="upload-hidden"> </label>
										</div>
										<div class="modal-body"><label class="nanum">파일 내용</label>
										<textarea rows="5"  style = "resize:none;" id="DocContent" name="DocContent"> </textarea>
									</div>
									<div class="modal-footer">
 										<a class="btn" id="modalY" href="#">예</a>
										<button class="btn" style="box-shadow: none" type="button" data-dismiss="modal">등록</button>
										<button class="btn" style="box-shadow: none" type="button" data-dismiss="modal">취소</button>
									</div>
								</div>
							</div>
						</div>
						
						
						
						
						
						
					

				<!-- Section -->
				<section>
					<div id="grid" style="margin-Left:5%; padding-top:115px; background-color: white; margin-Right:5%">
						<table>
							<colgroup>
								<col style="width:7%" />
								<col style="width:36%" />
								<col style="width:20%" />
								<col style="width:20%" />
								<col style="width:10%" />
								<col style="width:7%" />
							</colgroup>
							<thead>
								<tr>
									<th data-field="PROJ_NAME" data-index="0" data-title="" id="28b4920c-f59e-4d15-aa06-3630ad36d243" scope="col">
										<span> &nbsp; </span>
									</th>
									<th data-field="PROJ_NAME" data-index="1" data-title="프로젝트" id="838d690c-5b5f-419a-99a9-1a8fbbfbb015" scope="col">
										<span> &nbsp;&nbsp;파일 명 </span>
									</th>
									<th data-field="PROJ_PM" data-index="2" data-title="PM" id="399f3c50-afda-4c52-85d9-e7c527ce14ce" scope="col">
										<span> 작성자 </span>
									</th>
									<th data-field="PROJ_STATE" data-index="3" data-title="진행 상황" id="61a94629-97a3-4c89-949c-0e5815cfb721" scope="col">
										<span> 등록일자 </span>
									</th>
									<th style="text-align: center" scope="col"  data-index="5"  data-title="파일 명">
										<span> 저 장 </span>
									</th>	
									<th>
									<span> &nbsp; </span>
									</th>	
								</tr>
							</thead>
							<tbody>	

<%
try{ 
	request.setCharacterEncoding("UTF-8");
	String dbURL="jdbc:mysql://192.168.0.71:3306/ProjectManagement?useUnicode=true&characterEncoding=UTF-8"; 
	String dbID="hidata"; 
	String dbPassword="hidata2312357!";
	
	Class.forName("com.mysql.jdbc.Driver");
	System.out.println("드라이버 로드를 완료 하였습니다.");
	
	ResultSet rs = null;
	Connection conn=DriverManager.getConnection(dbURL, dbID, dbPassword);
	System.out.println("MySQL 데이터베이스 db에 성공적으로 접속했습니다. ");
								   
	Statement stmt = conn.createStatement();
	String sql = "SELECT * FROM MA_Document ORDER BY DocNo DESC";
	rs = stmt.executeQuery(sql);
	
	int rs_Count = 0; 
	while(rs.next()){
		out.print("<tr>");
		out.print("<td>" + "<span>" + "" + "</span>" + "</td>");
		out.print("<td> <a class = 'btn' id='" + rs.getString("DocNo") + "' onclick='FileOpen(this)'> <span>" + rs.getString("DocNm") + "</span>" + " </a></td>");
		out.print("<td> <span>" + rs.getString("DocDt") + "</span>" + "</td>");
		out.print("<td>" + "<span>" + rs.getString("DocUser") + "</span>" + "</td>");
		out.print("<td style='text-align: center'>" + "<a href = " + "'FileDownload.jsp?DocFileNm=" + rs.getString("DocFileNm") + "' class='icon-floppy-disk'>" + "</a></td>");
		out.print("<td>" + "<span>" + "" + "</span>" + "</td>");
		out.print("</tr>");
		rs_Count += 1;
	} 
	
	if(rs_Count == 0)
	{%>
							<tr>
							<td colspan="6">
								<div style="margin:0 auto;position:static;text-align:center">
							저장된 데이터가 없습니다.
									</div>
								</td>
							</tr>
							<%
	}	
}
catch(Exception ex) {
		System.out.println(ex);		%>
		<tr>
		<td colspan="6">
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
	</div>
	</section>
				</div>
				<div style="padding-bottom: 25px">
				</div>
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
<!-- 						<li class="nanum"><a href="project_user.html">사용자 관리</a></li> -->
					</ul>
				</nav>
			</div>
		</div>
	</div>									
						
	<!-- Scripts -->
<!-- integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous" -->
<!--  integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous" -->
<!--      integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI" crossorigin="anonymous" -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" ></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
    <script src="js/bootstrap.min.js"></script>

	<script>
	function openPopUp(){

		var options = 'width=500, height=600, top=30, left=30, resizable=no, scrollbars=no, location=no';

		window.open('http://www.naver.com', 'test', options);

		}
	</script>
	
	<script>
		$('#layer3').click(function(e){
			e.preventDefault();
			$('#testModal').modal("show");
		});
		
		
		
		function FileOpen (obj) {
			alert(obj.id);
// 			var getId=$(this).attr("id"); 너꺼져
			e.preventDefault();
			
			$('#FileInfo').modal("show");
		
		}
	</script>

</body>
</html>