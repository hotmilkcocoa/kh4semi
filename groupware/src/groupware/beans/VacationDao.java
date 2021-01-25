package groupware.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import groupware.util.JdbcUtil;

public class VacationDao {
	public static final String USER = "groupware";
	public static final String PW = "groupware";
	
	public int getSequence() throws Exception{
		Connection con = JdbcUtil.getConnection(USER, PW);
		
		String sql = "select vacation_seq.nextval from dual";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		rs.next();
		int seq = rs.getInt(1);
		
		con.close();
		return seq;
	}

	public void insert(VacationDto vacationDto) throws Exception{
		Connection con = JdbcUtil.getConnection(USER, PW);
		
		String sql = "insert into vacation values("
				+ "?, ?, ?, ?, ?, ?, '대기', sysdate, ?, ?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, vacationDto.getVac_no());
		ps.setString(2, vacationDto.getVac_category());
		ps.setDate(3, vacationDto.getVac_start());
		ps.setDate(4, vacationDto.getVac_end());
		ps.setString(5, vacationDto.getVac_reason());
		ps.setString(6, vacationDto.getVac_comment());
		ps.setInt(7, vacationDto.getVac_writer_no());
		ps.setInt(8, vacationDto.getVac_target_no());
		
		ps.execute();
		
		con.close();
	}
	
	public VacationDto find(int vac_no) throws Exception{
		Connection con = JdbcUtil.getConnection(USER, PW);
		
		String sql = "select * from vacation where vac_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, vac_no);
		ResultSet rs = ps.executeQuery();
		
		VacationDto vacationDto = new VacationDto();
		if(rs.next()) {
			vacationDto.setVac_no(rs.getInt("vac_no"));
			vacationDto.setVac_category(rs.getString("vac_category"));
			vacationDto.setVac_start(rs.getDate("vac_start"));
			vacationDto.setVac_end(rs.getDate("vac_end"));
			vacationDto.setVac_reason(rs.getString("vac_reason"));
			vacationDto.setVac_comment(rs.getString("vac_comment"));
			vacationDto.setVac_status(rs.getString("vac_status"));
			vacationDto.setVac_write_date(rs.getDate("vac_write_date"));
			vacationDto.setVac_writer_no(rs.getInt("vac_writer_no"));
			vacationDto.setVac_target_no(rs.getInt("vac_target_no"));
		}
		
		con.close();
		return vacationDto;
	}

	public List<VacationDto> select(int emp_no) throws Exception{
		Connection con = JdbcUtil.getConnection(USER, PW);
		
		String sql = "select * from vacation where vac_writer_no = ? order by vac_no desc";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, emp_no);
		ResultSet rs = ps.executeQuery();
		
		List<VacationDto> list = new ArrayList<VacationDto>();
		while(rs.next()) {
			VacationDto vacationDto = new VacationDto();
			vacationDto.setVac_no(rs.getInt("vac_no"));
			vacationDto.setVac_category(rs.getString("vac_category"));
			vacationDto.setVac_start(rs.getDate("vac_start"));
			vacationDto.setVac_end(rs.getDate("vac_end"));
			vacationDto.setVac_reason(rs.getString("vac_reason"));
			vacationDto.setVac_comment(rs.getString("vac_comment"));
			vacationDto.setVac_status(rs.getString("vac_status"));
			vacationDto.setVac_write_date(rs.getDate("vac_write_date"));
			vacationDto.setVac_writer_no(rs.getInt("vac_writer_no"));
			vacationDto.setVac_target_no(rs.getInt("vac_target_no"));
			
			list.add(vacationDto);
		}
		
		con.close();
		return list;
	}

	public void update(VacationDto vacationDto) throws Exception{
		Connection con = JdbcUtil.getConnection(USER, PW);
		
		String sql = "update vacation set vac_category=?, vac_start=?, vac_end=?, vac_reason=?, vac_comment=?, vac_target_no=? where vac_no=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, vacationDto.getVac_category());
		ps.setDate(2, vacationDto.getVac_start());
		ps.setDate(3, vacationDto.getVac_end());
		ps.setString(4, vacationDto.getVac_reason());
		ps.setString(5, vacationDto.getVac_comment());
		ps.setInt(6, vacationDto.getVac_target_no());
		ps.setInt(7, vacationDto.getVac_no());
		
		ps.execute();
		
		con.close();
	}

	public void cancel(int vac_no) throws Exception{
		Connection con = JdbcUtil.getConnection(USER, PW);

		String sql = "update vacation set vac_status = '취소' where vac_no=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, vac_no);
		
		ps.execute();
		
		con.close();
	}
}
