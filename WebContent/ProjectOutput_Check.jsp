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
<title>(주)하이데이타</title>
</head>
<body>
<%
	request.setCharacterEncoding("utf-8");
// 	String PJTNo = request.getParameter("PJTNo");
	String FormNm = request.getParameter("FormNm");
	String PJTNo = "1";
	int No_Value = Integer.parseInt(PJTNo);

	out.println("통과");
// 	if (ProjectNameCheck.OutputFormNameCheck(OPNm, No_Value))
// 	{
// 		out.println("중복");
// 	}
// 	else
// 	{
// 		out.println("통과");
// 	}
%>
</body>
</html>