<%-- 
	파일명 : header.jsp
	파일내용 : 공통 헤더 페이지
	작성자 : 민우식
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String rank = (String) session.getAttribute("rank");
	String position = (String) session.getAttribute("position");

	if (session.getAttribute("ValidMem") == null) {
%>
<jsp:forward page="/pages/session_error.jsp" />
<%
	}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">
<title>(주)하이데이타</title>
<!-- datepicker -->
 <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="/vendor/bootstrap/js/bootstrap.min.js"></script>

<!-- Metis Menu Plugin JavaScript -->
<script src="/vendor/metisMenu/metisMenu.min.js"></script>

<!-- DataTables JavaScript -->
<script src="/vendor/datatables/js/jquery.dataTables.min.js"></script>
<script src="/vendor/datatables-plugins/dataTables.bootstrap.min.js"></script>
<script src="/vendor/datatables-responsive/dataTables.responsive.js"></script>

<!-- Custom Theme JavaScript -->
<script src="/dist/js/sb-admin-2.js"></script>

<script type="text/javascript">
$(document).ready(function(){
	// datepicker 기본 설정
	$.datepicker.setDefaults({
	    dateFormat: 'yymmdd',
	    prevText: '이전 달',
	    nextText: '다음 달',
	    monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
	    monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
	    dayNames: ['일', '월', '화', '수', '목', '금', '토'],
	    dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
	    dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
	    showMonthAfterYear: true,
	    changeMonth: true,
	    changeYear: true,
	    yearSuffix: '년',
	    ignoreReadonly: true,
	    beforeShow: function(input, inst) {
	  	  var i_offset = $(input).offset(); 
	  	  setTimeout(function(){ 
	  		  $("#ui-datepicker-div").css
	  		  ({'top': i_offset.top + 33}) /* 'left' : i_offset.left */
	  	  })
	  		  
	    }

	});

	// 달력 적용
	$(".date-picker").datepicker({});
	$(".date-picker").attr("readonly",true);
	
	
	
	
	// 숫자만 입력
	$(".number").on("focus", function() {
	    var x = $(this).val();
	    x = removeCommas(x);
	    $(this).val(x);
	}).on("focusout", function() {
	    var x = $(this).val();
	    if(x && x.length > 0) {
	        if(!$.isNumeric(x)) {
	            x = x.replace(/[^0-9]/g,"");
	        }
	        x = addCommas(x);
	        $(this).val(x);
	    }
	}).keydown(function() {
	    $(this).val($(this).val().replace(/[^0-9]/g,""));
	});
	
	//3자리 단위마다 콤마 생성
	function addCommas(x) {
	    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}
	 
	//모든 콤마 제거
	function removeCommas(x) {
	    if(!x || x.length == 0) return "";
	    else return x.split(",").join("");
	}

});


</script>

<!-- Bootstrap Core CSS -->
<link href="/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<link href="/vendor/bootstrap/css/fontweightnormal.css" rel="stylesheet">
<!-- MetisMenu CSS -->
<link href="/vendor/metisMenu/metisMenu.min.css" rel="stylesheet">
<!-- Custom CSS -->
<link href="/dist/css/sb-admin-2.css" rel="stylesheet">
<!-- Morris Charts CSS -->
<link href="/vendor/morrisjs/morris.css" rel="stylesheet">
<!-- Custom Fonts -->
<link href="/vendor/font-awesome/css/font-awesome.min.css"
	rel="stylesheet" type="text/css">
<!--  MobileLayout -->
<link href="/pages/MobileLayout.css" rel="stylesheet">
<!--  Custom Layout CSS -->
<link href="/pages/css/common.css" rel="stylesheet">

<style>
.navbar-default .navbar-brand{
color:#337ab7;
}
.navbar-brand{
float:none;
font-size:24px;
line-height:50px;
}
.page-header{
	text-align:center;
	color:#337ab7;
}
table thead tr th{text-align:center;}
table tbody tr td,
table tbody tr th{text-align:center;}
</style>
</head>
<body>
	<div id="wrapper">
		<!-- Navigation -->

		<!-- Navigation -->
		<nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse"
					data-target=".navbar-collapse">
					<span class="sr-only">Toggle navigation</span> <span
						style="float: right"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span> <span class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="/pages/g_user_main.jsp" style="font-size:22px;">하이데이타 업무 관리 시스템</a>
			</div>

			<div class="navbar-default sidebar" role="navigation">
				<div class="sidebar-nav navbar-collapse collapse" aria-expanded="false" >
					<ul class="nav" id="side-menu">
	
						<li>
							<!--<a href="#"><i class="fa fa-bar-chart-o fa-fw"></i> 업무일지<span class="fa arrow"></span></a>-->
							<a href="#"><i class="fa fa-list fa-fw"></i> 업무일지<span
								class="fa arrow"></span></a>
							<ul class="nav nav-second-level">
								<li><a href="/pages/gsWrite.jsp" class="gsWrite">업무일지 작성</a></li>
						<%
						if(rank.equals("사장") || rank.equals("관리")){
						%>
								<li><a href="/pages/gsCheck_one.jsp" class="gsCheck">결재할 업무일지</a></li>
								
						<%
							}else if(position.equals("3")){ 
						%>
								<li><a href="/pages/gsCheck_pos3.jsp"class="gsCheck">결재할 업무일지</a></li>
								<li><a href="/pages/gsCheck2.jsp" class="gsCheck2">결재 진행중 업무일지</a></li>	
						<%
							} else {
								
						%>
								<li><a href="/pages/gsCheck2.jsp" class="gsCheck2">결재 진행중 업무일지</a></li>	
						<%
							}
						%>
								<li><a href="/pages/gsCheck_ovr.jsp" class="gsCheckOvr">결재 반려 업무일지</a></li>
								<li><a href="/pages/gsCheck_com.jsp" class="gsCheckCom">결재 완료 업무일지</a></li>
								<li><a href="/pages/gsCheck_posAll.jsp" class="gsCheckAll">전체 업무일지</a></li>
							</ul> <!-- /.nav-second-level -->
						</li>
						<%
							if (position.equals("3") || position.equals("1")) {
								String station = "0";
								session.setAttribute("station", station);
						%>
						<li>
							<!--<a href="#"><i class="fa fa-bar-chart-o fa-fw"></i> 업무일지<span class="fa arrow"></span></a>-->
							<a href="#"><i class="fa fa-pencil fa-fw"></i> 프로젝트 관리<span
								class="fa arrow"></span></a>
							<ul class="nav nav-second-level">
								<li><a href="/pages/prjCheck.jsp" class="prjCheck">프로젝트 목록</a></li>
								<li><a href="/pages/prjWrite.jsp" class="prjWrite">프로젝트 작성</a></li>
							</ul> <!-- /.nav-second-level -->
						</li>
						<%
							}
							if (position.equals("1")&&rank.equals("사장")) {
						%>
						<li>
							<!--<a href="#"><i class="fa fa-bar-chart-o fa-fw"></i> 업무일지<span class="fa arrow"></span></a>-->
							<a href="/pages/empCheck.jsp" class="empCheck"><i class="fa fa-user fa-fw"></i> 사원 정보 목록</a>
						</li>
						<%
							}
							if(Integer.parseInt(position) == 1){
						%>
								<li>
									<a href="#"><i class="fa fa-money fa-fw"></i> 사용 경비 관리<span class="fa arrow"></span></a>
									<ul class="nav nav-second-level">
										<li><a href="/pages/expense/list.do" class="expenseList">개인 사용 경비 목록 및 작성</a></li>
										<li><a href="/pages/expense/stat.do" class="expenseStat">전체 사용 경비 목록</a></li>
									</ul>
								</li>
							    <li>
							   <a href="#"><i class="fa fa-calendar"></i>  휴가 관리<span class="fa arrow"></span></a>
							   <ul class="nav nav-second-level">
                                         <li><a href="/pages/attendance/list.do" class="attendanceManagement">휴가 현황</a></li>
                                         <li><a href="/pages/attendance/approvallist.do" class="attendanceManagement"> 휴가 결재</a></li>
                                         <li><a href="/pages/attWrite.jsp" class="attWrite"> 결재자 등록</a></li>
                                         <li><a href="/pages/attCheck.jsp" class="attCheck"> 결재자 목록</a></li>
                                    </ul>
                               </li>
						<%	//2020-05-28 김기훈 추가	
							} if(Integer.parseInt(position) == 3){
								%>
								<li>
									<a href="/pages/expense/list.do" class="expenseList"><i class="fa fa-money fa-fw"></i> 개인 사용 경비 목록 및 작성</a>
								</li>
								<li>
							   <a href="#"><i class="fa fa-calendar"></i>  휴가 관리<span class="fa arrow"></span></a>
							   <ul class="nav nav-second-level">
                                         <li><a href="/pages/attendance/individual.do" class="attendanceManagement"> 휴가 관리</a></li>
                                         <li><a href="/pages/attendance/approvallist.do" class="attendanceManagement"> 휴가 결재</a></li>
                                         <li><a href="/pages/attWrite.jsp" class="attWrite"> 결재자 등록</a></li>
                                         <li><a href="/pages/attCheck.jsp" class="attCheck"> 결재자 목록</a></li>
                                    </ul>
                               </li>
						<%		
							}//2020-05-28 김기훈 추가 끝
							if(Integer.parseInt(position) == 5) {
						%>
								<li>
									<a href="/pages/expense/list.do" class="expenseList"><i class="fa fa-money fa-fw"></i> 개인 사용 경비 목록 및 작성</a>
								</li>
								<li>
                                   <a href="/pages/attendance/individual.do" class="attendanceManagement"><i class="fa fa-calendar"></i> 휴가 관리</a>
                               </li>
						<%		
							}
						%>

                        
						<li>
							<a href="#"><i class="fa fa-newspaper-o fa-fw"></i> 게시판<span class="fa arrow"></span></a>
							<ul class="nav nav-second-level">
								<li><a href="/pages/board/common/List.jsp" class="boardCommon">공용 게시판</a></li>
								<li><a href="/pages/board/notice/List.jsp" class="boardNotice">공지사항</a></li>
							</ul>
						</li>
						<li><a href="/pages/logout.jsp"><i class="fa fa-power-off fa-fw"></i>
								로그아웃</a></li>
						<!--  
	                        <li>
	                            <a href="#"><i class="fa fa-user fa-fw"></i>사용자<span class="fa arrow"></span></a>
	                            <ul class="nav nav-second-level">
	                                <li>
	                                    <a href="#">사용자 정보</a>
	                                </li>
	                                <li>
	                                    <a href="#">로그아웃</a>
	                                </li>
	                            </ul>
	                        </li>
	                     -->
					</ul>
				</div>
	
			</div>
		</nav>
		
		<div id="page-wrapper">
			
		