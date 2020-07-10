<%@ page language = "java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.DriverManager" %>
<%@ page import = "java.sql.PreparedStatement" %>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.regex.*" %>
<%@ page import = "ProjectManagement.MySQLConnect" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
	</head>
	<body>
		<%
			ArrayList<String[]> UserID = new ArrayList<String[]>();
			String [] SelectMember = request.getParameterValues("SelectMember");
			String PJTNo = request.getParameter("PJTNo");
			
			try
			{
				Connection conn = MySQLConnect.getMySQLConnection();
				
				String sql = "SELECT * FROM MA_Person mp WHERE PJTNo = ?";
				PreparedStatement pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, Integer.parseInt(PJTNo));
				ResultSet rs = pstmt.executeQuery();
				
				while (rs.next())
				{
					UserID.add(new String[] {rs.getString("UserID")});
				}
				
				String sql2 = "INSERT INTO MA_Person (PJTNo, UserID, InputDt) VALUES (?, ?, NOW())";
				PreparedStatement pstmt2 = conn.prepareStatement(sql2);
				
				for (int i = 0; i < SelectMember.length; i++)
				{
					int Check = 0;

					for (int j = 0; j < UserID.size(); j++)
					{
						if (SelectMember[i].equals(UserID.get(j)[0]))
						{
							Check++;
						}
					}
					
					if (Check == 0)
					{
						pstmt2.setInt(1, Integer.parseInt(PJTNo));
						pstmt2.setString(2, SelectMember[i]);
						pstmt2.executeUpdate();
					}
				}
				
				pstmt.close();
				conn.close();
				
				out.println("<script>alert('저장')</script>");
			}
			catch (Exception e)
			{
				e.printStackTrace();
			}
		%>
	</body>
</html>