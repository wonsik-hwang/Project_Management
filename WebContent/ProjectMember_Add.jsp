<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="ProjectManagement.MySQLConnect"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.*,java.text.*"%>
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
		<link rel="stylesheet" type="text/css" href="CSS/multi-select.css">
		<link rel="stylesheet" type="text/css" href="CSS/option_height.css">
	
		<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic" rel="stylesheet">
		<script src="https://code.jquery.com/jquery-3.5.1.js" integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU=" crossorigin="anonymous"></script>
	
	<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core"%>
	<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
	
	<%
	    request.setCharacterEncoding("UTF-8");
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
		Connection conn = MySQLConnect.getMySQLConnection();
		
		String PJNo = request.getParameter("PJNo");
	    String sql = "SELECT * FROM MA_Person WHERE PJNo=" + PJNo  + " ORDER BY UserId DESC";
	
	    PreparedStatement pstmt = conn.prepareStatement(sql);
	    ResultSet rs = pstmt.executeQuery();
	   
		String sql1 = "SELECT * FROM members mem WHERE mem.member_num NOT IN (	SELECT mem.member_num FROM members mem, MA_Person mp WHERE mem.member_num = mp.UserId ORDER BY mem.member_num ASC) ORDER BY mem.member_num ASC";
	    String sql2 = "SELECT * FROM members mem, MA_Person mp WHERE mem.member_num = mp.UserId ORDER BY mem.member_num";
		PreparedStatement pstmt1 = conn.prepareStatement(sql1);
		PreparedStatement pstmt2 = conn.prepareStatement(sql2);
		ResultSet rs1 = pstmt1.executeQuery();
		ResultSet rs2 = pstmt2.executeQuery();
	    
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
								<h1 class="nanum"; style="font-size:28px; color:black; margin-left:5%;">프로젝트 정보</h1>
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
					</div>
				</div>
					<Section>
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
							<div>
								<select multiple="multiple" id="Selection" name="Selection" size="10">
									<%
									while (rs1.next())
									{
										out.println("<option value='" + rs1.getString("member_num") + "'>" + rs1.getString("name") + "</option>");
									}
									while (rs2.next())
									{
										out.println("<option value='" + rs2.getString("member_num") + "' selected>" + rs2.getString("name") + "</option>");
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
			<!-- 					<input type="reset" value="취소"  onclick="location.href = 'ProjectMember_Add.jsp'"> -->
			<!-- 		            <input class="btn btn-primary" type="button" value="저장" onclick="infoConfirm()" style="float: left"> -->
			<!-- 		            <input class="btn btn-primary" type="reset" value="취소" onclick="location.href = 'ProjectMember_Add.jsp'" style="float: left"> -->
					        </div>
						</div>
						<%
								}
							
							catch(SQLException ex) {
								System.out.println("DB 접속에 실패 하였습니다.");
								System.out.println(ex.getMessage());
								ex.printStackTrace();
							}
				// 			finally {}
						%>
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
	<script type="text/javascript" src="js/jquery.quicksearch.js"></script>
	<script type="text/javascript">
		$('#Selection').multiSelect({
			selectableHeader: "<div class = 'custom-header'>참여 시킬 멤버를 선택해 주십시오.</div>" + "<input type='text' class='search-input' autocomplete='off' placeholder='이름을 입력해 주십시오'>",
			selectionHeader: "<div class = 'custom-header'>제외 시킬 멤버를 선택해 주십시오.</div>" + "<input type='text' class='search-input' autocomplete='off' placeholder='이름을 입력해 주십시오'>",
			afterInit: function(ms){
			    var that = this,
			        $selectableSearch = that.$selectableUl.prev(),
			        $selectionSearch = that.$selectionUl.prev(),
			        selectableSearchString = '#'+that.$container.attr('id')+' .ms-elem-selectable:not(.ms-selected)',
			        selectionSearchString = '#'+that.$container.attr('id')+' .ms-elem-selection.ms-selected';

			    that.qs1 = $selectableSearch.quicksearch(selectableSearchString)
			    .on('keydown', function(e){
			      if (e.which === 40){
			        that.$selectableUl.focus();
			        return false;
			      }
			    });
			    that.qs2 = $selectionSearch.quicksearch(selectionSearchString)
			    .on('keydown', function(e){
			      if (e.which == 40){
			        that.$selectionUl.focus();
			        return false;
			      }
			    });
			  },
			  afterSelect: function(values){
			    this.qs1.cache();
			    this.qs2.cache();
			  },
			  afterDeselect: function(values){
			    this.qs1.cache();
			    this.qs2.cache();
			  }
			});
		</script>
		<script type="text/javascript" >
		$(function () {
			$("#btnSave").click(function () {
				alert( $('#Selection').val() );
				jQuery.ajaxSettings.traditional = true;
				$.ajax({
				    url:"./ProjectMemberAdd_OK.jsp",
				    async:false,
				    dataType: "json",
				    type:"POST",
				    data: { SelectMember: $('#Selection').val() }, // 전송할 데이터					 
				    success:function(data) {
				    	alert('저장이 완료되었습니다.');
				    }// 요청 완료 시
				});
			});
		})
		</script>
	</body>
</html>