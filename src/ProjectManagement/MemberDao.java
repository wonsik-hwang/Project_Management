package ProjectManagement;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.mysql.jdbc.exceptions.jdbc4.MySQLDataException;

public class MemberDao {

	public static final int MEMBER_NONEXISTENT  = 0;
	public static final int MEMBER_EXISTENT = 1;
	public static final int MEMBER_JOIN_FAIL = 0;
	public static final int MEMBER_JOIN_SUCCESS = 1;
	public static final int MEMBER_LOGIN_PW_NO_GOOD = 0;
	public static final int MEMBER_LOGIN_SUCCESS = 1;
	public static final int MEMBER_LOGIN_IS_NOT = -1;
	
	private static MemberDao instance = new MemberDao();
	
	
	public static MemberDao getInstance(){
		return instance;
	}
	
	public int join_success_prj_update(String user_name){
		int ri=0;
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		String query = "update project set participants = concat(participants,?) where prj_num=?";
		
		try{
			conn = getConnection();
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, " "+user_name);
			pstmt.setInt(2, 1);
			pstmt.executeUpdate();
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}finally {
			try{
				pstmt.close();
				conn.close();
			}catch (Exception e2) {
				// TODO: handle exception
				e2.printStackTrace();
			}
		}
		return ri;
	}
	
	public int insertMember(MemberDto dto) {
		int ri = 0;
		
		Connection connection = null;
		PreparedStatement pstmt = null;
		
		
		String query = "insert into members values (?,?,?,?,?,?,?,?,?)";
		
		try {
			connection = getConnection();
			pstmt = connection.prepareStatement(query);
			
			pstmt.setInt(1, dto.getMember_num());
			pstmt.setString(2, dto.getId());
			pstmt.setString(3, dto.getPw());
			pstmt.setString(4, dto.getName());
			pstmt.setString(5, dto.geteMail());
			pstmt.setTimestamp(6, dto.getrDate());
			pstmt.setString(7, dto.getBirthday());
			pstmt.setString(8, dto.getPosition());
			pstmt.setString(9, dto.getRank());
			
			pstmt.executeUpdate();
			ri = MemberDao.MEMBER_JOIN_SUCCESS;
			System.out.println("member insert success");
			System.out.println(dto.getRank());
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("member insert fail");
		} finally {
			try {
				if(pstmt != null) pstmt.close();
				if(connection != null) connection.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		
		return ri;
	}
	
	public List<MemberDto> user_name() {
		List<MemberDto> list = new ArrayList<MemberDto>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
//		Connection connection = null;
//		PreparedStatement pstmt = null;
//		ResultSet set = null;
		String sql = "SELECT members.name, CONCAT(IFNULL((SELECT emp_no FROM employee_info WHERE employee_info.member_num = members.member_num), '없음')) emp_no, members.member_num"
				+ " FROM members"
				+ " LEFT JOIN employee_info"
				+ " ON (members.member_num = employee_info.member_num)"
				+ " WHERE employee_info.emp_no IS NOT NULL"
				+ "  AND employee_info.retire_date = ''"
				+ " ORDER BY members.name";

		try {
			conn = MySQLConnect.getMySQLConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
//			connection = getConnection();
//			pstmt = connection.prepareStatement(query);
//			set = pstmt.executeQuery();
			while (rs.next()) {
				MemberDto dto = new MemberDto();
				dto.setName(rs.getString("name"));
				dto.setMember_num(rs.getInt("member_num"));
				dto.setEmp_no(rs.getString("emp_no"));
				list.add(dto);
				
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				MySQLConnect.close(rs);
				MySQLConnect.close(pstmt);
				MySQLConnect.close(conn);
				
//				set.close();
//				pstmt.close();
//				connection.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return list;
	}
	
	
	public int confirmId(String id) {
		int ri = 0;
		
		Connection connection = null;
		PreparedStatement pstmt = null;
		ResultSet set = null;
		String query = "select id from members where id = ?";
		
		try {
			connection = getConnection();
			pstmt = connection.prepareStatement(query);
			pstmt.setString(1, id);
			set = pstmt.executeQuery();
			if(set.next()){
				ri = MemberDao.MEMBER_EXISTENT;
			} else {
				ri = MemberDao.MEMBER_NONEXISTENT;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				set.close();
				pstmt.close();
				connection.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		
		return ri;
	}
	
	public int userCheck( String id, String pw) {
		int ri = 0;
		
		String dbPw;
		
		Connection connection = null;
		PreparedStatement pstmt = null;
		ResultSet set = null;
		String query = "select pw from members where id = ?";
		
		try {
			connection = getConnection();
			pstmt = connection.prepareStatement(query);
			
			pstmt.setString(1, id);
			set = pstmt.executeQuery();
			
			if(set.next()) {
				dbPw = set.getString("pw");
				if(dbPw.equals(pw)) {
					ri = MemberDao.MEMBER_LOGIN_SUCCESS;
				} else {
					ri = MemberDao.MEMBER_LOGIN_PW_NO_GOOD;
				}
			} else {
				ri = MemberDao.MEMBER_LOGIN_IS_NOT;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				set.close();
				pstmt.close();
				connection.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return ri;
	}
	
	public int approval_pwCheck(String user_name, String pw) {
		int ri = 0;
		
		String dbPw;
		
		Connection connection = null;
		PreparedStatement pstmt = null;
		ResultSet set = null;
		String query = "select pw from members where name = ?";
		
		try {
			connection = getConnection();
			pstmt = connection.prepareStatement(query);
			
			pstmt.setString(1, user_name);
			set = pstmt.executeQuery();
			
			if(set.next()) {
				dbPw = set.getString("pw");
			
				if(dbPw.equals(pw)) {
					ri = 1;
				} else {
					ri = 0;
				}
			} 
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				set.close();
				pstmt.close();
				connection.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return ri;
	}
	
	public MemberDto getMember(String id) {
		Connection connection = null;
		PreparedStatement pstmt = null;
		ResultSet set = null;
		String query = "select * from members where id = ?";
		MemberDto dto = null;
		
		try {
			connection = getConnection();
			pstmt = connection.prepareStatement(query);
			pstmt.setString(1, id);
			set = pstmt.executeQuery();
			
			if(set.next()) {
				dto = new MemberDto();
				dto.setId(set.getString("id"));
				dto.setPw(set.getString("pw"));
				dto.setName(set.getString("name"));
				dto.setPosition(set.getString("position"));
				dto.setRank(set.getString("rank"));
				dto.setMember_num(set.getInt("member_num"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				set.close();
				pstmt.close();
				connection.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		
		return dto;
		
	}
	
	public String getEmail(int member_num) {
		
		String email ="";
		
		Connection connection = null;
		PreparedStatement pstmt = null;
		ResultSet set = null;
		
		String query = "select eMail from members where member_num = "+member_num;
		
		try {
			connection = getConnection();
			pstmt = connection.prepareStatement(query);
			set = pstmt.executeQuery();
			if(set.next()) {
				email = set.getString("eMail");
				System.out.println(email);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				set.close();
				pstmt.close();
				connection.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return email;
	}
	
	public List<MemberDto> select_Member() {

		List<MemberDto> list = new ArrayList<MemberDto>();

		Connection connection = null;
		PreparedStatement pstmt = null;
		ResultSet set = null;

		String query = "select member_num, id, name from members order by member_num";

		try {
			connection = getConnection();
			pstmt = connection.prepareStatement(query);

			set = pstmt.executeQuery();
			while (set.next()) {
				MemberDto dto = new MemberDto();
				dto.setMember_num(set.getInt("member_num"));
				dto.setId(set.getString("id"));
				dto.setName(set.getString("name"));
				
				list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				set.close();
				pstmt.close();
				connection.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}

		return list;
	}
	
	
	public MemberDto getMember_num(String member_num) {
		Connection connection = null;
		PreparedStatement pstmt = null;
		ResultSet set = null;
		String query = "select * from members where member_num = ?";
		MemberDto dto = null;
		
		try {
			connection = getConnection();
			pstmt = connection.prepareStatement(query);
			pstmt.setString(1, member_num);
			set = pstmt.executeQuery();
			
			if(set.next()) {
				dto = new MemberDto();
				dto.setMember_num(set.getInt("member_num"));
				dto.setId(set.getString("id"));
				dto.setName(set.getString("name"));
				dto.seteMail(set.getString("eMail"));
				dto.setBirthday(set.getString("birthday"));
				dto.setPosition(set.getString("position"));
				dto.setRank(set.getString("rank"));
				
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				set.close();
				pstmt.close();
				connection.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		
		return dto;
		
	}
	
	public List<MemberDto> getMember_num() {
		List<MemberDto> list = new ArrayList<MemberDto>();
		Connection connection = null;
		PreparedStatement pstmt = null;
		ResultSet set = null;
		String query = "SELECT member_num, name FROM members ";

		try {
			connection = getConnection();
			pstmt = connection.prepareStatement(query);
			
			set = pstmt.executeQuery();
			while (set.next()) {
				MemberDto dto = new MemberDto();
				
				dto.setMember_num(set.getInt("member_num"));
				dto.setName(set.getString("name"));
				
				list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				set.close();
				pstmt.close();
				connection.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return list;
	}
	
	public MemberDto getMember_2(String num) {
		Connection connection = null;
		PreparedStatement pstmt = null;
		ResultSet set = null;
		String query = "select name, id, pw, eMail, position, rank from members where member_num = ?";
		MemberDto dto = null;
		
		try {
			connection = getConnection();
			pstmt = connection.prepareStatement(query);
			pstmt.setString(1, num);
			set = pstmt.executeQuery();
			
			if(set.next()) {
				dto = new MemberDto();
				dto.setName(set.getString("name"));
				dto.setId(set.getString("id"));
				dto.setPw(set.getString("pw"));
				dto.seteMail(set.getString("eMail"));
				dto.setPosition(set.getString("position"));				
				dto.setRank(set.getString("rank"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				set.close();
				pstmt.close();
				connection.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		
		return dto;
		
	}
	
	public int select_num(String name) {
		
		Connection connection = null;
		PreparedStatement pstmt = null;
		ResultSet set = null;
		int member_num=0;
		
		String query = "select member_num from members where name = '"+name+"'";
		
		
		try {
			connection = getConnection();
			pstmt = connection.prepareStatement(query);
			set = pstmt.executeQuery();
			
			if(set.next()) {
				member_num = set.getInt("member_num");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				set.close();
				pstmt.close();
				connection.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		
		return member_num;
		
	}
	
	public int updateMember(MemberDto dto, String num) {
		int ri = 0;
		
		Connection connection = null;
		PreparedStatement pstmt = null;
		if(dto.getPw() == null){
			String query = "update members set name=?, id=?, eMail=?, position=?, rank=?  where member_num='"+num+"'";
			
			try {
				connection = getConnection();
				pstmt = connection.prepareStatement(query);
				pstmt.setString(1, dto.getName());
				pstmt.setString(2, dto.getId());
				pstmt.setString(3, dto.geteMail());
				pstmt.setString(4, dto.getPosition());
				pstmt.setString(5, dto.getRank());
				
				ri = pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				try {
					pstmt.close();
					connection.close();
				} catch (Exception e2) {
					e2.printStackTrace();
				}
			}
		}else{
			String query = "update members set name=?, id=?, pw=?, eMail=?, position=?, rank=? where member_num='"+num+"'";
			
			try {
				connection = getConnection();
				pstmt = connection.prepareStatement(query);
				pstmt.setString(1, dto.getName());
				pstmt.setString(2, dto.getId());
				pstmt.setString(3, dto.getPw());
				pstmt.setString(4, dto.geteMail());
				pstmt.setString(5, dto.getPosition());
				pstmt.setString(6, dto.getRank());
				
				ri = pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				try {
					pstmt.close();
					connection.close();
				} catch (Exception e2) {
					e2.printStackTrace();
				}
			}
		}
		
		
		return ri;
	}
	
	public int deleteMember(String num, String name) {
		int ri = 0;
		Connection connection = null;
		PreparedStatement pstmt = null;

		/*String query = "DELETE FROM members WHERE member_num='"+num+"'";*/
		try {
			StringBuffer sb1 = new StringBuffer();
			StringBuffer sb2 = new StringBuffer();
			
			sb1.append("delete from members where member_num='"+num+"'");
			sb2.append("delete from journal_s where target_date=20170101 and user_name='"+name+"'");
			
			connection = this.getConnection();
			pstmt = connection.prepareStatement(sb1.toString());
			ri = pstmt.executeUpdate();
			pstmt.close();
			
			pstmt = connection.prepareStatement(sb2.toString());
			ri = pstmt.executeUpdate();
			pstmt.close();
			
			ri=1;
			System.out.println("delete member success");
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("delete member fail");
			
		} finally {
			try {
				pstmt.close();
				connection.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return ri;
	}
	
	
	public String getRank(int member_num) {
		
		String rank ="";
		
		Connection connection = null;
		PreparedStatement pstmt = null;
		ResultSet set = null;
		String query = "select rank from members where member_num = ?";
		
		try {
			connection = getConnection();
			pstmt = connection.prepareStatement(query);
			pstmt.setInt(1, member_num);
			set = pstmt.executeQuery();
			if(set.next()) {
				rank = set.getString("rank");
				System.out.println(rank);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				set.close();
				pstmt.close();
				connection.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return rank;
	}

	public String newCheck() {
	
	String newCheck ="";
	
	Connection connection = null;
	PreparedStatement pstmt = null;
	ResultSet set = null;
	String query = "select * from members where position = 7";
	
	try {
		connection = getConnection();
		pstmt = connection.prepareStatement(query);
		set = pstmt.executeQuery();
		if(set.next()) {
			newCheck = set.getString("position");
			System.out.println(newCheck);
		}
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		try {
			set.close();
			pstmt.close();
			connection.close();
		} catch (Exception e2) {
			e2.printStackTrace();
		}
	}
	return newCheck;
	}
	
	public String newCheck2() {
		
		String newCheck2 ="";
		
		Connection connection = null;
		PreparedStatement pstmt = null;
		ResultSet set = null;
		String query = "select * from members where position = 7";
		
		try {
			connection = getConnection();
			pstmt = connection.prepareStatement(query);
			set = pstmt.executeQuery();
			if(set.next()) {
				newCheck2 = set.getString("position");
				System.out.println(newCheck2);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				set.close();
				pstmt.close();
				connection.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return newCheck2;
		}
	
	
	private Connection getConnection() {
		
		Context context = null;
		DataSource dataSource = null;
		Connection connection = null;
		
		try {
			context = new InitialContext();
			dataSource = (DataSource)context.lookup("java:comp/env/jdbc/hidata");
			connection = dataSource.getConnection();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return connection;
	}
	
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
			System.out.println("MySQL 드라이버가 없습니다.<br/>");
		}
		catch (MySQLDataException e)
		{
			System.out.println("데이터베이스가 없습니다. <br/>");
		}
		catch (SQLException e)
		{
			System.out.println("사용자 계정 또는 비밀번호가 일치하지 않습니다. <br/>");
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