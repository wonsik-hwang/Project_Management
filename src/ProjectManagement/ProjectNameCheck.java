package ProjectManagement;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ProjectNameCheck {
	
	public static boolean NameCheck (String nm)
	{
		Connection conn = MySQLConnect.getMySQLConnection();
		
		String sql = "SELECT mp.PJTNm FROM MA_Project mp";
		try
		{
			PreparedStatement pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			
			while (rs.next())
			{
				if (rs.getString("PJTNm").equals(nm))
				{
					MySQLConnect.close(rs);
					MySQLConnect.close(pstmt);
					MySQLConnect.close(conn);
					return true;
				}
			}
			
			MySQLConnect.close(rs);
			MySQLConnect.close(pstmt);
			MySQLConnect.close(conn);

		}
		catch (SQLException e)
		{
			e.printStackTrace();
		}
		
		return false;
	}
	
	public static boolean OutputNameCheck (String nm, int no)
	{
		Connection conn = MySQLConnect.getMySQLConnection();
		
		String sql = "SELECT mo.OPNm FROM MA_Output mo WHERE mo.PJTNo = " + no;
		try
		{
			PreparedStatement pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			
			while (rs.next())
			{
				if (rs.getString("OPNm").equals(nm))
				{
					MySQLConnect.close(rs);
					MySQLConnect.close(pstmt);
					MySQLConnect.close(conn);
					return true;
				}
			}
			
			MySQLConnect.close(rs);
			MySQLConnect.close(pstmt);
			MySQLConnect.close(conn);

		}
		catch (SQLException e)
		{
			e.printStackTrace();
		}
		
		return false;
	}	
}
