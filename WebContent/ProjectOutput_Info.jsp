<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="ProjectManagement.MySQLConnect"%>
<%@page import="java.sql.Connection"%>
<%@ page language = "java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src="https://code.jquery.com/jquery-3.5.1.js"  integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU=" crossorigin="anonymous"></script>
<%
	request.setCharacterEncoding("UTF-8");

	String FormNo = request.getParameter("FormNo");
	ArrayList<String[]> OPInfo = new ArrayList<String[]>();
	
	Connection conn = MySQLConnect.getMySQLConnection();
	String sql = "SELECT * FROM MA_Form WHERE FormGB = 2 AND FormNo = " + FormNo + " AND FileVer = (SELECT MAX(FileVer) FROM MA_Form WHERE FormGB = 2 AND FormNo = " + FormNo + ")";
	PreparedStatement pstmt = conn.prepareStatement(sql);
	ResultSet rs = pstmt.executeQuery();
	
	while (rs.next())
	{
		OPInfo.add(new String[]{rs.getString("FileVer"), rs.getString("Remark")});
	}
	
	if (OPInfo.size() == 0)
	{
%>
	<script type="text/javascript">
	OPContent = ""
	</script>
<%
	}
	if (OPInfo.size() > 0)
	{
%>
	<script type="text/javascript">
		OPContent = <%= OPInfo.get(0)[1]%>
	</script>
<%
	}
%>