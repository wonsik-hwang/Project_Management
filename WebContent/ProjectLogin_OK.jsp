<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@ page import = "ProjectManagement.JinjuDBConnect" %>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");

	String UserId = request.getParameter("loginId");
	String UserPw = request.getParameter("password");
	session.setAttribute("UserId", UserId);
	
	ArrayList<String[]> Logininfo = new ArrayList<String[]>();
		
	Connection conn = JinjuDBConnect.getJinjuDBConnection();
	
	String sql = "SELECT id, pw, name, rank FROM members WHERE id = '" + UserId + "'";
	PreparedStatement pstmt = conn.prepareStatement(sql);
	ResultSet rs = pstmt.executeQuery();
	
	while (rs.next())
	{
		Logininfo.add(new String[]{rs.getString("id"), rs.getString("pw"), rs.getString("name"), rs.getString("rank")});
	}
	
	if (Logininfo.size() == 0)
	{
		out.println("<script>alert('아이디를 잘못 입력하셨습니다.'); location.href = 'ProjectLogin.jsp';</script>");
	}
	else if (Logininfo.get(0)[1].equals(UserPw))
	{
		session.setAttribute("UserNm", Logininfo.get(0)[2]);
		session.setAttribute("Rank", Logininfo.get(0)[3]);
		out.println("<script>location.href = 'ProjectMain.jsp'</script>");
	}
	else
	{
		out.println("<script>alert('비밀번호를 잘못 입력하셨습니다.'); location.href = 'ProjectLogin.jsp';</script>");
	}

%>
</body>
</html>