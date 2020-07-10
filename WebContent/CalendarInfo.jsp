<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	String UserID = request.getParameter("UserID");
	session.setAttribute("UserId", UserID);
%>
<jsp:forward page="ProjectMember.jsp"></jsp:forward>
</body>
</html>