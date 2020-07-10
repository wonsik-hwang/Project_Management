<%@page import="java.sql.ResultSet"%>
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
	String PJTNo = request.getParameter("PJTNo");
	String ClickId = request.getParameter("ClickId");
	String OPContent = request.getParameter("OPContent");
	String FileNm = request.getParameter("FileNm");
	
	System.out.println(PJTNo);
	System.out.println(ClickId);
	System.out.println(OPContent);
	System.out.println(FileNm);
	
	int ProjectNo = Integer.parseInt(PJTNo);
	int OutputNo = Integer.parseInt(ClickId);
	
	try{
		Connection conn = MySQLConnect.getMySQLConnection();
		String sql = "UPDATE MA_Output SET OPContent = ? WHERE PJTNo = ? AND FormGB = 2 AND FormNo = ?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, OPContent);
		pstmt.setInt(2, ProjectNo);
		pstmt.setInt(3, OutputNo);
		pstmt.executeUpdate();
	}
	catch (Exception e) {
		e.getStackTrace();
	}
	
%>
</body>
</html>
	