package ProjectManagement;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.mysql.jdbc.exceptions.jdbc4.MySQLDataException;

public class MySQLConnect {
	public static Connection getMySQLConnection() {
		Connection conn = null;
		try {
			String url = "jdbc:mysql://192.168.0.71:3306/ProjectManagement";
			String user = "hidata";
			String password = "hidata2312357!";
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(url, user, password);
		}
		catch (ClassNotFoundException e)
		{
			System.out.println("MySQL ����̹��� �����ϴ�.<br/>");
		}
		catch (MySQLDataException e)
		{
			System.out.println("�����ͺ��̽��� �����ϴ�. <br/>");
		}
		catch (SQLException e)
		{
			System.out.println("����� ���� �Ǵ� ��й�ȣ�� ��ġ���� �ʽ��ϴ�. <br/>");
		}
		return conn;
	}
	
//	public static void close (Connection conn)
//	{
//		try
//		{
//			if (conn != null)
//			{
//				conn.close();
//			}
//		}
//		catch (Exception e)
//		{
//			e.printStackTrace();
//		}
//	}
//	
//	public static void close (Statement stmt)
//	{
//		try
//		{
//			if (stmt != null)
//			{
//				stmt.close();
//			}
//		}
//		catch (Exception e)
//		{
//			e.printStackTrace();
//		}
//	}
//
//	public static void close (PreparedStatement pstmt)
//	{
//		try
//		{
//			if (pstmt != null)
//			{
//				pstmt.close();
//			}
//		}
//		catch (Exception e)
//		{
//			e.printStackTrace();
//		}
//	}
//
//	public static void close (ResultSet rs)
//	{
//		try
//		{
//			if (rs != null)
//			{
//				rs.close();
//			}
//		}
//		catch (Exception e)
//		{
//			e.printStackTrace();
//		}
//	}
}