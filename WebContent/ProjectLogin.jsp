<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
	<title>프로젝트 관리 솔루션</title>

	<meta charset="utf-8" />
	<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic" rel="stylesheet">
	<script src="https://code.jquery.com/jquery-3.5.1.js"  integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU=" crossorigin="anonymous"></script>

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
		
		function enterkey() {
		    if (window.event.keyCode == 13) {

		         // 엔터키가 눌렸을 때 실행할 내용
		         LoginButton();
		    }
		}
	</script>

	<style>
		
		a {
			color: #333;
			text-decoration: none;
		}

		input {
			-webkit-writing-mode: horizontal-tb !important;
			text-rendering: auto;
			color: initial;
			letter-spacing: normal;
			word-spacing: normal;
			text-transform: none;
			text-indent: 0px;
			text-shadow: none;
			display: inline-block;
			text-align: start;
			-webkit-appearance: textfield;
			background-color: white;
			-webkit-rtl-ordering: logical;
			cursor: text;
			margin: 0em;
			font: 400 13.3333px Arial;
			padding: 1px 0px;
			border-width: 2px;
			border-style: inset;
			border-color: initial;
			border-image: initial;
		}


		.inner_login {
			position: absolute;
			left: 44%;
			top: 40%;
			margin: -205px 0 0 -160px;
		}

		.login_tistory {
			position: relative;
			width: 320px;
			margin: 0 auto;
		}

		.screen_out {
			position: absolute;
			width: 0;
			height: 0;
			overflow: hidden;
			line-height: 0;
			text-indent: -9999px;
		}
		
		body{
			background-image : url(image/login1.jpg);
		}

		body,
		button,
		input,
		select,
		td,
		textarea,
		th {
			font-size: 13px;
			line-height: 1.5;
			-webkit-font-smoothing: antialiased;
		}

		fieldset,
		img {
			border: 0;
		}

		.login_box{
			border: 3px ridge #000000;
			padding: 120px 60px 140px 60px;
			background-color :#ffffff;

		}

		.login_tistory .box_login {
			margin: 35px 0 0;
			border: 1px solid #ddd;
			border-radius: 3px;
			background-color: #fff;
			box-sizing: border-box;
		}

		.login_tistory .inp_text {
			position: relative;
			width: 100%;
			margin: 0;
			padding: 18px 19px 19px;
			box-sizing: border-box;
		}

		.login_tistory .inp_text+.inp_text {
			border-top: 1px solid #aaaaaa;
		}

		.inp_text input {
			display: block;
			width: 100%;
			height: 100%;
			font-size: 13px;
			color: #000;
			border: none;
			outline: 0;
			-webkit-appearance: none;
			background-color: transparent;
		}

		.btn_login {
			margin: 20px 0 0;
			width: 100%;
			height: 48px;
			border-radius: 3px;
			font-size: 16px;
			color: #fff;
			background-color: #000;
		}

		.login_append {
			overflow: hidden;
			padding: 15px 0 0;
		}

		.inp_chk {
			display: inline-block;
			position: relative;
			margin-bottom: -1px;
		}

		.login_append .inp_chk {
			float: left;
		}

		.inp_chk .inp_radio {
			position: absolute;
			z-index: -1;
			top: 0;
			left: 0;
			width: 18px;
			height: 18px;
			border: 0;
		}

		.inp_chk .lab_g {
			display: inline-block;
			margin-right: 19px;
			color: #909090;
			font-size: 13px;
			line-height: 19px;
			vertical-align: top;
		}

		.inp_chk .ico_check {
			display: inline-block;
			width: 18px;
			height: 18px;
			margin: 1px 4px 0 0;
			background-position: -60px 0;
			color: #333;
		}

		.inp_chk .txt_lab {
			vertical-align: top;
		}

		.login_append .txt_find {
			float: right;
			color: #777;
		}

	</style>

</head>
<%
	request.setCharacterEncoding("UTF-8");
	String UserId = session.getAttribute("UserId") == null ? "" : (String)session.getAttribute("UserId");
	System.out.println("아이디 : " + session.getAttribute("UserId"));
%>
<body>

	<div class="inner_login">
		<div class = "login_box">
		<div class="login_tistory">
			<div style="font-family:Nanum Gothic; font-size: 28px; text-align:center;">
				하이데이타<br>프로젝트 관리 시스템<br>
			</div>
			<br />
			<br />

			<form method="post" id="Login" name="Login" action="ProjectLogin_OK.jsp">
				<input type="hidden" name="redirectUrl">
				<fieldset>
					<legend class="screen_out">로그인 정보 입력폼</legend>
					<div class="box_login">
						<div class="inp_text">
							<label for="loginIdLabel" class="screen_out">아이디</label>
							<% out.println("<input type='text' id='loginId' name='loginId' placeholder='ID' value='" + UserId + "'>"); %>
						</div>
						<div class="inp_text">
							<label for="loginPw" class="screen_out">비밀번호</label>
							<input type="password" id="loginPw" name="password"placeholder="Password">
						</div>
					</div>
					<input type="submit" value = "로그인" style="text-align:center;" id="LoginButton" name="LoginButton" class="btn_login" onclick="checknull()" >
					<div class="login_append">
						<div class="inp_chk">
						</div>
					</div>
				</fieldset>
			</form>
		</div>
	</div>
</div>


<!-- Scripts -->
<script src="assets/js/jquery.min.js"></script>
<script src="assets/js/browser.min.js"></script>
<script src="assets/js/breakpoints.min.js"></script>
<script src="assets/js/util.js"></script>
<script src="assets/js/main.js"></script>
<script>
function checknull(){
	if (document.getElementById("loginId").value == "")
	{
		alert("아이디를 입력해 주십시오.");
		return;
	}
	if (document.getElementById("loginPw").value == "")
	{
		alert("비밀번호를 입력해 주십시오.");
		return;
	}
	document.Login.submit();
}
</script>
</body>
</html>
