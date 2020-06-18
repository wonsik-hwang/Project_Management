<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE HTML>
<!--
	Editorial by HTML5 UP
	html5up.net | @ajlkn
	Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
-->


<head>
	<title>(��)���̵���Ÿ</title>

	<meta charset="utf-8" />
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

</head>


<body class="is-preload">
	<!-- Wrapper -->
	<div id="wrapper">

		<!-- Main -->
		<div id="main" style="background:#F5F5F5">
			<div style="background: white">
				<div class="inner">

					<!-- Header -->
					<div id="main">
						<br />
						<div style="height:2px;">
							<a1 class="nanum"; style="font-size:28px; color:black; margin-left:5%;">������Ʈ ����</a1>
						</div>
					</div>
				</div>
					<div>
						<div style="width:74.7%; float:right;">
							<ul class="snip1398">
								<li class="rowLi">
										<a href="ProjectInfo.jsp" data-hover="������Ʈ">
										������Ʈ
									</a>
								</li>
								<li class="rowLi ">
									<a href="ProjectDocument1.jsp" data-hover="��������">
										<span>��������</span>
									</a>
								</li>
								<li class="rowLi">
									<a href="ProjectOutput1.jsp" data-hover="���⹰����">
										<span>���⹰����</span>
									</a>
								</li>
								<li class="rowLi">
									<a href="ProjectMember_Add.jsp" data-hover="�ο�����">
										<span>�ο�����</span>
									</a>
								</li>
								<li class="rowLi">
									<a href="project_work.html" data-hover="�۾�����">
										<span>�۾�����</span>
									</a>
								</li>
								<li class="rowLi">
									<a href="ProjectCost1.jsp" data-hover="������">
										<span>������</span>
									</a>
								</li>
							</ul>
						</div>
					</div>
					<br />
					<hr style="border: solid 1px black;">
			</div>
					
			<div class="row" style="margin-Left:5%; margin-right:5%; padding-top:30px;background: #FFFFFF; border-radius: 10px;">
				<div class="col-5">
					<label>������Ʈ��</label>
					<input name = "PJNm"  id="PJNm"  type="text">

					<label class="toppadding">��ü ��</label>
					<input type="text" id="PartnerNm">

					<label class="toppadding">�ְ� �����(��)</label>
					<input type="text" id="HostManager">

					<div>
						<label class="toppadding" id="DATE">�Ⱓ</label>
						<input name = "StartDt"  id="StartDt"  type="date">
						&nbsp&nbsp~&nbsp&nbsp
						<input name = "EndDt"  id="EndDt"  type="date">
					</div>
				</div>

				<div class="col-5">
					<label>������Ʈ PM</label>
					<input name = "PJPM" id="PJPM" type="text">

					<label class="toppadding">�ְ� ��</label>
					<input name = "HostNm" id="HostNm" type="text">

					<label class="toppadding">�ְ� �����(��)</label>
					<input name = "HostSubManager" id="HostSubManager" type="text">
				</div>

				<div class="col-10">
					<label class="toppadding">������Ʈ ����</label>
					<textarea name = "PJContent" id="PJContent" rows="5"> </textarea>
					<div style="height: 100px; float:right; padding-top: 15px;">
						<button id = "btnSave" name = "btnSave" class="primary" type="button">���</button>
						&nbsp&nbsp
						<input type="button" value="���"  onclick="home()">
					</div>
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
						<li class="nanum"><a href="ProjectCreate.jsp">������Ʈ ���</a></li>
						<li class="nanum"><a href="ProjectList.jsp"> ������Ʈ ���</a></li>
<!-- 						<li class="nanum"><a href="project_user.html">����� ����</a></li> -->
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
	<script>
		function hmoe() {
			location.href = 'ProjectList.jsp';
		}

		function form_submit() {
			document.id.action = "link_page.html";
			document.id.submit();
		}
	</script>
</body>
</html>