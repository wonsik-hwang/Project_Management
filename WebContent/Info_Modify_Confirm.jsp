<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import = "java.sql.PreparedStatement" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<%
try{
	   String PJNo = request.getParameter("PJNo");
	   PreparedStatement pstmt;
	   String dbURL="jdbc:mysql://192.168.0.71:3306/ProjectManagement?serverTimezone=UTC"; 
	   String dbID="hidata"; 
	   String dbPassword="hidata2312357!";
	   Class.forName("com.mysql.jdbc.Driver");
	   
	   Connection conn=DriverManager.getConnection(dbURL, dbID, dbPassword);
	   
	   Statement stmt = conn.createStatement();
	   String sql = "DELETE FROM MA_Project WHERE PJNo = " + PJNo;
	   pstmt = conn.prepareStatement(sql);
   	   stmt.executeUpdate(sql);
    
       pstmt.close();
       stmt.close();
       conn.close(); }

catch(ClassNotFoundException ex) {
	   	out.println("드라이버 로드에 실패하였습니다.");
	   	out.println(ex);
		}

catch(SQLException ex) {
	   	out.println("DB 접속에 실패 하였습니다.");
	   	out.println(ex.getMessage());
	   	ex.printStackTrace();
		}

finally{}
%>
<script>
	alert("게시글이 수정 되었습니다");
	location.href="ProjectRedirect.jsp";	
</script>
<body>

</body>
</html>