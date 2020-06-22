import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.http.HttpServletRequest;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class DocFile_Save {
	
	
	String M_name;
	String M_nickname;
	String M_fileFullPath;
	String M_fileName;
	
	
//	public void DocFile_Save()
//	{
//		try{
////			request.setCharacterEncoding("UTF-8");
////			String PJNo = request.getParameter("PJNo");
//			String dbURL="jdbc:mysql://192.168.0.71:3306/ProjectManagement"; 
//			String dbID="hidata"; 
//			String dbPassword="hidata2312357!";
//			
//			Class.forName("com.mysql.jdbc.Driver");
//			
//			ResultSet rs = null;
//			Connection conn=DriverManager.getConnection(dbURL, dbID, dbPassword);
//										   
//			Statement stmt = (Statement) conn.createStatement();
//			String sql = "SELECT * FROM MA_Project WHERE PJNo =" + PJNo;
//			rs = stmt.executeQuery(sql);
//	}
//		catch(Exception ex) {}
//	}
	
	
	public boolean fileUpload(HttpServletRequest request){
		boolean b = false;
		try {
			//저장할 위치 설정
			String uploadDir = "C:/Users/Wonsik/Desktop/Project/ProjectManager/WebContent/Document";
//			String savePath = request.getServletContext().getRealPath("Document");	
			
			
//			savePath,
			//multipartRequest객체 생성
			MultipartRequest multi = new MultipartRequest(request, "C:/Users/Wonsik/Desktop/Project/ProjectManager/WebContent/Document", 8 * 1024 * 1024, "UTF-8", new DefaultFileRenamePolicy());

			//request에서  name이 image인 데이터를 저장하고, image가 null이 아닐경우 b는 true
			if(multi.getFilesystemName("image")!=null) b=true;
			
			String m_name = multi.getParameter("DocNm");
			String m_nickname = multi.getParameter("DocContent");
			String fileName = multi.getFilesystemName("ex_filename");
			
			
			String m_fileFullPath = uploadDir + "/" + fileName;

			
			this.M_name = m_name;
			this.M_nickname = m_nickname;
			this.M_fileFullPath = m_fileFullPath;
			this.M_fileName = fileName;
			
		    Connection conn = null;
	    	PreparedStatement pstmt = null;
	    	String sql = "";
	    	String dbURL = "jdbc:mysql://192.168.0.71:3306/ProjectManagement?useUnicode=true&characterEncoding=UTF-8";
	    	String dbID = "hidata";
	    	String dbPassword = "hidata2312357!";

	    	Class.forName("com.mysql.jdbc.Driver");
	    	System.out.println("드라이버 성공");
	    	conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
	    	System.out.println("DB 성공");
	    	sql = "INSERT INTO MA_Document (DocNm, DocDt, DocRemark, DocBLOB) VALUES (?, ?, ?, ?)";
	    	pstmt = conn.prepareStatement(sql);
	    	pstmt.setString(1, M_name);
	    	pstmt.setString(2, "NOW()");
	    	pstmt.setString(3, M_nickname);
//		    	pstmt.setString(4, M_fileFullPath);
	    	pstmt.setString(4, M_fileName);
	    	
	    	pstmt.executeUpdate();	
	    	pstmt.close();
	    	conn.close();
		
		} 
		
			catch (Exception e) {
			System.out.println("multipartrequestfileupload err : " + e);}
		
		return b;
	}
}
