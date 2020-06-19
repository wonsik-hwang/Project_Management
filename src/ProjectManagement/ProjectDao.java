package ProjectManagement;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import java.util.ArrayList;
import java.util.List;

public class ProjectDao {
	private static ProjectDao instance = new ProjectDao();

	public static ProjectDao getInstance() {
		return instance;
	}
	
	public int remove_participants(String num){
		int ri = 0 ;
		
		String name ="";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet result = null;
		
		try{
			StringBuffer sb1 = new StringBuffer();
			StringBuffer sb2 = new StringBuffer();
			
			conn = this.getConnection();
			////////////////////////////////////////////////////////////////////
			sb1.append("select name from members where member_num='"+num+"'");
			pstmt = conn.prepareStatement(sb1.toString());
			result = pstmt.executeQuery();
			if(result.next()){
				name = result.getString("name");
			}
			pstmt.close();
			
			///////////////////////////////////////////////////////////////////////////////
			sb2.append("update project set participants=replace(participants,'"+name+"','"+""+"')");
			pstmt = conn.prepareStatement(sb2.toString());
			pstmt.executeUpdate();
			pstmt.close();
			System.out.println("success");
			/////////////////////////////////////////////////////////////////////////////////
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			System.out.println("fail");
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
	
	public List<ProjectDto> getprj_name(int user_num) {
		List<ProjectDto> list = new ArrayList<ProjectDto>();
		Connection connection = null;
		PreparedStatement pstmt = null;
		ResultSet set = null;
		String query = "SELECT  project.prj_name, project.prj_num, project.cp_code"
				+ " FROM project"
				+ " LEFT JOIN project_participants pp ON project.prj_num = pp.prj_num"
				+ " WHERE end_date>=curdate() + 0 "
				+ " AND pp.participant = "+user_num
				+ " ORDER by project.cp_code, project.prj_name asc";

		try {
			connection = getConnection();
			pstmt = connection.prepareStatement(query);

			set = pstmt.executeQuery();
			while (set.next()) {
				ProjectDto dto = new ProjectDto();

				dto.setPrj_name(set.getString("prj_name"));
				dto.setPrj_num(set.getInt("prj_num"));
				dto.setCP_code(set.getString("cp_code"));

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
	
	public int delete_member_test(){
		int re =0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		String query = "update project set participants=replace(participants,'"+"bbb"+"','"+""+"')";
		
		try{
			conn = getConnection();
			pstmt = conn.prepareStatement(query);
			pstmt.executeUpdate();
			System.out.println("success");
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			System.out.println("fail");
		}
		
		
		return re;
	}

	public int changeProject(ProjectDto dto, String num) {
		int ri = 0;

		Connection connection = null;
		PreparedStatement pstmt = null;
		String query = "update project set prj_change=? where prj_num=?";
		try {
			connection = getConnection();
			pstmt = connection.prepareStatement(query);
			
				pstmt.setInt(1, 2);
				pstmt.setString(2, num);
				pstmt.executeUpdate();
			
			ri = 1;

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

		return ri;
	}
	
	public int change2Project(ProjectDto dto, String num) {
		int ri = 0;

		Connection connection = null;
		PreparedStatement pstmt = null;
		String query = "update project set prj_change=? where prj_num=?";
		try {
			connection = getConnection();
			pstmt = connection.prepareStatement(query);
			
				pstmt.setInt(1, 1);
				pstmt.setString(2, num);
				pstmt.executeUpdate();
			
			ri = 1;

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

		return ri;
	}
	
	public List<ProjectDto> participation_prj_name(String name) {
		List<ProjectDto> list = new ArrayList<ProjectDto>();
		Connection connection = null;
		PreparedStatement pstmt = null;
		ResultSet set = null;
		String query = "SELECT prj_name FROM project where participants like '%"+name+"%'";

		try {
			connection = getConnection();
			pstmt = connection.prepareStatement(query);
			
			set = pstmt.executeQuery();
			while (set.next()) {
				ProjectDto dto = new ProjectDto();
				
				
				dto.setPrj_name(set.getString("prj_name"));
				
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

	public int deleteProject(ProjectDto dto) {
		int rowCount = 0;
		Connection connection = null;
		PreparedStatement pstmt = null;

		String query = "DELETE FROM project WHERE prj_num=?";
		try {
			connection = this.getConnection();
			pstmt = connection.prepareStatement(query);
			pstmt.setInt(1, dto.getPrj_num());
			rowCount = pstmt.executeUpdate();
			System.out.println("project delete success");
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("project delete fail");
		}
		try {
			pstmt.close();
			connection.close();
		} catch (Exception e2) {
			e2.printStackTrace();
		}
		return rowCount;
	}

	public int insertProject(ProjectDto dto) {
		ResultSet rs = null;
		int aIkey = 0;

		Connection connection = null;
		PreparedStatement pstmt = null;
		String query = "insert into project values (?,?,?,?,?,?,?,?,sysdate(),?,?,?,?,?,?,?,?)";

		try {
			connection = getConnection();
			pstmt = connection.prepareStatement(query, PreparedStatement.RETURN_GENERATED_KEYS);

			pstmt.setInt(1, dto.getPrj_num());
			pstmt.setString(2, "123");
			pstmt.setString(3, dto.getPrj_name());
			pstmt.setString(4, dto.getYear_s() + dto.getMonth_s() + dto.getDay_s());
			pstmt.setString(5, dto.getYear_e() + dto.getMonth_e() + dto.getDay_e());
			pstmt.setString(6, dto.getContents());
			pstmt.setString(7, dto.getCP_code());
			pstmt.setInt(8, dto.getEmp_pm());
			pstmt.setString(9, dto.getUser_name());
			pstmt.setString(10, dto.getParticipants());
			pstmt.setInt(11, 1);
			pstmt.setInt(12, dto.getApproval_line1());
			pstmt.setInt(13, dto.getApproval_line2());
			pstmt.setInt(14, dto.getApproval_line3());
			pstmt.setInt(15, dto.getApproval_line4());
			pstmt.setInt(16, dto.getApproval_line5());

			pstmt.executeUpdate();
			rs = pstmt.getGeneratedKeys();
			aIkey = rs.next() ? rs.getInt(1) : null; 
			
			System.out.println("project insert success");

		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("project insert fail");

		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (connection != null)
					connection.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return aIkey;
	}

	public int check_cnt(int count_num) {
		Connection conn = null;
		Statement statement;
		ResultSet resultSet;
		String query = "select count(*) from project";

		try {
			conn = this.getConnection();
			statement = conn.createStatement();
			resultSet = statement.executeQuery(query);
			while (resultSet.next()) {

				count_num = resultSet.getInt("count(*)");
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		try {

			conn.close();
		} catch (Exception e2) {
			e2.printStackTrace();
		}

		return count_num;
	}

	public List<ProjectDto> selectProjectDtoListPerPage() {
		List<ProjectDto> list = new ArrayList<ProjectDto>();
		Connection connection = null;
		PreparedStatement pstmt = null;
		ResultSet set = null;
		String query = "SELECT prj_num, prj_name, cp_code, make_date, end_date, user_name, prj_change, participants, approval_line1, approval_line2, approval_line3, approval_line4, approval_line5, curdate()+0 as now FROM project ORDER BY prj_num";

		try {
			connection = getConnection();
			pstmt = connection.prepareStatement(query);
			
			set = pstmt.executeQuery();
			while (set.next()) {
				ProjectDto dto = new ProjectDto();

				dto.setPrj_num(set.getInt("prj_num"));
				dto.setPrj_name(set.getString("prj_name"));
				dto.setCP_code(set.getString("cp_code"));
				dto.setMake_date(set.getString("make_date"));
				dto.setUser_name(set.getString("user_name"));
				dto.setParticipants(set.getString("participants"));
				dto.setApproval_line1(set.getInt("approval_line1"));
				dto.setApproval_line2(set.getInt("approval_line2"));
				dto.setApproval_line3(set.getInt("approval_line3"));
				dto.setApproval_line4(set.getInt("approval_line4"));
				dto.setApproval_line5(set.getInt("approval_line5"));
				
				if(Integer.valueOf(set.getString("end_date"))>=Integer.valueOf(set.getString("now"))){
				    dto.setPrj_change(1); // 진행
				} else {
				    dto.setPrj_change(2); // 완료
				}


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

	public List<ProjectDto> getEmp_pm() {
		List<ProjectDto> list = new ArrayList<ProjectDto>();
		Connection connection = null;
		PreparedStatement pstmt = null;
		ResultSet set = null;
		String query = "SELECT count(if(emp_pm=?, emp_pm, null)) from project";

		try {
			connection = getConnection();
			pstmt = connection.prepareStatement(query);

			set = pstmt.executeQuery();
			while (set.next()) {
				ProjectDto dto = new ProjectDto();

				dto.setEmp_pm(set.getInt("emp_pm"));

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

	
	public List<ProjectDto> user_name() {
		List<ProjectDto> list = new ArrayList<ProjectDto>();
		Connection connection = null;
		PreparedStatement pstmt = null;
		ResultSet set = null;
		String query = "SELECT members.name, CONCAT(IFNULL((SELECT emp_no FROM employee_info WHERE employee_info.member_num = members.member_num), '없음')) emp_no"
				+ " FROM members"
				+ " LEFT JOIN employee_info"
				+ " ON (members.member_num = employee_info.member_num)"
				+ " WHERE employee_info.emp_no IS NOT NULL"
				+ " ORDER BY members.name";

		try {
			connection = getConnection();
			pstmt = connection.prepareStatement(query);

			set = pstmt.executeQuery();
			while (set.next()) {
				ProjectDto dto = new ProjectDto();
				dto.setParticipants(set.getString("name"));
				dto.setEmp_no(set.getString("emp_no"));
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

	public int ListupdateProject(ProjectDto dto, String num) {
		int ri = 0;

		Connection connection = null;
		PreparedStatement pstmt = null;
		String query = "update project set emp_pm=? where prj_num=?";

		try {
			connection = getConnection();
			pstmt = connection.prepareStatement(query);
			pstmt.setInt(1, dto.getEmp_pm());
			pstmt.setString(2, num);
			pstmt.executeUpdate();
			ri = 1;

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

		return ri;
	}

	public ProjectDto getProject(String num) {   
		Connection connection = null;
		PreparedStatement pstmt = null;
		ResultSet set = null;

		String query = "select (select name from members where member_num = approval_line1) apprlineName1,"
				+ " (select name from members where member_num = approval_line2) apprlineName2,"
				+ " (select name from members where member_num = approval_line3) apprlineName3,"
				+ " (select name from members where member_num = approval_line4) apprlineName4,"
				+ " (select name from members where member_num = approval_line5) apprlineName5,"
				+ " prj_num,prj_name,emp_pm,cp_code,make_date,start_date,end_date,user_name,contents,participants,prj_change,"
				+ " approval_line1,approval_line2,approval_line3,approval_line4,approval_line5,"
				+ " (select name from members where member_num = project.emp_pm) pmName,"
				+ " (select emp_no from employee_info where member_num = project.emp_pm) pmEmpno,"
				+ " curdate()+0 as now"
				+ " from project where prj_num = ?";
		ProjectDto dto = null;

		try {
			connection = getConnection();
			pstmt = connection.prepareStatement(query);
			pstmt.setString(1, num);
			set = pstmt.executeQuery();

			if (set.next()) {
				dto = new ProjectDto();
				dto.setPrj_num(set.getInt("prj_num"));
				dto.setPrj_name(set.getString("prj_name"));
				dto.setEmp_pm(set.getInt("emp_pm"));
				dto.setPmName(set.getString("pmName"));
				dto.setCP_code(set.getString("cp_code"));
				dto.setMake_date(set.getString("make_date"));
				dto.setStart_date(set.getString("start_date"));
				dto.setEnd_date(set.getString("end_date"));
				dto.setUser_name(set.getString("user_name"));
				dto.setContents(set.getString("contents"));
				dto.setParticipants(set.getString("participants"));
				dto.setApproval_line1(set.getInt("approval_line1"));
				dto.setApproval_line2(set.getInt("approval_line2"));
				dto.setApproval_line3(set.getInt("approval_line3"));
				dto.setApproval_line4(set.getInt("approval_line4"));
				dto.setApproval_line5(set.getInt("approval_line5"));
				dto.setApprline_name1(set.getString("apprlineName1"));
				dto.setApprline_name2(set.getString("apprlineName2"));
				dto.setApprline_name3(set.getString("apprlineName3"));
				dto.setApprline_name4(set.getString("apprlineName4"));
				dto.setApprline_name5(set.getString("apprlineName5"));
				dto.setEmp_no(set.getString("pmEmpno"));
				
                if(Integer.valueOf(set.getString("end_date"))>=Integer.valueOf(set.getString("now"))){
                    dto.setPrj_change(1); // 진행
                } else {
                    dto.setPrj_change(2); // 완료
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

		return dto;
	}

	public int updateProject(ProjectDto dto) {
		int ri = 0;

		Connection connection = null;
		PreparedStatement pstmt = null;
		String query = "update project set prj_name=?, start_date=?, end_date=?, emp_pm=?, cp_code=?, contents=?, participants=?, approval_line1=?, approval_line2=?, approval_line3=?, approval_line4=?, approval_line5=?  where prj_num=?";

		try {
			connection = getConnection();
			pstmt = connection.prepareStatement(query);
			System.out.println(dto.getApproval_line1());
			System.out.println(dto.getApproval_line2());
			System.out.println(dto.getApproval_line3());
			System.out.println(dto.getApproval_line4());
			System.out.println(dto.getApproval_line5());

			pstmt.setString(1, dto.getPrj_name());
			pstmt.setString(2, dto.getYear_s() + dto.getMonth_s() + dto.getDay_s());
			pstmt.setString(3, dto.getYear_e() + dto.getMonth_e() + dto.getDay_e());
			pstmt.setInt(4, dto.getEmp_pm());
			pstmt.setString(5, dto.getCP_code());
			pstmt.setString(6, dto.getContents());
			pstmt.setString(7, dto.getParticipants());
			pstmt.setInt(8, dto.getApproval_line1());
			pstmt.setInt(9, dto.getApproval_line2());
			pstmt.setInt(10, dto.getApproval_line3());
			pstmt.setInt(11, dto.getApproval_line4());
			pstmt.setInt(12, dto.getApproval_line5());
			pstmt.setInt(13, dto.getPrj_num());
			pstmt.executeUpdate();
			ri = 1;

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

		return ri;
	}

	private Connection getConnection() {

		Context context = null;
		DataSource dataSource = null;
		Connection connection = null;
		try {
			context = new InitialContext();
			dataSource = (DataSource) context.lookup("java:comp/env/jdbc/hidata");
			connection = dataSource.getConnection();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return connection;
	}

	public int selectTotalProjectDtoCount() {
		int rowCount = 0;
		Connection connection = null;
		PreparedStatement pstmt = null;
		ResultSet set = null;
		String sql = "SELECT COUNT(*) FROM project";
		try {
			connection = this.getConnection();
			pstmt = connection.prepareStatement(sql);
			set = pstmt.executeQuery();
			if (set.next()) {
				rowCount = set.getInt(1);
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
		return rowCount;
	}
	
/*	public ProjectDto getProject_aline(String target_date, String user_name, String prj_name ) {
		Connection connection = null;
		PreparedStatement pstmt = null;
		ResultSet set = null;

		String query = "select *, curdate()+0 as now from project where target_date=? and user_name=? and prj_name = ?";
		ProjectDto dto = null;

		try {
			connection = getConnection();
			pstmt = connection.prepareStatement(query);
			pstmt.setString(1, target_date);
			pstmt.setString(2, user_name);
			pstmt.setString(3, prj_name);
			set = pstmt.executeQuery();

			if (set.next()) {
				dto = new ProjectDto();
				dto.setPrj_num(set.getInt("prj_num"));
				dto.setPrj_name(set.getString("prj_name"));
				dto.setEmp_pm(set.getInt("emp_pm"));
				dto.setCP_code(set.getString("cp_code"));
				dto.setMake_date(set.getString("make_date"));
				dto.setStart_date(set.getString("start_date"));
				dto.setEnd_date(set.getString("end_date"));
				dto.setUser_name(set.getString("user_name"));
				dto.setContents(set.getString("contents"));
				dto.setParticipants(set.getString("participants"));
				dto.setApproval_line1(set.getInt("approval_line1"));
				dto.setApproval_line2(set.getInt("approval_line2"));
				dto.setApproval_line3(set.getInt("approval_line3"));
				dto.setApproval_line4(set.getInt("approval_line4"));
				dto.setApproval_line5(set.getInt("approval_line5"));
				
                if(Integer.valueOf(set.getString("end_date"))>=Integer.valueOf(set.getString("now"))){
                    dto.setPrj_change(1); // 진행
                } else {
                    dto.setPrj_change(2); // 완료
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

		return dto;
	}
*/	
	public List<ProjectDto> getprj_num_onGoing() {
		List<ProjectDto> list = new ArrayList<ProjectDto>();
		Connection connection = null;
		PreparedStatement pstmt = null;
		ResultSet set = null;
		String query = "SELECT  prj_num, prj_name, cp_code FROM project where end_date>=curdate() + 0 order by cp_code asc, prj_name asc";

		try {
			connection = getConnection();
			pstmt = connection.prepareStatement(query);

			set = pstmt.executeQuery();
			while (set.next()) {
				ProjectDto dto = new ProjectDto();

				dto.setPrj_num(set.getInt("prj_num"));
				dto.setPrj_name(set.getString("prj_name"));
				dto.setCP_code(set.getString("cp_code"));

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
	
	public ProjectDto getApprLine(int prj_num) {
		Connection connection = null;
		PreparedStatement pstmt = null;
		ResultSet set = null;

		/*
		 * String query = "select " + " select name from members where member_num = "
		 * 
		 * + " from project where prj_name = '"+prj_name+"'";
		 */
		
		
		
		String query = "SELECT (select name from members where member_num = approval_line1) apprlineName1,"
		+" (select name from members where member_num = approval_line2) apprlineName2,"
		+" (select name from members where member_num = approval_line3) apprlineName3,"
		+" (select name from members where member_num = approval_line4) apprlineName4,"
		+" (select name from members where member_num = approval_line5) apprlineName5,"
		+ " approval_line1,approval_line2,approval_line3,approval_line4,approval_line5"
		+ " FROM project where prj_num = "+prj_num;
		ProjectDto dto = null;

		try {
			connection = getConnection();
			pstmt = connection.prepareStatement(query);
			set = pstmt.executeQuery();

			if (set.next()) {
				dto = new ProjectDto();
				dto.setApprline_name1(set.getString("apprlineName1"));
				dto.setApprline_name2(set.getString("apprlineName2"));
				dto.setApprline_name3(set.getString("apprlineName3"));
				dto.setApprline_name4(set.getString("apprlineName4"));
				dto.setApprline_name5(set.getString("apprlineName5"));
				dto.setApproval_line1(set.getInt("approval_line1"));
				dto.setApproval_line2(set.getInt("approval_line2"));
				dto.setApproval_line3(set.getInt("approval_line3"));
				dto.setApproval_line4(set.getInt("approval_line4"));
				dto.setApproval_line5(set.getInt("approval_line5"));
				
				

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

	public int apprline_cnt(int prj_num) {
		Connection conn = null;

		Statement statement = null;
		ResultSet resultSet = null;

		int count_num = 0;

		String query = "select approval_line1,approval_line2,approval_line3,approval_line4,approval_line5 from project where prj_num = "+prj_num+"";

		try {
			conn = this.getConnection();
			statement = conn.createStatement();
			resultSet = statement.executeQuery(query);
			
			if (resultSet.next()) {
			
			if(resultSet.getInt("approval_line1")!=0) {
			   count_num++; }
			if(resultSet.getInt("approval_line2")!=0) {
               count_num++; }
			if(resultSet.getInt("approval_line3")!=0) {
               count_num++; }
			if(resultSet.getInt("approval_line4")!=0) {
               count_num++; }
			if(resultSet.getInt("approval_line5")!=0) {
               count_num++; }
			}
		

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				resultSet.close();
				statement.close();
				conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}

		return count_num;
	}
	
	public List<ProjectDto>getprj_nameReferer(int member_num) {
		List<ProjectDto> list = new ArrayList<ProjectDto>();
		Connection connection = null;
		PreparedStatement pstmt = null;
		ResultSet set = null;
		String query = "SELECT j.prj_name, j.prj_num, p.cp_code FROM journal_s j "
				+ " left outer join project p on j.prj_num=p.prj_num "
				+ " left outer join journal_referers r on j.num = r.journal_num"
				+ " where p.end_date>=curdate() + 0 and r.referer like ?"
				+ " group by prj_name order by p.cp_code asc,  j.prj_name asc";

		try {
			connection = getConnection();
			pstmt = connection.prepareStatement(query);
			pstmt.setInt(1, member_num);
			set = pstmt.executeQuery();
			while (set.next()) {
				ProjectDto dto = new ProjectDto();

				dto.setPrj_name(set.getString("prj_name"));
				dto.setPrj_num(set.getInt("prj_num"));
				dto.setCP_code(set.getString("cp_code"));

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
	
	public List<ProjectDto> getMyProjectList(int member_num){
		List<ProjectDto> list = new ArrayList<ProjectDto>();
		Connection connection = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String query = "SELECT prj_num,prj_code,prj_name,start_date,end_date,contents,cp_code,emp_pm,make_date,user_name,prj_change,approval_line1,approval_line2,approval_line3,approval_line4,approval_line5,curdate()+0 as now"
				+ " FROM project"
				+ " WHERE prj_num IN ("
				+ "    SELECT prj_num FROM project_participants WHERE participant = ?"
				+ ") AND end_date>=curdate() + 0";

		try {
			connection = getConnection();
			pstmt = connection.prepareStatement(query);
			pstmt.setInt(1, member_num);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				ProjectDto dto = new ProjectDto();

				dto.setPrj_num(rs.getInt("prj_num"));
				dto.setPrj_code("prj_code");
				dto.setPrj_name(rs.getString("prj_name"));
				dto.setEmp_pm(rs.getInt("emp_pm"));
				dto.setCP_code(rs.getString("cp_code"));
				dto.setMake_date(rs.getString("make_date"));
				dto.setStart_date(rs.getString("start_date"));
				dto.setEnd_date(rs.getString("end_date"));
				dto.setUser_name(rs.getString("user_name"));
				dto.setContents(rs.getString("contents"));
				dto.setApproval_line1(rs.getInt("approval_line1"));
				dto.setApproval_line2(rs.getInt("approval_line2"));
				dto.setApproval_line3(rs.getInt("approval_line3"));
				dto.setApproval_line4(rs.getInt("approval_line4"));
				dto.setApproval_line5(rs.getInt("approval_line5"));
				
                if(Integer.valueOf(rs.getString("end_date"))>=Integer.valueOf(rs.getString("now"))){
                    dto.setPrj_change(1); // 진행
                } else {
                    dto.setPrj_change(2); // 완료
                }

				list.add(dto);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				rs.close();
				pstmt.close();
				connection.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return list;
	}
	
	public String getCp_code(int prj_num){
        String re ="";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        String query = "select cp_code from project where prj_num=?";
        
        try{
            conn = getConnection();
            pstmt = conn.prepareStatement(query);
            pstmt.setInt(1, prj_num);
            rs = pstmt.executeQuery();
            if(rs.next()){
                re=rs.getString("cp_code");
            }
        }catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                rs.close();
                pstmt.close();
                conn.close();
            } catch (Exception e2) {
                e2.printStackTrace();
            }
        }
        return re;
    }
	
	public List<ProjectDto> getprj_nameModify(int user_num, int journal_num) {
        List<ProjectDto> list = new ArrayList<ProjectDto>();
        Connection connection = null;
        PreparedStatement pstmt = null;
        ResultSet set = null;
        String query = "SELECT  project.prj_name, project.prj_num, project.cp_code"
                + " FROM project"
                + " LEFT JOIN (select num, prj_num from journal_s where num="+journal_num+") j ON project.prj_num = j.prj_num"
                + " LEFT JOIN project_participants pp ON project.prj_num = pp.prj_num"
                + " WHERE j.num="+ journal_num + " or (project.end_date>=curdate() + 0"
                + " AND pp.participant = "+user_num+")"
                + " GROUP BY prj_num ORDER by project.cp_code, project.prj_name asc";

        try {
            connection = getConnection();
            pstmt = connection.prepareStatement(query);

            set = pstmt.executeQuery();
            while (set.next()) {
                ProjectDto dto = new ProjectDto();

                dto.setPrj_name(set.getString("prj_name"));
                dto.setPrj_num(set.getInt("prj_num"));
                dto.setCP_code(set.getString("cp_code"));

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
	
	
	   public List<ProjectDto>getprj_nameEnded(int member_num, String position) {
	        List<ProjectDto> list = new ArrayList<ProjectDto>();
	        Connection connection = null;
	        PreparedStatement pstmt = null;
	        ResultSet set = null;
	        String query = "SELECT j.prj_name, j.prj_num, p.cp_code FROM journal_s j"
	                + " left outer join project p on j.prj_num=p.prj_num "
	                + " LEFT JOIN project_participants pp ON p.prj_num = pp.prj_num"
	                + " where p.end_date<=curdate() + 0";
	                
	                if(!position.equals("1")) query += " and pp.participant = ?";
	                
	                query += " group by prj_name order by p.cp_code asc,  j.prj_name asc";

	        try {
	            connection = getConnection();
	            pstmt = connection.prepareStatement(query);
	            if(!position.equals("1")) pstmt.setInt(1, member_num);
	            set = pstmt.executeQuery();
	            while (set.next()) {
	                ProjectDto dto = new ProjectDto();

	                dto.setPrj_name(set.getString("prj_name"));
	                dto.setPrj_num(set.getInt("prj_num"));
	                dto.setCP_code(set.getString("cp_code"));

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
}
