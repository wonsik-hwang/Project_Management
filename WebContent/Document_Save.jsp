<%@page import="Project.DocFile_Save"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<% 
request.setCharacterEncoding("utf-8");
String PJTNo = request.getParameter("PJTNo");
DocFile_Save upload2 = new DocFile_Save();
if(upload2.fileUpload(request)){
%>
<script>
	alert("저장이 완료 되었습니다.");
	location.href="ProjectDocument.jsp?PJTNo=<%=PJTNo%>";
</script>
<% 
}
%>
