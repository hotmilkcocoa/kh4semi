package groupware.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import groupware.util.JdbcUtil;

public class VacationApprovalDao {
	public static final String USER = "groupware";
	public static final String PW = "groupware";

	public void insert(int vac_no, int vac_target_no) throws Exception{
		Connection con = JdbcUtil.getConnection(USER, PW);
		
		String sql = "insert into vacation_approval values(?, (select emp_no from employee where emp_id = (select dep_head from department where dep_name = (select emp_dep from employee where emp_no = ?))), '대기', (select emp_no from employee where emp_dep = '인사부' and emp_title = '팀장'), '대기')";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, vac_no);
		ps.setInt(2, vac_target_no);
		
		ps.execute();
		
		con.close();
	}
	
	public VacationApprovalDto find(int vac_no) throws Exception{
		Connection con = JdbcUtil.getConnection(USER, PW);
		
		String sql = "select * from vacation_approval where vac_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, vac_no);
		ResultSet rs = ps.executeQuery();
		
		VacationApprovalDto vacAppDto = new VacationApprovalDto();
		if(rs.next()) {
			vacAppDto.setVac_no(rs.getInt("vac_no"));
			vacAppDto.setDep_head_no(rs.getInt("dep_head_no"));
			vacAppDto.setDep_head_app(rs.getString("dep_head_app"));
			vacAppDto.setHr_app_no(rs.getInt("hr_app_no"));
			vacAppDto.setHr_app(rs.getString("hr_app"));
		}
		con.close();
		
		return vacAppDto;
	}

	public void cancel(int vac_no) throws Exception{
		Connection con = JdbcUtil.getConnection(USER, PW);
		
		String sql = "delete from vacation_approval where vac_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, vac_no);
		
		ps.execute();
		
		con.close();
	}

	public void signForDephead(int vac_no, String sign) throws Exception{
		Connection con = JdbcUtil.getConnection(USER, PW);
		
		String sql = "update vacation_approval set dep_head_app = ? where vac_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, sign);
		ps.setInt(2, vac_no);
		
		ps.execute();
		
		con.close();
	}

	public void rejectForHrhead(int vac_no) throws Exception{
		Connection con = JdbcUtil.getConnection(USER, PW);
		
		String sql = "update vacation_approval set hr_app = '반려' where vac_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, vac_no);
		
		ps.execute();
		
		con.close();
	}

	public void approveForHrhead(int vac_no) throws Exception{
		Connection con = JdbcUtil.getConnection(USER, PW);
		
		String sql = "update vacation_approval set hr_app = '승인', dep_head_app = '승인' where vac_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, vac_no);
		
		ps.execute();
		
		con.close();
	}

}
