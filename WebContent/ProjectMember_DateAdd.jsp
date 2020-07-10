<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="java.text.DateFormat"%>
<%@ page import ="com.mysql.jdbc.Messages"%>
<%@ page import = "java.sql.Date"%>
<%@ page import = "java.sql.DriverManager" %>
<%@ page import = "java.sql.PreparedStatement" %>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.Timestamp" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.text.DecimalFormat" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ page import = "ProjectManagement.MySQLConnect" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>프로젝트 멤버 날짜 추가 페이지</title>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");
	
	String PJTNo = request.getParameter("PJTNo");
	String UserID = request.getParameter("UserID");
	String SetDt = request.getParameter("SetDt");
	
	System.out.println(PJTNo);
	
	if (UserID.equals(""))
	{
		return;
	}

	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	java.util.Date SDt = sdf.parse(SetDt);
	java.sql.Date sql_SDt = new java.sql.Date(SDt.getTime());
	
	Connection conn = MySQLConnect.getMySQLConnection();
	String sql = "INSERT INTO MA_Work (PJTNo, UserID, SetDt) VALUES (?, ?, ?)";
	PreparedStatement pstmt = conn.prepareStatement(sql);
	pstmt.setInt(1, Integer.parseInt(PJTNo));
	pstmt.setString(2, UserID);
	pstmt.setDate(3, sql_SDt);
	pstmt.executeUpdate();
%>
</body>
</html>