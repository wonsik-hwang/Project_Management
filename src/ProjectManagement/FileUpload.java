package ProjectManagement;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.io.*;
import javax.servlet.http.HttpServletRequest;
import org.apache.tomcat.jni.File;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class FileUpload {
	int M_PJTNo;
	int M_GB;
	int M_No;
	String M_Nm;
	String M_FileNm;
	String M_FilePath;
	float M_FileVer;
	String M_Remark;
	String M_Content;
	int FileSize = 10 * 1024 * 1024;
	
	// ��� ���� ���ε� (�ű�)
	public boolean FormInset(HttpServletRequest request)
	{
		boolean b = true;
		
		try
		{
			request.setCharacterEncoding("UTF-8");
			
			// ���� ��ġ ����
			String UploadDir = request.getServletContext().getRealPath("OutputForm");
			UploadDir = UploadDir.replace('\\', '/');
			java.io.File targetDir = new java.io.File(UploadDir);
			
			if (!targetDir.exists()) {targetDir.mkdirs();}
			
			// MultipartRequest ��ü ����
			MultipartRequest multi = new MultipartRequest(request, UploadDir, FileSize, "UTF-8", new DefaultFileRenamePolicy());
			
			int m_FormGB = 2;
			String m_FormNm = multi.getParameter("FormNm");
			String m_FileNm = multi.getParameter("FileName");
			String m_FilePath = UploadDir + "/" + m_FileNm;
			float m_FileVer = 1.0F;
			String m_Remark = multi.getParameter("Remark");
			
			this.M_GB = m_FormGB;
			this.M_Nm = m_FormNm;
			this.M_FileNm = m_FileNm;
			this.M_FilePath = m_FilePath;
			this.M_FileVer = m_FileVer;
			this.M_Remark = m_Remark;
			
			Connection conn = MySQLConnect.getMySQLConnection();
			String sql = 	"INSERT INTO MA_Form (FormGB, FormNo, FormNm, FileNm, FilePath, FileVer, Remark) " +
								"SELECT " + M_GB + ", IFNULL(MAX(FormNo) + 1, 1)" + ", '" + M_Nm + "', '" + M_FileNm + "', '"  + M_FilePath + "', " + M_FileVer + ", '" + M_Remark  + "'" +
								"FROM MA_Form";
			
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.executeUpdate();
			
			pstmt.close();
			conn.close();
		}
		catch (Exception e)
		{
			System.out.println(("MultipartRequestFileUpload Error : " + e));
		}
		
		return b;
	}

	// ��� ���� ���ε� (����)
	public boolean FormUpdate(HttpServletRequest request)
	{
		boolean b = true;
		
		try
		{
			request.setCharacterEncoding("UTF-8");
			
			// ���� ��ġ ����
			String UploadDir = request.getServletContext().getRealPath("OutputForm");
			UploadDir = UploadDir.replace('\\', '/');
			java.io.File targetDir = new java.io.File(UploadDir);
			
			if (!targetDir.exists()) {targetDir.mkdirs();}
			
			// MultipartRequest ��ü ����
			MultipartRequest multi = new MultipartRequest(request, UploadDir, FileSize, "UTF-8", new DefaultFileRenamePolicy());
			
			int m_FormGB = 2;
			String m_FormNm = multi.getParameter("FormNm");
			String m_FileNm = multi.getParameter("FileName");
			String m_FilePath = UploadDir + "/" + m_FileNm;
			float m_FileVer = 1.0F;
			String m_Remark = multi.getParameter("Remark");
			
			this.M_GB = m_FormGB;
			this.M_Nm = m_FormNm;
			this.M_FileNm = m_FileNm;
			this.M_FilePath = m_FilePath;
			this.M_FileVer = m_FileVer;
			this.M_Remark = m_Remark;
			
			Connection conn = MySQLConnect.getMySQLConnection();
			String sql = 	"INSERT INTO MA_Form (FormGB, FormNo, FormNm, FileNm, FilePath, FileVer, Remark) " +
								"SELECT " + M_GB + ", IFNULL(MAX(FormNo) + 1, 1)" + ", '" + M_No + "', '" + M_FileNm + "', '"  + M_FilePath + "', " + M_FileVer + ", '" + M_Remark  + "'" +
								"FROM MA_Form";
			
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.executeUpdate();
			
			pstmt.close();
			conn.close();
		}
		catch (Exception e)
		{
			System.out.println(("MultipartRequestFileUpload Error : " + e));
		}
		
		return b;
	}

	// ���⹰ ���� ���ε� (�ű�)
	public boolean OutputFileUpload(HttpServletRequest request)
	{
		boolean b = true;
		
		try
		{
			request.setCharacterEncoding("UTF-8");
			
			// ���� ��ġ ����
			String UploadDir = request.getServletContext().getRealPath("Output") + "\\" + "158";// request.getParameter("PJTNo");
			UploadDir = UploadDir.replace('\\', '/');
			java.io.File targetDir = new java.io.File(UploadDir);
			
			if (!targetDir.exists()) {targetDir.mkdirs();}
			
			// MultipartRequest ��ü ����
			MultipartRequest multi = new MultipartRequest(request, UploadDir, FileSize, "UTF-8", new DefaultFileRenamePolicy());
			
			// FormGB : ���� 1, ���⹰ 2, ��� 3
//			int m_PJTNo = Integer.parseInt(request.getParameter("PJTNo"));
			int m_GB = 2;
			int m_No = Integer.parseInt(multi.getParameter("OutputNm"));
			String m_FileNm = multi.getParameter("OPFileNm");
			String m_FilePath = UploadDir + "/" + m_FileNm;
			String m_Content = multi.getParameter("OPContentInsert");
			
			System.out.println(m_GB);
			System.out.println(m_No);
			System.out.println(m_FileNm);
			System.out.println(m_FilePath);
			System.out.println(m_Content);
			
//			this.M_PJTNo = m_PJTNo;
			this.M_GB = m_GB;
			this.M_No = m_No;
			this.M_FileNm = m_FileNm;
			this.M_FilePath = m_FilePath;
			this.M_Content = m_Content;
			
			Connection conn = MySQLConnect.getMySQLConnection();
			String sql = "INSERT INTO MA_Output (PJTNo, FormGB, FormNo, FileNm, FilePath, FileVer, OPContent, InsertNm, InsertDt, DeleteYN) SELECT ?, ?, ?, ?, ?, (SELECT IFNULL(MAX(FileVer) + 0.1, 1.0) FROM MA_Output WHERE PJTNo = ? AND FormGB = ? AND FormNo = ?), ?, ?, NOW(), FALSE";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, 158);
			pstmt.setInt(2, M_GB);
			pstmt.setInt(3, M_No);
			pstmt.setString(4, M_FileNm);
			pstmt.setString(5, M_FilePath);
			pstmt.setInt(6, M_PJTNo);
			pstmt.setInt(7, M_GB);
			pstmt.setInt(8, M_No);
			pstmt.setString(9, M_Content);
			pstmt.setString(10, "Admin");
			pstmt.executeUpdate();
			
			pstmt.close();
			conn.close();
		}
		catch (Exception e)
		{
			System.out.println(("MultipartRequestFileUpload Error : " + e));
		}
		
		return b;
	}
}