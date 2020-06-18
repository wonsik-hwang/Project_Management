package ProjectManagement;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ProjectNameCheck {
	
	public static boolean NameCheck (String nm)
	{
		Connection conn = MySQLConnect.getMySQLConnection();
		
		String sql = "SELECT mp.`PJNm` FROM MA_Project mp";
		try
		{
			PreparedStatement pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			
			while (rs.next())
			{
				if (rs.getString("PJNm").equals(nm))
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
