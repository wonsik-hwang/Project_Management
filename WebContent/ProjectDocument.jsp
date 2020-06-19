<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>
<!DOCTYPE HTML>
<html>

<head>
	<title>(주)하이데이타</title>

	<meta charset="UTF-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
	<link rel="stylesheet" href="CSS/main.css" />
	<link rel="stylesheet" href="CSS/mouseover3.css" />

	<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic" rel="stylesheet">
	<script src="https://code.jquery.com/jquery-3.5.1.js" integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU=" crossorigin="anonymous">
	</script>

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
			line-height: 50px;
			text-align: center;
			width: auto;
			padding-left: 5%;
			padding-right: 5%;
			min-width: 80px;
			font-size: 1.2em
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
						<a1 class="nanum"; style="font-size:28px; color:black; margin-left:5%;">프로젝트 서류관리</a1>
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
						<li class="rowLi ">
							<a href="ProjectDocument1.jsp" data-hover="서류관리">
								<span>서류관리</span>
							</a>
						</li>
						<li class="rowLi">
							<a href="ProjectOutput1.jsp" data-hover="산출물관리">
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
					<div style="float:left">
						<select name="project">
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
					<div style="float:right; padding-right:10%;">
						<a href="#layer2" class="btn-example">
							<input type="button" value="+ 파일 등록">
						</a>
						<div class="dim-layer">
							<div class="dimBg"></div>
							<div id="layer2" class="pop-layer">
								<div class="pop-container">
									<div class="pop-conts">
										<!--content //-->
										<p><label class=nanum for="ex_filename">파일 업로드</label>
											<input type="file" id="ex_filename" class="upload-hidden"><br>
										<div>
											<font class=nanum style="">
												<b>프로젝트</b>
												<br />
												<br />
												<select>
													<option value="">프로젝트를 선택하세요</option>
													<!-- 옵션 추가 필요하면 할것 -->
												</select>
												<br />
												<b>파일 설명</b>
												<br />
												<br />
												<textarea rows="5"  style = "resize:none;"> </textarea>
											</font>
										</div>
										</p>
										<div type="button" style="float:right;">
											<a href="#" class="btn-layerOpen">등록</a>

											<a href="#" class="btn-layerClose">닫기</a>
											<br />
											<br />
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
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
	<script src="js/jquery.min.js"></script>
	<script src="js/browser.min.js"></script>
	<script src="js/breakpoints.min.js"></script>
	<script src="js/util.js"></script>
	<script src="js/main.js"></script>

</body>
</html>