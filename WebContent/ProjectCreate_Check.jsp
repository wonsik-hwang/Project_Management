<%@page import="java.util.function.Function"%>
<%@page import="ProjectManagement.ProjectNameCheck"%>
<%@page import="com.mysql.jdbc.Messages"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Date"%>
<%@page import = "java.sql.DriverManager" %>
<%@page import = "java.sql.PreparedStatement" %>
<%@page import = "java.sql.Connection" %>
<%@page import = "java.sql.Timestamp" %>
<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<%
	request.setCharacterEncoding("utf-8");
	String PJNm = request.getParameter("PJNm");

	if (ProjectNameCheck.NameCheck(PJNm))
	{
		out.println("�ߺ�");
	}
	else
	{
		out.println("���");
	}
%>
</body>
</html>