package groupware.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import groupware.util.JdbcUtil;

public class AttendanceDao {
	public static final String USER = "groupware";
	public static final String PW = "groupware";
	
	public int getSequence() throws Exception{
		Connection con = JdbcUtil.getConnection(USER, PW);
		
		String sql = "select attendance_seq.nextval from dual";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		rs.next();
		int seq = rs.getInt(1);
		
		con.close();
		return seq;
	}
	
	public void arrive(int att_no, int emp_no) throws Exception{
		Connection con = JdbcUtil.getConnection(USER, PW);
		
		String sql = "insert into attendance(att_no, att_start, emp_no) values(?, systimestamp, ?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, att_no);
		ps.setInt(2, emp_no);
		ps.execute();
		
		con.close();
	}

	public void leave(int att_no) throws Exception{
		Connection con = JdbcUtil.getConnection(USER, PW);
		
		String sql = "update attendance set att_end = systimestamp where att_no=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, att_no);
		ps.execute();
		
		con.close();
	}

	public AttendanceDto find(int emp_no) throws Exception{
		Connection con = JdbcUtil.getConnection(USER, PW);
		
		String sql = "select * from attendance where emp_no = ? and to_char(att_start, 'yyyy-mm-dd') = to_char(sysdate, 'yyyy-mm-dd')";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, emp_no);
		ResultSet rs = ps.executeQuery();
		
		AttendanceDto attendanceDto = new AttendanceDto();
		if(rs.next()) {
			attendanceDto.setAtt_no(rs.getInt("att_no"));
			attendanceDto.setAtt_start(rs.getTimestamp("att_start"));
			attendanceDto.setAtt_end(rs.getTimestamp("att_end"));
			attendanceDto.setEmp_no(rs.getInt("emp_no"));
		} else {
			attendanceDto = null;
		}
		con.close();
		
		return attendanceDto;
	}
	
	public List<AttendanceDto> select(int emp_no, Timestamp startOfCal, Timestamp endOfCal) throws Exception{
		Connection con = JdbcUtil.getConnection(USER, PW);
		
		String sql = "select * from attendance where emp_no = ? and att_start > ? and att_start < ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, emp_no);
		ps.setTimestamp(2, startOfCal);
		ps.setTimestamp(3, endOfCal);
		ResultSet rs = ps.executeQuery();
		
		List<AttendanceDto> list = new ArrayList<AttendanceDto>();
		
		while(rs.next()) {
			AttendanceDto attendanceDto = new AttendanceDto();
			attendanceDto.setAtt_no(rs.getInt("att_no"));
			attendanceDto.setAtt_start(rs.getTimestamp("att_start"));
			attendanceDto.setAtt_end(rs.getTimestamp("att_end"));
			attendanceDto.setEmp_no(rs.getInt("emp_no"));
			
			list.add(attendanceDto);
		}
		con.close();
		
		return list;
	}
	
	public void testDate(int emp_no, Timestamp att_start, Timestamp att_end) throws Exception{
		Connection con = JdbcUtil.getConnection(USER, PW);
		
		String sql = "insert into attendance values(attendance_seq.nextval, ?, ?, ?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setTimestamp(1, att_start);
		ps.setTimestamp(2, att_end);
		ps.setInt(3, emp_no);
		
		ps.execute();
		
		con.close();
	}
}
