<%@page import="java.util.function.Function"%>
<%@page import="ProjectManagement.ProjectNameCheck"%>
<%@page import="com.mysql.jdbc.Messages"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Date"%>
<%@page import = "java.sql.DriverManager" %>
<%@page import = "java.sql.PreparedStatement" %>
<%@page import = "java.sql.Connection" %>
<%@page import = "java.sql.Timestamp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>(주)하이데이타</title>
</head>
<body>
<%
	request.setCharacterEncoding("utf-8");
	String PJTNm = request.getParameter("PJTNm");

	if (ProjectNameCheck.NameCheck(PJTNm))
	{
		out.println("불합");
	}
	else
	{
		out.println("통과");
	}
%>
</body>
</html>