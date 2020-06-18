<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@page import="java.util.regex.Pattern" %>
<%-- <%@page import="javax.sql.*" %> --%>
<%-- <%@page import="javax.naming.*" %> --%>
<%@page import="java.sql.*"%>s
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>

<%

try{
	String dbURL="jdbc:mysql://192.168.0.71:3306/ProjectManagement"; 
	String dbID="hidata"; 
	String dbPassword="hidata2312357!";
	
	Class.forName("com.mysql.jdbc.Driver");
	System.out.println("드라이버 로드를 완료 하였습니다.");
	
	ResultSet rs = null;
	Connection conn=DriverManager.getConnection(dbURL, dbID, dbPassword);
	System.out.println("MySQL 데이터베이스 db에 성공적으로 접속했습니다. ");
								   
	Statement stmt = conn.createStatement();
	String sql = "SELECT * FROM MA_Project ORDER BY PJNo DESC";
	rs = stmt.executeQuery(sql);
	if(rs.next()){
	System.out.println(rs.getString("PJNo"));}
	} 
catch(ClassNotFoundException ex) {
		System.out.println("드라이버 로드에 실패하였습니다.");
		System.out.println(ex);
	}
catch(SQLException ex) {
		System.out.println("DB 접속에 실패 하였습니다.");
		System.out.println(ex.getMessage());
		ex.printStackTrace();
	}
finally{}

%>

</body>
</html>