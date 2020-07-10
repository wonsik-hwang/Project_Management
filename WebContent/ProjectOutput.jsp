<%@page import="sun.text.resources.cldr.ext.FormatData_ceb"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.regex.Pattern"%>
<%@ page import="java.sql.*"%>
<%@ page import="ProjectManagement.MySQLConnect"%>
<!DOCTYPE HTML>
<html>
<head>
<title>(주)하이데이타</title>

<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, user-scalable=no" />
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="CSS/bootstrap.min.css">
<link rel="stylesheet" href="https://i.icomoon.io/public/temp/e5c48413e3/UntitledProject/style.css">
<link rel="stylesheet" href="CSS/main.css" />
<link rel="stylesheet" href="CSS/mouseover3.css" />

<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic" rel="stylesheet">
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
</style>

<%
	request.setCharacterEncoding("UTF-8");
	String PJTNo = request.getParameter("PJTNo");
	String UserId = session.getAttribute("UserId") == null ? "0" : (String)session.getAttribute("UserId");
	System.out.println(UserId);
	PJTNo = "158";

	ArrayList<String> OPCheck = new ArrayList<String>();

	try {
		ArrayList<String[]> Form = new ArrayList<String[]>();
		ArrayList<String[]> FormVer = new ArrayList<String[]>();
		ArrayList<String[]> OPInfo = new ArrayList<String[]>();

		Connection conn = MySQLConnect.getMySQLConnection();

		String sql1 = "SELECT DISTINCT FormGB, FormNo, FormNm  FROM MA_Form";
		String sql2 = "SELECT FormNo, TRUNCATE(FileVer, 1) AS FileVer FROM MA_Form WHERE DeleteYN = FALSE";

		String sql3 = "SELECT mo.PJTNo, mo.FormGB, mo.FormNo, MAX(FileVer) AS FileVer, mo.OPContent, mo.FileNm FROM MA_Output mo WHERE mo.PJTNo = "
		+ PJTNo + " GROUP BY mo.FormNo";

		PreparedStatement pstmt1 = conn.prepareStatement(sql1);
		PreparedStatement pstmt2 = conn.prepareStatement(sql2);
		PreparedStatement pstmt3 = conn.prepareStatement(sql3);

		ResultSet rs1 = pstmt1.executeQuery();
		ResultSet rs2 = pstmt2.executeQuery();
		ResultSet rs3 = pstmt3.executeQuery();

		String FormGB;
		String FormNo;
		String FormNm;
		String FormVersion;
		String OPContent;
		String FileNm;

		while (rs1.next()) {
			FormGB = Integer.toString(rs1.getInt("FormGB"));
			FormNo = Integer.toString(rs1.getInt("FormNo"));
			FormNm = rs1.getString("FormNm");

			Form.add(new String[]{FormGB, FormNo, FormNm});
		}

		while (rs2.next()) {
			FormNo = Integer.toString(rs2.getInt("FormNo"));
			FormVersion = Float.toString(rs2.getFloat("FileVer"));

			FormVer.add(new String[]{FormNo, FormVersion});
		}
		while (rs3.next()) {
			FormGB = Integer.toString(rs3.getInt("FormGB"));
			FormNo = Integer.toString(rs3.getInt("FormNo"));
			OPContent = rs3.getString("OPContent");
			FileNm = rs3.getString("FileNm");

			OPInfo.add(new String[]{FormGB, FormNo, OPContent, FileNm});
		}

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
							<h1 class="nanum" style="font-size: 28px; color: black; margin-left: 5%;">프로젝트 산출물</h1>
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
							<li class="current rowLi"><a
								href="ProjectOutput.jsp?PJTNo=<%=PJTNo%>" data-hover="산출물관리">
									<span>산출물관리</span>
							</a></li>
							<li class="rowLi"><a
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

			<div class="row"
				style="margin-Left: 4%; padding-top: 40px; background-color: white; margin-Right: 5%; border-radius: 10px;">
				<div style="width: 100%;">
					<!--그리드 -->
					<div style="float: left; padding-left: 20px">
						<input type="text" name="query" placeholder="산출물 명을 입력하세요">
					</div>

					<div style="float: left; padding-left: 20px">
						<input type="text" name="query" id="query"
							placeholder="작성자를 입력하세요">
					</div>

					<div style="float: left; padding-left: 20px">
						<input type="button" value="검색">
					</div>

<!-- 					양식 등록 팝업 -->
<!-- 					<div style="float: right; padding-right: 2%;"> -->
<!-- 						<input type="button" id="FormCreatebtn" value="+ 양식 등록"> -->
<!-- 					</div> -->
<!-- 					<form id="PJTFormCreate" name="PJTFormCreate" -->
<!-- 						action="ProjectFormCreate_OK.jsp" method="post" -->
<!-- 						enctype="multipart/form-data"> -->
<!-- 						<div class="modal fade" id="FormCreate" tabindex="-1" -->
<!-- 							role="dialog" aria-labelledby="exampleModalLabel" -->
<!-- 							aria-hidden="true"> -->
<!-- 							<div class="modal-dialog" role="document"> -->
<!-- 								<div class="modal-content"> -->
<!-- 									<div class="modal-header" style="padding: 1rem 1rem 0 1rem;"> -->
<!-- 										<h2 class="modal-title" id="exampleModalLabel"> -->
<!-- 											<label class="nanum">양식 등록</label> -->
<!-- 										</h2> -->
<!-- 									</div> -->
<!-- 									<div class="modal-body"> -->
<!-- 										<label class="nanum">양식 명</label> <label><input -->
<!-- 											id="FormNm" name="FormNm" type="text"></label> -->
<!-- 									</div> -->
<!-- 									<div class="modal-body"> -->
<!-- 										<label class="nanum">양식 파일&nbsp;&nbsp;&nbsp;&nbsp;<input -->
<!-- 											type="file" id="FormFileNm" name="FormFileNm" -->
<!-- 											class="upload-hidden" -->
<!-- 											onchange="javascript: document.getElementById('FileName').value = document.getElementById('FormFileNm').value.split('\\')[2]"></label> -->
<!-- 										<input id="FileName" name="FileName" type="text" -->
<!-- 											hidden="hidden"> -->
<!-- 									</div> -->
<!-- 									<div class="modal-body"> -->
<!-- 										<label class="nanum">양식 내용</label> -->
<!-- 										<textarea id="Remark" name="Remark" rows="5" -->
<!-- 											style="resize: none;"> </textarea> -->
<!-- 									</div> -->
<!-- 									<div class="modal-footer"> -->
<!-- 										<button id="FormInsert" name="FormInsert" class="btn" -->
<!-- 											style="box-shadow: none" type="button" data-dismiss="modal">등록</button> -->
<!-- 										<button class="btn" style="box-shadow: none" type="button" -->
<!-- 											data-dismiss="modal">취소</button> -->
<!-- 									</div> -->
<!-- 								</div> -->
<!-- 							</div> -->
<!-- 						</div> -->
<!-- 					</form> -->

					<!--산출물 등록 팝업 -->
					<div style="float: right; padding-right: 2%;">
						<input type="button" id="OutputCreatebtn" value="+ 산출물 등록">
					</div>
					<form id="PJTOutputCreate" name="PJTOutputCreate"
						action="ProjectOutput_OK.jsp" method="post"
						enctype="multipart/form-data">
						<div class="modal fade" id="OutputCreate" tabindex="-1"
							role="dialog" aria-labelledby="exampleModalLabel"
							aria-hidden="true">
							<div class="modal-dialog" role="document">
								<div class="modal-content">
									<div class="modal-header" style="padding: 1rem 1rem 0 1rem;">
										<h2 class="modal-title" id="exampleModalLabel">
											<label class="nanum">산출물 등록</label>
										</h2>
									</div>
									<div class="modal-body">
										<label class="nanum">산출물</label> <select id="OutputNm"
											name="OutputNm">
											<%
												for (int i = 0; i < Form.size(); i++) {
												out.println("<option value = '" + Form.get(i)[1] + "'>" + Form.get(i)[2] + "</option>");
											}
											%>
										</select>
									</div>
									<div class="modal-body">
										<label class="nanum">파일&nbsp;&nbsp;&nbsp;&nbsp;<input type="file" id="OutputFileNm" name="OutputFileNm" class="upload-hidden" onchange="javascript: document.getElementById('OPFileNm').value = document.getElementById('OutputFileNm').value.split('\\')[2]"></label>
										<input id="OPFileNm" name="OPFileNm" type="text" hidden="hidden">
									</div>
									<div class="modal-body">
										<label class="nanum">산출물 내용</label>
										<textarea id="OPContentInsert" name="OPContentInsert" rows="5"
											style="resize: none;"> </textarea>
									</div>
									<div class="modal-footer">
										<button id="btnInsert" name="btnInsert" class="btn"
											style="box-shadow: none" type="button" data-dismiss="modal">등록</button>
										<button class="btn" style="box-shadow: none" type="button"
											data-dismiss="modal">취소</button>
									</div>
								</div>
							</div>
						</div>
					</form>

					<!--산출물 정보 팝업 -->
					<div class="modal fade" id="OutputInfo" tabindex="-1" role="dialog"
						aria-labelledby="exampleModalLabel" aria-hidden="true">
						<div class="modal-dialog" role="document">
							<div class="modal-content">
								<div class="modal-header" style="padding: 1rem 1rem 0 1rem;">
									<h2 class="modal-title" id="exampleModalLabel">
										<label class="nanum">산출물 정보</label>
									</h2>
								</div>
								<div class="modal-body">
									<label class="nanum">산출물 명</label> &nbsp;&nbsp;<label
										id="OPNmLabel" style="margin-top: -4%"></label>
								</div>
								<div class="modal-body" style="margin-top: -3%">
									<label class="nanum">파일&nbsp;&nbsp;&nbsp;&nbsp;</label> <label
										id="OPFileNmLabel"></label>
								</div>
								<div class="modal-body">
									<label class="nanum" style="margin-top: -3%">산출물 내용</label> <label
										id="OPContent" style="word-break: break-all"></label>
								</div>
								<div class="modal-footer">
									<button id="btnUpdate" name="btnUpdate" class="btn" style="box-shadow: none" type="button" data-dismiss="modal">수정</button>
									<button class="btn" style="box-shadow: none" type="button"
										data-dismiss="modal">취소</button>
								</div>
							</div>
						</div>
					</div>

					<!--산출물 수정 팝업 -->
					<div class="modal fade" id="OutputUpdate" tabindex="-1"
						role="dialog" aria-labelledby="exampleModalLabel"
						aria-hidden="true">
						<div class="modal-dialog" role="document">
							<div class="modal-content">
								<div class="modal-header" style="padding: 1rem 1rem 0 1rem;">
									<h2 class="modal-title" id="exampleModalLabel">
										<label class="nanum">산출물 정보</label>
									</h2>
								</div>
								<div class="modal-body">
									<label class="nanum">산출물 명</label> &nbsp;&nbsp;<label
										id="OPNmUpdate" style="margin-top: -4%"></label>
								</div>
								<div class="modal-body">
									<label class="nanum">파일 등록&nbsp;&nbsp;&nbsp;&nbsp;<input
										type="file" id="OutputFileNm" name="OutputFileNm"
										class="upload-hidden"
										onchange="javascript: document.getElementById('FileName').value = document.getElementById('OutputFileNm').value.split('\\')[2]"></label>
									<input id="FileNameUpdate" name="FileNameUpdate" type="text"
										hidden="hidden">
								</div>
								<div class="modal-body">
									<label class="nanum" style="margin-top: -3%">산출물 내용</label>
									<textarea id="OPContentUpdate" name="OPContentUpdate" rows="5"
										style="resize: none;"> </textarea>
								</div>
								<div class="modal-footer">
									<button id="btnSave" name="btnSave" class="btn"
										style="box-shadow: none" type="button" data-dismiss="modal">저장</button>
									<button class="btn" style="box-shadow: none" type="button"
										data-dismiss="modal">취소</button>
								</div>
							</div>
						</div>
					</div>
					<!-- 						</form> -->

					<div style="padding-top: 25px">
						<colgroup>
							<col style="width: 100%">
						</colgroup>

						<thead role="rowgroup">
							<tr role="row">
								<th class="k-header" data-field="FILE_NAME" data-index="0"
									data-title="" id="06997ae4-69df-4f5f-a11c-4ca8c18366d8"
									scope="col"><br /></th>
							</tr>
						</thead>
					</div>
					<section style="margin-right: 20px">
						<table>
							<colgroup>
								<col style="width: 30px" />
								<col style="width: 60%" />
								<col style="width: 15%" />
								<col style="width: 10%" />
								<col style="width: 10%" />
							</colgroup>
							<thead>
								<tr>
									<th data-field="PROJ_NAME" data-index="0" data-title=""
										id="28b4920c-f59e-4d15-aa06-3630ad36d243" scope="col"><span>
											&nbsp; </span></th>
									<th data-field="OPNm" data-index="1" data-title="산출물 명"
										id="838d690c-5b5f-419a-99a9-1a8fbbfbb015" scope="col"><span>
											산출물 명 </span></th>
									<th data-field="InsertDt" data-index="2" data-title="등록 일자"
										id="399f3c50-afda-4c52-85d9-e7c527ce14ce" scope="col"
										style="text-align: center;"><span> 양식 버전 </span></th>
									<th data-field="InsertNm" data-index="3" data-title="등록자"
										id="61a94629-97a3-4c89-949c-0e5815cfb721" scope="col"
										style="text-align: center;"><span> 양식 파일 </span></th>
									<th data-field="UpdateDt" data-index="4" data-title="수정 일자"
										id="bce59831-42b4-44ec-9399-adae8ddcdd5f" scope="col"
										style="text-align: center;"><span> 파일 다운 </span>
								</tr>
							</thead>
							<tbody>
								<%
									int rs_Count = 0;
									int ContentCheck = 1;
									for (int i = 0; i < Form.size(); i++) {
										out.println("<tr>");
										out.println("<td>" + "<span>" + "&nbsp;" + "</span>" + "</td>");
										out.println("<td><a class = 'btn' id = '" + Form.get(i)[1] + "' name = '" + Form.get(i)[1]
										+ "' onclick = 'OutputInfo(this)' style='margin-left: -5%'><span>" + Form.get(i)[2] + "</span></a></td>");
										out.println("<td><select>");
										for (int j = (FormVer.size() - 1); j >= 0; j--) {
											if (FormVer.get(j)[0].equals(Form.get(i)[1])) {
										out.println("<option value = '" + FormVer.get(j)[0] + "'>" + FormVer.get(j)[1] + "</option>");
											}
										}
										out.println("</select></td>");
										if (ContentCheck - 1 < OPInfo.size()) {
											if (ContentCheck - 1 < OPInfo.size() && Integer.toString(ContentCheck).equals(OPInfo.get(ContentCheck - 1)[1]))
											{
												out.println("<td hidden='hidden'><label id='" + Form.get(i)[1] + "a" + "'>" + OPInfo.get(ContentCheck - 1)[2] + "</label></td>");
												ContentCheck++;
											}
											else
											{
												out.println("<td hidden='hidden'><label id='" + Form.get(i)[1] + "a" + "'>" + "" + "</label></td>");
											}
										}
										else
										{
											out.println("<td hidden='hidden'><label id='" + Form.get(i)[1] + "a" + "'>" + "산출물이 등록되지 않았습니다." + "</label></td>");
											OPCheck.add(Form.get(i)[1]);
										}
										out.println("<td style='text-align: center'>양식</td>");
										out.println("<td style='text-align: center'>파일</td>");
										out.println("</tr>");
										rs_Count += 1;
									}
									if (rs_Count == 0) {
								%>
								<tr>
									<td colspan="9">
										<div
											style="margin: 0 auto; position: static; text-align: center">
											작성된 글이 없습니다.</div>
									</td>
								</tr>
								<%
									}
								} catch (SQLException ex) {
									System.out.println("DB 접속에 실패 하였습니다.");
									System.out.println(ex.getMessage());
									ex.printStackTrace();
								%>
								<tr>
									<td colspan="9">
										<div
											style="margin: 0 auto; position: static; text-align: center">
											작성된 글이 없습니다.</div>
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
		$(function() {
			// 양식 등록 팝업 저장
			$("#FormInsert").click(function() {
				if ($("#FormNm").val() == "") {
					alert('산출물 명이 기입되지 않았습니다.');
					return;
				}
				$.ajax({
					url : "./ProjectOutput_Check.jsp",
					async : false,
					type : "POST",
					data : {
						FormNm : $("#FormNm").val()
					},// 전송할 데이터					 
					success : function(data) {
						if (data.indexOf("중복") != -1) {
							alert("중복된 산출물 명이 존재합니다.");
						} else {
							$("#PJTFormCreate").submit();
						}
					}// 요청 완료 시
				});
			})

			// 산출물 등록 저장
			$('#btnInsert').click(function() {
				$('#PJTOutputCreate').submit();
			})

			// 산출물 수정 저장 버튼
			$('#btnSave').click(function() {
				$.ajax({
					url : "./ProjectOutput_Modify.jsp",
					async : false,
					type : "POST",
					data : {
						PJTNo : <%=PJTNo%>,
						ClickId : ClickId,
						OPContent : $('#OPContentUpdate').val(),
						FileNm : $('#FileNameUpdate').val()
					},// 전송할 데이터					 
					success : function(data) {
						alert("산출물이 저장되었습니다.");
						location.href = "ProjectOutput.jsp?PJTNo=" + <%=PJTNo%>;
					}// 요청 완료 시
				});
			})
		})
	</script>
	<script>
		// 양식 등록 팝업
		$('#FormCreatebtn').click(function(e) {
			e.preventDefault();
			$('#FormCreate').modal({
				backdrop : 'static',
				keyboard : false
			});
		});

		// 산출물 등록 팝업
		$('#OutputCreatebtn').click(function() {
			$('#OutputCreate').modal({
				backdrop : 'static',
				keyboard : false
			});
		})

		// 산출물 수정 팝업 띄우기
		$('#btnUpdate').click(function() {
			$('#OutputInfo').modal("hide").on('hidden.bs.modal', function(e) {
				$('#OutputUpdate').modal({
					backdrop : 'static',
					keyboard : false
				});
				$(this).off('hidden.bs.modal');
			})
		})

		// 산출물 정보 조회
		var ClickId;

		function OutputInfo(obj) {
			ClickId = document.getElementById(obj.getAttribute('id')).getAttribute('id');
			$('#OPContent').text(document.getElementById(ClickId + "a").outerText);
			$('#OPNmLabel').text($(obj).text());

			$('#OPContentUpdate').val(document.getElementById(ClickId + "a").outerText);
			$('#OPNmUpdate').text(document.getElementById(obj.id).outerText);
			$('#OutputInfo').modal({
				backdrop : 'static',
				keyboard : false
			});
		}

		function GoSave() {
			if (document.getElementById("ex_filename").value == null
					|| document.getElementById("ex_filename").value == "") {
				alert("파일이 등록되지 않았습니다.");
			} else {
				document.PJTFormCreate.submit();
			}
		}
	</script>
</body>
</html>