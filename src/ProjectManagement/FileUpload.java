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
	String M_Cd;
	String M_FileNm;
	String M_FilePath;
	float M_FileVer;
	String M_Remark;
	String M_Content;
	String M_Price;
	int FileSize = 10 * 1024 * 1024;
	
	// 양식 파일 업로드 (신규)
	public boolean FormInset(HttpServletRequest request)
	{
		boolean b = true;
		
		try
		{
			request.setCharacterEncoding("UTF-8");
			
			// 저장 위치 설정
			String UploadDir = request.getServletContext().getRealPath("OutputForm");
			UploadDir = UploadDir.replace('\\', '/');
			java.io.File targetDir = new java.io.File(UploadDir);
			
			if (!targetDir.exists()) {targetDir.mkdirs();}
			
			// MultipartRequest 객체 생성
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

	// 양식 파일 업로드 (수정)
	public boolean FormUpdate(HttpServletRequest request)
	{
		boolean b = true;
		
		try
		{
			request.setCharacterEncoding("UTF-8");
			
			// 저장 위치 설정
			String UploadDir = request.getServletContext().getRealPath("OutputForm");
			UploadDir = UploadDir.replace('\\', '/');
			java.io.File targetDir = new java.io.File(UploadDir);
			
			if (!targetDir.exists()) {targetDir.mkdirs();}
			
			// MultipartRequest 객체 생성
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

	// 산출물 파일 업로드 (신규)
	public boolean OutputFileUpload(HttpServletRequest request)
	{
		boolean b = true;
		
		try
		{
			request.setCharacterEncoding("UTF-8");
			
			// 저장 위치 설정
			String UploadDir = request.getServletContext().getRealPath("Output") + "\\" + "158";// request.getParameter("PJTNo");
			UploadDir = UploadDir.replace('\\', '/');
			java.io.File targetDir = new java.io.File(UploadDir);
			
			if (!targetDir.exists()) {targetDir.mkdirs();}
			
			// MultipartRequest 객체 생성
			MultipartRequest multi = new MultipartRequest(request, UploadDir, FileSize, "UTF-8", new DefaultFileRenamePolicy());
			
			// FormGB : 문서 1, 산출물 2, 비용 3
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
			String sql =	"INSERT INTO MA_Output (PJTNo, FormGB, FormNo, FileNm, FilePath, FileVer, OPContent, InsertNm, InsertDt, DeleteYN) " +
								"SELECT ?, ?, ?, ?, ?, (SELECT IFNULL(MAX(FileVer) + 0.1, 1.0) FROM MA_Output WHERE PJTNo = ? AND FormGB = ? AND FormNo = ?), ?, ?, NOW(), FALSE";
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

	// 산출물 파일 업로드 (신규)
	public boolean CostFileUpload(HttpServletRequest request)
	{
		boolean b = true;
		
		try
		{
			request.setCharacterEncoding("UTF-8");
			
			// 저장 위치 설정
			String UploadDir = request.getServletContext().getRealPath("Cost") + "\\" + "160";// request.getParameter("PJTNo");
			UploadDir = UploadDir.replace('\\', '/');
			java.io.File targetDir = new java.io.File(UploadDir);
			
			if (!targetDir.exists()) {targetDir.mkdirs();}
			
			// MultipartRequest 객체 생성
			MultipartRequest multi = new MultipartRequest(request, UploadDir, FileSize, "UTF-8", new DefaultFileRenamePolicy());
			
			// FormGB : 문서 1, 산출물 2, 비용 3
			// CostGB : 구매품의서 0, 지출결의서 1
			// int m_PJTNo = Integer.parseInt(request.getParameter("PJTNo"));
			int m_GB = Integer.parseInt(multi.getParameter("CostGB"));
			String m_Nm = multi.getParameter("CostNm");
			String m_Cd = multi.getParameter("CostCd");
			String m_FileNm = multi.getParameter("CoFileNm");
			String m_FilePath = UploadDir + "/" + m_FileNm;
			String m_Content = multi.getParameter("CostContent");
			String m_Price = multi.getParameter("CostPrice");
			
			System.out.println(m_GB);
			System.out.println(m_Nm);
			System.out.println(m_Cd);
			System.out.println(m_FileNm);
			System.out.println(m_FilePath);
			System.out.println(m_Content);
			System.out.println(m_Price);
			
//			this.M_PJTNo = m_PJTNo;
			this.M_GB = m_GB;
			this.M_Nm = m_Nm;
			this.M_Cd = m_Cd;
			this.M_FileNm = m_FileNm;
			this.M_FilePath = m_FilePath;
			this.M_Content = m_Content;
			this.M_Price = m_Price;
			
			Connection conn = MySQLConnect.getMySQLConnection();
			String sql =	"INSERT INTO MA_Cost (PJTNo, CostType, CostCd, CostNm, CostFileNm, CostFilePath, CostContent, ApprovalCnt, InsertUserID, InsertDt, CostUse) " +
								"VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, NOW(), ?)";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, 160);
			pstmt.setInt(2, M_GB);
			pstmt.setString(3, M_Cd);
			pstmt.setString(4, M_Nm);
			pstmt.setString(5, M_FileNm);
			pstmt.setString(6, M_FilePath);
			pstmt.setString(7, M_Content);
			pstmt.setInt(8, 0);
			pstmt.setString(9, "Admin");
			pstmt.setString(10, M_Price);
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