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
<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>하이데이타 프로젝트 관리</title>
</head>
<body>
<%
	request.setCharacterEncoding("euc-kr");
	String PJNm = request.getParameter("PJNm");
	String PartnerNm = request.getParameter("PartnerNm");
	String PJPM = request.getParameter("PJPM");
	String HostNm = request.getParameter("HostNm");
	String HostManager = request.getParameter("HostManager");
	String HostSubManager = request.getParameter("HostSubManager");
	String StartDt = request.getParameter("StartDt");
	String EndDt = request.getParameter("EndDt");
	String PJContent = request.getParameter("PJContent");
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	java.util.Date SDt = sdf.parse(StartDt);
	java.util.Date EDt = sdf.parse(EndDt);
	
	java.sql.Date sql_SDt = new java.sql.Date(SDt.getTime());
	java.sql.Date sql_EDt = new java.sql.Date(EDt.getTime());
	
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
    	
    	sql = "INSERT INTO MA_Project (PJNm, PJPM, PartnerNm, HostNm, HostManager, HostSubManager, PJStartDt, PJEndDt, PJContent) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
    	pstmt = conn.prepareStatement(sql);
    	pstmt.setString(1, PJNm);
    	pstmt.setString(2, PJPM);
    	pstmt.setString(3, PartnerNm);
    	pstmt.setString(4, HostNm);
    	pstmt.setString(5, HostManager);
    	pstmt.setString(6, HostSubManager);
    	pstmt.setDate(7, sql_SDt);
    	pstmt.setDate(8, sql_EDt);
    	pstmt.setString(9, PJContent);
    	
    	pstmt.executeUpdate();
    	out.println(PJNm);
    	
    	pstmt.close();
    	conn.close();
    	
    	out.println("<script>alert('프로젝트가 등록 되었습니다.'); location.href = 'ProjectList.jsp'; </script>");
    }
    catch (Exception ex)
    {
    	ex.printStackTrace();
    }
%>
</body>
</html>
