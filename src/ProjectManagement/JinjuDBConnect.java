package ProjectManagement;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.mysql.jdbc.exceptions.jdbc4.MySQLDataException;

public class JinjuDBConnect {
	public static Connection getJinjuDBConnection() {
		Connection conn = null;
		
		try {
			String url = "jdbc:mysql://covit.co.kr:3306/hidataweb?useUnicode=true&characterEncoding=UTF-8";
			String user = "hidataweb";
			String password = "hidata335341";
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
	
	public static void close (Connection conn)
	{
		try
		{
			if (conn != null)
			{
				conn.close();
			}
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
	}
	
	public static void close (Statement stmt)
	{
		try
		{
			if (stmt != null)
			{
				stmt.close();
			}
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
	}

	public static void close (PreparedStatement pstmt)
	{
		try
		{
			if (pstmt != null)
			{
				pstmt.close();
			}
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
	}

	public static void close (ResultSet rs)
	{
		try
		{
			if (rs != null)
			{
				rs.close();
			}
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
	}
}
