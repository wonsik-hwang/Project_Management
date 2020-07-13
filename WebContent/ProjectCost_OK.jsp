<%@page import="ProjectManagement.FileUpload"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비용 등록 페이지</title>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");
	FileUpload Upload = new FileUpload();
	if (Upload.CostFileUpload(request))
	{
%>
		<script type="text/javascript">
			alert("등록되었습니다.");
			location.href = "ProjectCost.jsp";
		</script>
<%
	}
%>
</body>
</html>