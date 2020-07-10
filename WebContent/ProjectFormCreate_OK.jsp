<%@page import="ProjectManagement.FileUpload"%>
<%@page import="ProjectManagement.MySQLConnect"%>
<%@page import="java.text.DateFormat"%>
<%@page import="com.mysql.jdbc.Messages"%>
<%@page import= "java.sql.Date"%>
<%@page import = "java.sql.DriverManager" %>
<%@page import = "java.sql.PreparedStatement" %>
<%@page import = "java.sql.Connection" %>
<%@page import = "java.sql.Timestamp" %>
<%@page import = "java.util.*" %>
<%@page import = "java.text.DecimalFormat" %>
<%@page import = "java.text.SimpleDateFormat" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>(주)하이데이타</title>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");
	FileUpload upload = new FileUpload();	
	if (upload.FormInset(request)) {
	%>
	<script type="text/javascript">
		alert("양식이 저장되었습니다.");
		location.href = "ProjectOutput.jsp";
	</script>
<%
	}
%>
</body>
</html>
