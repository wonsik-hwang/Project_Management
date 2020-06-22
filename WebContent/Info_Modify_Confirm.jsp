<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*" %>
<%@page import ="java.sql.PreparedStatement" %>
<%@page import = "java.text.DecimalFormat" %>
<%@page import = "java.text.SimpleDateFormat" %>


<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<%
try{
		request.setCharacterEncoding("UTF-8");
	    String PJNo = request.getParameter("PJNo");
		String PJNm = request.getParameter("PJNm");
		String PartnerNm = request.getParameter("PartnerNm");
		String PJPM = request.getParameter("PJPM");
		String HostNm = request.getParameter("HostNm");
		String HostManager = request.getParameter("HostManager");
		String HostSubManager = request.getParameter("HostSubManager");
		String StartDt = request.getParameter("StartDt");
		String EndDt = request.getParameter("EndDt");
		String PJContent = request.getParameter("PJContent");
		
		System.out.println(PJNm);
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		java.util.Date SDt = sdf.parse(StartDt);
		java.util.Date EDt = sdf.parse(EndDt);
		
		java.sql.Date sql_SDt = new java.sql.Date(SDt.getTime());
		java.sql.Date sql_EDt = new java.sql.Date(EDt.getTime());

	   PreparedStatement pstmt;
	   	String dbURL = "jdbc:mysql://192.168.0.71:3306/ProjectManagement?useUnicode=true&characterEncoding=UTF-8";
	   	String dbID = "hidata";
	   	String dbPassword = "hidata2312357!";
	   Class.forName("com.mysql.jdbc.Driver");
	   
	   Connection conn=DriverManager.getConnection(dbURL, dbID, dbPassword);
	   
	   Statement stmt = conn.createStatement();
	   String sql = 
		"UPDATE MA_Project SET " +
	   					"PJNm = " + "'" + PJNm + "'" +
	   					",PJPM = " + "'" + PJPM + "'" +
	   					",PartnerNm = " + "'" + PartnerNm + "'" +
	   					",HostNm = " + "'" + HostNm + "'" +
	   					",HostManager = " + "'" + HostManager + "'" +
	   					",HostSubManager = " + "'" + HostSubManager + "'" +
	   					",PJStartDt = " + "'" + sql_SDt + "'" +
	   					",PJEndDt = " + "'" + sql_EDt + "'" +
	   					",PJContent = " + "'" + PJContent + "'" +
	   					"WHERE PJNo = " + PJNo;

	   pstmt = conn.prepareStatement(sql);
   	   stmt.executeUpdate(sql);

%>
<script>
	alert("게시글이 수정 되었습니다");
	location.href="ProjectRedirect.jsp?PJNo=<%=PJNo%>";	
</script>

<%
pstmt.close();
stmt.close();
conn.close(); 
}

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
<body>

</body>
</html>