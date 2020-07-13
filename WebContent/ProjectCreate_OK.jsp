<%@ page language = "java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>(주)하이데이타</title>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");
	String PJTNm = request.getParameter("PJTNm");
	String PartnerNm = request.getParameter("PartnerNm");
	String PJTPMID = request.getParameter("PJTPMID");
	String HostNm = request.getParameter("HostNm");
	String HostManager = request.getParameter("HostManager");
	String HostSubManager = request.getParameter("HostSubManager");
	String PJTStartDt = request.getParameter("PJTStartDt");
	String PJTEndDt = request.getParameter("PJTEndDt");
	String PJTContent = request.getParameter("PJTContent");
	String Approval1 = request.getParameter("Approval1");
	String Approval2 = request.getParameter("Approval2");
	String Approval3 = request.getParameter("Approval3");
	String Approval4 = request.getParameter("Approval4");
	String Approval5 = request.getParameter("Approval5");
	String JinjuProject = request.getParameter("JinjuWeb");
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	java.util.Date SDt = sdf.parse(PJTStartDt);
	java.util.Date EDt = sdf.parse(PJTEndDt);
	
	java.sql.Date sql_SDt = new java.sql.Date(SDt.getTime());
	java.sql.Date sql_EDt = new java.sql.Date(EDt.getTime());
	
	try
    {
		Connection conn = MySQLConnect.getMySQLConnection();
		
		// 프로젝트 정보 등록
    	String sql =	"INSERT INTO MA_Project (PJTNm, PJTPMID, PartnerNm, HostNm, HostManager, HostSubManager, PJTStartDt, PJTEndDt, PJTContent, PJTStateSeq, Approval_line1, Approval_line2, Approval_line3, Approval_line4, Approval_line5) " +
    						"VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
    	PreparedStatement pstmt = conn.prepareStatement(sql);
    	pstmt.setString(1, PJTNm);
    	pstmt.setString(2, PJTPMID);
    	pstmt.setString(3, PartnerNm);
    	pstmt.setString(4, HostNm);
    	pstmt.setString(5, HostManager);
    	pstmt.setString(6, HostSubManager);
    	pstmt.setDate(7, sql_SDt);
    	pstmt.setDate(8, sql_EDt);
    	pstmt.setString(9, PJTContent);
    	pstmt.setInt(10, 0);
    	pstmt.setString(11, Approval1);
    	pstmt.setString(12, Approval2);
    	pstmt.setString(13, Approval3);
    	pstmt.setString(14, Approval4);
    	pstmt.setString(15, Approval5);
    	pstmt.executeUpdate();
    	
    	// 프로젝트 산출물 양식 목록 등록
    	sql = "INSERT INTO MA_Output (PJTNo, FormGB, FormNo) SELECT DISTINCT (SELECT MAX(PJTNo) FROM MA_Project), FormGB, FormNo FROM MA_Form WHERE FormGB = 2";
    	pstmt = conn.prepareStatement(sql);
    	pstmt.executeUpdate();
    	
    	// PM 등록
    	sql =	"INSERT INTO MA_Person (PJTNo, UserID, InputDt) " +
    			"SELECT DISTINCT (SELECT MAX(PJTNo) FROM MA_Project), ?, NOW()";
    	pstmt = conn.prepareStatement(sql);
    	pstmt.setString(1, PJTPMID);
    	pstmt.executeUpdate();
    	
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
