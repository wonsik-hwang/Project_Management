 <%@page import="java.io.File"%>
 <%@page import="java.io.*"%>
 <%@page trimDirectiveWhitespaces = "true" %>
 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
 <!DOCTYPE html>
 <html>
 <head>
 <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 <title>Insert title here</title>
 </head>
 <body>
 <% 
 	request.setCharacterEncoding("UTF-8");
//  	String fileNm = request.getParameter("DocFileNm");
//  	String fileNo = request.getParameter("DocNo");
//  	System.out.println(fileNm);
//  	out.println("<script> location.href = 'ProjectDocument.jsp';</script>");

  // 다운받을 파일의 이름을 가져옴
  String FileNm = "C:\\Users\\Wonsik\\Desktop\\Project\\ProjectManager\\WebContent\\Document";
//   String FileNm = request.getParameter("DocPath");
  String fileName = request.getParameter("DocFileNm");
  // 다운받을 파일이 저장되어 있는 폴더 이름
//   String saveFolder = "Document";
  
  // Context에 대한 정보를 알아옴
  ServletContext context = getServletContext(); // 서블릿에 대한 환경정보를 가져옴
  
  // 실제 파일이 저장되어 있는 폴더의 경로
  String realFolder = "C:\\Users\\Wonsik\\Desktop\\Project\\ProjectManager\\WebContent\\Document";
//   String realFolder = context.getRealPath(saveFolder);
  // 다운받을 파일의 전체 경로를 filePath에 저장
  String filePath = realFolder + "\\" + fileName;
  
  try{
   // 다운받을 파일을 불러옴
//    System.out.println(filePath);
//    System.out.println(fileName);
//    System.out.println(FileNm);
   File file = new File(filePath);
   byte b[] = new byte[4096];
   
   // page의 ContentType등을 동적으로 바꾸기 위해 초기화시킴
   response.reset();
   response.setContentType("application/octet-stream");
   
   // 한글 인코딩
   String Encoding = new String(fileName.getBytes("UTF-8"), "8859_1");
   
   // 파일 링크를 클릭했을 때 다운로드 저장 화면이 출력되게 처리하는 부분
   response.setHeader("Content-Disposition", "attachment; filename = " + Encoding);
  
   // 파일의 세부 정보를 읽어오기 위해서 선언
   FileInputStream in = new FileInputStream(filePath);
  
   // 파일에서 읽어온 세부 정보를 저장하는 파일에 써주기 위해서 선언
    ServletOutputStream out2 = response.getOutputStream();
   
   int numRead;
   // 바이트 배열 b의 0번 부터 numRead번 까지 파일에 써줌 (출력)
   while((numRead = in.read(b, 0, b.length)) != -1){
    out2.write(b, 0, numRead);
   }
   
   out2.flush();
   out2.close();
   in.close();
   
  } catch(Exception e){
  }
 %>
 </body>
 </html>