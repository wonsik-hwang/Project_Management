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
	System.out.println("����̹� �ε带 �Ϸ� �Ͽ����ϴ�.");
	
	ResultSet rs = null;
	Connection conn=DriverManager.getConnection(dbURL, dbID, dbPassword);
	System.out.println("MySQL �����ͺ��̽� db�� ���������� �����߽��ϴ�. ");
								   
	Statement stmt = conn.createStatement();
	String sql = "SELECT * FROM MA_Project ORDER BY PJNo DESC";
	rs = stmt.executeQuery(sql);
	if(rs.next()){
	System.out.println(rs.getString("PJNo"));}
	} 
catch(ClassNotFoundException ex) {
		System.out.println("����̹� �ε忡 �����Ͽ����ϴ�.");
		System.out.println(ex);
	}
catch(SQLException ex) {
		System.out.println("DB ���ӿ� ���� �Ͽ����ϴ�.");
		System.out.println(ex.getMessage());
		ex.printStackTrace();
	}
finally{}

%>

</body>
</html>