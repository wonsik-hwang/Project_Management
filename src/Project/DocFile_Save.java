package Project;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.http.HttpServletRequest;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class DocFile_Save {
	
	
	String M_name;
	String M_Content;
	String M_fileFullPath;
	String M_fileName;
	
	public boolean fileUpload(HttpServletRequest request){
		boolean b = false;
		try {
			
			request.setCharacterEncoding("UTF-8");
			//저장할 위치 설정
			String uploadDir = "C:/Users/Wonsik/Desktop/Project/ProjectManager/WebContent/Document";
//			String savePath = request.getServletContext().getRealPath("Document");	
			
			
//			savePath,
			//multipartRequest객체 생성
			MultipartRequest multi = new MultipartRequest(request, uploadDir, /*"C:/Users/Wonsik/Desktop/Project/ProjectManager/WebContent/Document"*/ 8 * 1024 * 1024, "UTF-8", new DefaultFileRenamePolicy());
			
			//request에서  name이 image인 데이터를 저장하고, image가 null이 아닐경우 b는 true
			if(multi.getFilesystemName("image")!=null) b=true;
			
			String m_name = multi.getParameter("DocNm");
			String m_nickname = multi.getParameter("DocContent");
			String fileName = multi.getFilesystemName("ex_filename");
			
			String m_fileFullPath = uploadDir + "/" + fileName;

			this.M_name = m_name;
			this.M_Content = m_nickname;
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
	    	

	    	sql = "INSERT INTO MA_Document (DocNm, DocRemark, DocFileNm, DocPath) VALUES (?, ?, ?, ?)";
	    	
	    	pstmt = conn.prepareStatement(sql);
	    	pstmt.setString(1, M_name);
	    	pstmt.setString(2, M_Content);
	    	pstmt.setString(3, M_fileName);
		    pstmt.setString(4, M_fileFullPath);
	    	
	    	pstmt.executeUpdate();	
	    	pstmt.close();
	    	conn.close();
	    	
//	    	sql = "INSERT INTO MA_Document (DocBLOB, DocPath, DocBLOB_by, DocPath_by) VALUES (LOAD_FILE(" + M_fileName + "), LOAD_FILE(" + M_fileFullPath + "), ?, ?)";
//	    	StringBuilder sql1 = new StringBuilder("INSERT INTO MA_Document (DocBLOB, DocPath, DocBLOB_by, DocPath_by) VALUES (LOAD_FILE(");	
//	    	sql1.append(M_fileName + "), LOAD_FILE(" + M_fileFullPath + "");
//	    	sql = "INSERT INTO MA_Document (DocBLOB, DocPath, DocBLOB_by, DocPath_by) VALUES (LOAD_FILE(" + M_fileName + "), LOAD_FILE(" + M_fileFullPath + "), ?, ?)";
//	    	sql = "INSERT INTO MA_Document (DocBLOB, DocPath, DocBLOB_by, DocPath_by) VALUES ("+ M_fileName + "," + M_fileFullPath + "," + bytes1+ ","+ bytes2 +")";
//	    	pstmt.setString(2, M_fileFullPath);
//	    	pstmt.setString(2, "CURDATE()");
		} 
		
			catch (Exception e) {
			System.out.println("multipartrequestfileupload err : " + e);}
		
		return b;
	}
}
