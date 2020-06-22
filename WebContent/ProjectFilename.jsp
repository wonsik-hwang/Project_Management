<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import = "java.io.File" %>
<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>

<%
	String uploadPath = request.getRealPath("C:/Users/shin/Pictures/007.png");
		
	int size = 10 * 1024 * 1024;
	String name="";
	String subject="";
	String filename1="";
	String filename2="";
		
	try{
		MultipartRequest multi = new MultipartRequest(request, uploadPath, size, "UTF-8", new DefaultFileRenamePolicy());
		
	    name=multi.getParameter("name");
	    subject=multi.getParameter("subject");
		
	    Enumeration files = multi.getFileNames();
	    String file1 = (String)files.nextElement();
	    filename1 = multi.getFilesystemName(file1);
	    String file2 = (String)files.nextElement();
	    filename2=multi.getFilesystemName(file2);
	    
	    System.out.println(files);
	    System.out.println(file1);
	    System.out.println(filename1);
	    System.out.println(file2);
	    System.out.println(filename2);
	
	}
	catch(Exception e){
	    e.printStackTrace();
	}
%>

</body>
</html>