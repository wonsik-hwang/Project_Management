package Project;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.io.*;
import javax.servlet.http.HttpServletRequest;
import org.apache.tomcat.jni.File;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class DocFile_Save {
	
	String M_name;
	String M_Content;
	String M_fileFullPath;
	String M_fileName;
	String M_PJTNo;
	float M_DocVer;
	String M_DocUserID;
	
	
	public boolean fileUpload(HttpServletRequest request){
		boolean b = true;
		
		try {
			request.setCharacterEncoding("UTF-8");
			
			//저장할 위치 설정
//			String uploadDir = "C:/Users/Wonsik/Desktop/Project/ProjectManager/WebContent/Document";
			String uploadDir = request.getServletContext().getRealPath("Document") + "\\"+ request.getParameter("PJTNo");	
			uploadDir = uploadDir.replace('\\', '/');
			java.io.File targetDir = new java.io.File(uploadDir);
			if(!targetDir.exists()) {targetDir.mkdirs();}
			 
			//multipartRequest객체 생성
			MultipartRequest multi = new MultipartRequest(request, uploadDir, 8 * 1024 * 1024, "UTF-8", new DefaultFileRenamePolicy());
			
			//request에서  name이 image인 데이터를 저장하고, image가 null이 아닐경우 b는 true
//			if(multi.getFilesystemName("image")!=null) b=true;
			
			String m_name = multi.getParameter("DocNm");
			String m_nickname = multi.getParameter("DocContent");
			String fileName = multi.getFilesystemName("ex_filename");
			String m_PJTNo = multi.getParameter("PJTNo");
			String m_fileFullPath = uploadDir + "/" + fileName;
			float m_DocVer = 1.0F;
			String m_DocUserID = "test";
			
			this.M_PJTNo = m_PJTNo;
			this.M_name = m_name;
			this.M_Content = m_nickname;
			this.M_fileFullPath = m_fileFullPath;
			this.M_fileName = fileName;
			this.M_DocVer = m_DocVer;
			this.M_DocUserID = m_DocUserID;
			
		    Connection conn = null;
	    	PreparedStatement pstmt = null;
	    	String dbURL = "jdbc:mysql://192.168.0.71:3306/ProjectManagement?useUnicode=true&characterEncoding=UTF-8";
	    	String dbID = "hidata";
	    	String dbPassword = "hidata2312357!";

	    	Class.forName("com.mysql.jdbc.Driver");
	    	System.out.println("드라이버 성공");
	    	conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
	    	System.out.println("DB 성공");
	    	
	    	String sql = "INSERT INTO MA_Document (PJTNo, DocNm, DocContent, DocFileNm, DocPath, DocVer, DocUserID, DocDt) VALUES (?, ?, ?, ?, ?, ?, ?, NOW())";
	    	
	    	pstmt = conn.prepareStatement(sql);
	    	pstmt.setString(1, M_PJTNo);
	    	pstmt.setString(2, M_name);
	    	pstmt.setString(3, M_Content);
	    	pstmt.setString(4, M_fileName);
		    pstmt.setString(5, M_fileFullPath);
		    pstmt.setFloat(6, M_DocVer);
		    pstmt.setString(7, M_DocUserID);
		    
	    	pstmt.executeUpdate();	
	    	pstmt.close();
	    	conn.close();
		} 
		
			catch (Exception e) {
			System.out.println("multipartrequestfileupload err : " + e);}
		
		return b;
//		return true;
	}
}
