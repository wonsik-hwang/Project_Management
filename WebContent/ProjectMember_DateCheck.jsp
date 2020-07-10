<%@ page import="ProjectManagement.MySQLConnect" %>
<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>배정 인원 삭제</title>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");
	
	String UserID = request.getParameter("UserID");
	String SetDt = request.getParameter("SetDt");
	String PJTNo = request.getParameter("PJTNo");
	
	Connection conn = MySQLConnect.getMySQLConnection();
	String sql = "SELECT * FROM MA_Work WHERE UserID = '" + UserID + "' AND SetDt = '" + SetDt + "'";
	PreparedStatement pstmt = conn.prepareStatement(sql);
	ResultSet rs = pstmt.executeQuery();
	
	while (rs.next())
	{
		if (!rs.getString("PJTNo").equals(PJTNo))
		{
			out.println("불합");
		}
		else
		{
			out.println("통과");
		}
	}
%>
</body>
</html>