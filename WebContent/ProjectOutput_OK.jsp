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
// 	String PJNo = request.getParameter("PJNo");
	String OPNm = request.getParameter("OPNm");
	String OPFile = request.getParameter("real_path");
	String OPContent = request.getParameter("OPContent");
// 	String InsertDt = request.getParameter("InsertDt");
// 	String InsertNm = request.getParameter("InsertNm");
// 	String UpdateDt = request.getParameter("UpdateDt");
// 	String UpdateNm = request.getParameter("UpdateNm");

// 	int No_Value = Integer.parseInt(PJNo);
	System.out.println(OPFile);
	
	try
    {
	    Connection conn = null;
    	PreparedStatement pstmt = null;
    	String sql = "";
    	
    	String dbURL = "jdbc:mysql://192.168.0.71:3306/ProjectManagement?useUnicode=true&characterEncoding=UTF-8";
    	String dbID = "hidata";
    	String dbPassword = "hidata2312357!";

    	Class.forName("com.mysql.jdbc.Driver");
    	conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
    	
    	sql = "INSERT INTO MA_Output (PJNo, OPNm, OPFile, OPContent, InsertDt, InsertNm, UpdateDt, UpdateNm) VALUES (?, ?, ?, ?, NOW(), ?, NOW(), ?)";
    	pstmt = conn.prepareStatement(sql);
    	pstmt.setInt(1, 1);
    	pstmt.setString(2, OPNm);
    	pstmt.setString(3, OPFile);
    	pstmt.setString(4, OPContent);
//     	pstmt.setDate(5, sql_IDt);
    	pstmt.setString(5, "Admin");
//     	pstmt.setDate(7, sql_UDt);
    	pstmt.setString(6, "Admin");
    	
    	pstmt.executeUpdate();
    	out.println(OPNm);
    	
    	pstmt.close();
    	conn.close();
    	
    	out.println("<script>alert('프로젝트가 등록 되었습니다.'); location.href = 'ProjectOutput.jsp'; </script>");
    }
    catch (Exception ex)
    {
    	ex.printStackTrace();
    }
%>
</body>
</html>
