<%@page import="ProjectManagement.MySQLConnect"%>
<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");
	String UserID = request.getParameter("UserID");
	String SetDt = request.getParameter("SetDt");
	String PJTNo = request.getParameter("PJTNo");
	
	Connection conn = MySQLConnect.getMySQLConnection();
	String sql = "DELETE FROM MA_Work WHERE PJTNo = " + PJTNo + " AND UserID = '" + UserID + "' AND SetDt = '" + SetDt + "'";
	PreparedStatement pstmt = conn.prepareStatement(sql);
	pstmt.executeUpdate();
%>
</body>
</html>