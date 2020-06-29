<%@ page language = "java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.DriverManager" %>
<%@ page import = "java.sql.PreparedStatement" %>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.regex.*" %>
<%@ page import = "ProjectManagement.MySQLConnect" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
	</head>
	<body>
		<%
		
		String [] SelectMember = request.getParameterValues("SelectMember");
		
		// String SelectMember = request.getParameter("SelectMember");
		System.out.println("Member Length : " + SelectMember.length);
		System.out.println("Member Num : " + SelectMember[0]);
		
		Connection conn = MySQLConnect.getMySQLConnection();
		
		try
		{
			String sql = "INSERT INTO MA_Person (PJNo, UserId) VALUES (?, ?)";
			PreparedStatement pstmt = conn.prepareStatement(sql);
		
			for (int i = 0; i < SelectMember.length; i++)
			{
				pstmt.setInt(1, 155);
				pstmt.setString(2, SelectMember[i]);
				
				pstmt.executeUpdate();
				out.println(SelectMember[i]);
			}
			
			pstmt.close();
			conn.close();
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
		
		%>
	</body>
</html>