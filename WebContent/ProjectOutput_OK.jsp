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
	FileUpload Upload = new FileUpload();	
	if (Upload.OutputFileUpload(request)) {
	%>
	<script type="text/javascript">
		alert("산출물이 저장되었습니다.");
		location.href = "ProjectOutput.jsp";
	</script>
<%
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
// 	String PJTNo = request.getParameter("PJTNo");
// 	String OPNm = request.getParameter("OPNm");
// 	String OPContent = request.getParameter("OPContent");
// // 	String InsertDt = request.getParameter("InsertDt");
// // 	String InsertNm = request.getParameter("InsertNm");
// // 	String UpdateDt = request.getParameter("UpdateDt");
// // 	String UpdateNm = request.getParameter("UpdateNm");

// 	int No_Value = Integer.parseInt(PJNo);
	
// 	try
//     {
// 		Connection conn = MySQLConnect.getMySQLConnection();
    	
//     	String sql = "INSERT INTO MA_Output (PJTNo, OPNm, OPContent, FormGB, FileNo, FileVer, NewFileNm, NewFilePath, NewFileVer, InsertNm, InsertDt, UpdateNm, UpdateDt) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NOW(), ?, NOW())";
//     	PreparedStatement pstmt = conn.prepareStatement(sql);
//     	pstmt.setInt(1, 1);
//     	pstmt.setString(2, OPNm);
//     	pstmt.setString(3, OPContent);
//     	pstmt.setInt(4, 1);
//     	pstmt.setInt(5, 1);
//     	pstmt.setFloat(6, 1.0F);
//     	pstmt.setString(7, "NewFile");
//     	pstmt.setString(8, "Path");
//     	pstmt.setFloat(9, 1.0F);
//     	pstmt.setString(10, "Admin");
//     	pstmt.setString(12, "Admin");
    	
//     	pstmt.executeUpdate();
//     	out.println(OPNm);
    	
//     	pstmt.close();
//     	conn.close();
    	
//     	out.println("<script>alert('산출물이 등록되었습니다.'); location.href = 'ProjectOutput.jsp'; </script>");
//     }
//     catch (Exception ex)
//     {
//     	ex.printStackTrace();
//     }
%>
</body>
</html>
