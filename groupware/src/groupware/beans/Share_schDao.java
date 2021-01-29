package groupware.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import groupware.util.JdbcUtil;

public class Share_schDao {
	public static final String USER = "groupware";
	public static final String PW = "groupware";

	public void insert(int emp_no, int target_no) throws Exception{
		Connection con = JdbcUtil.getConnection(USER, PW);
		
		String sql = "insert into share_sch values(share_sch_seq.nextval, ?, ?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, emp_no);
		ps.setInt(2, target_no);
		
		ps.execute();
		
		con.close();
	}

	
	public List<Share_schDto> select(int emp_no) throws Exception{
		Connection con = JdbcUtil.getConnection(USER, PW);
		
		String sql = "select * from share_sch where emp_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, emp_no);
		
		ResultSet rs = ps.executeQuery();
		
		List<Share_schDto> shareList = new ArrayList<Share_schDto>();
		while(rs.next()) {
			Share_schDto shareDto = new Share_schDto();
			
			shareDto.setShare_no(rs.getInt("share_no"));
			shareDto.setEmp_no(rs.getInt("emp_no"));
			shareDto.setTarget_no(rs.getInt("target_no"));
			
			shareList.add(shareDto);
		}
		con.close();
		return shareList;
	}


	public void delete(int share_no) throws Exception{
		Connection con = JdbcUtil.getConnection(USER, PW);
		
		String sql = "delete from share_sch where share_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, share_no);
		
		ps.execute();
		
		con.close();
	}


	public boolean find(int emp_no, int target_no) throws Exception{
		Connection con = JdbcUtil.getConnection(USER, PW);
		
		String sql = "select * from share_sch where emp_no = ? and target_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, emp_no);
		ps.setInt(2, target_no);
		
		int count = ps.executeUpdate();
		
		con.close();
		
		return count == 1;
	}
}
