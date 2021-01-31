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
		
		String sql = "insert into share_sch values(share_sch_seq.nextval, ?, ?, 'true')";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, emp_no);
		ps.setInt(2, target_no);
		
		ps.execute();
		
		con.close();
	}

	
	public List<Share_schDto> select(int emp_no) throws Exception{
		Connection con = JdbcUtil.getConnection(USER, PW);
		
		String sql = "select * from share_sch where emp_no = ? order by share_no desc";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, emp_no);
		
		ResultSet rs = ps.executeQuery();
		
		List<Share_schDto> shareList = new ArrayList<Share_schDto>();
		while(rs.next()) {
			Share_schDto shareDto = new Share_schDto();
			
			shareDto.setShare_no(rs.getInt("share_no"));
			shareDto.setEmp_no(rs.getInt("emp_no"));
			shareDto.setTarget_no(rs.getInt("target_no"));
			shareDto.setChecked(rs.getString("checked"));
			
			shareList.add(shareDto);
		}
		con.close();
		return shareList;
	}
	
	public List<Share_schDto> selectFiltered(int emp_no) throws Exception{
		Connection con = JdbcUtil.getConnection(USER, PW);
		
		String sql = "select * from share_sch where emp_no = ? and checked = 'true' order by share_no desc";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, emp_no);
		
		ResultSet rs = ps.executeQuery();
		
		List<Share_schDto> shareList = new ArrayList<Share_schDto>();
		while(rs.next()) {
			Share_schDto shareDto = new Share_schDto();
			
			shareDto.setShare_no(rs.getInt("share_no"));
			shareDto.setEmp_no(rs.getInt("emp_no"));
			shareDto.setTarget_no(rs.getInt("target_no"));
			shareDto.setChecked(rs.getString("checked"));
			
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
	
	public Share_schDto find(int share_no) throws Exception{
		Connection con = JdbcUtil.getConnection(USER, PW);
		
		String sql = "select * from share_sch where share_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, share_no);
		
		ResultSet rs = ps.executeQuery();
		
		Share_schDto shareDto = new Share_schDto();
		if(rs.next()) {
			shareDto.setShare_no(rs.getInt("share_no"));
			shareDto.setEmp_no(rs.getInt("emp_no"));
			shareDto.setTarget_no(rs.getInt("target_no"));
			shareDto.setChecked(rs.getString("checked"));
		}
		con.close();
		
		return shareDto;
	}


	public void update(int share_no, String bool) throws Exception{
		Connection con = JdbcUtil.getConnection(USER, PW);
		
		String sql = "update share_sch set checked = ? where share_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, bool);
		ps.setInt(2, share_no);
		
		ps.execute();
		
		con.close();
		
	}

	public void updateSelected(int emp_no, String[] shareArr) throws Exception{
		Connection con = JdbcUtil.getConnection(USER, PW);
		
		String sql = "update share_sch set checked = 'true' where share_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		for(int i=0; i<shareArr.length; i++) {
			ps.setInt(1, Integer.parseInt(shareArr[i]));
			ps.execute();
		}
		
		con.close();
	}

	public void offAll(int emp_no) throws Exception{
		Connection con = JdbcUtil.getConnection(USER, PW);
		
		String sql = "update share_sch set checked = 'false' where emp_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, emp_no);
		ps.execute();
		
		con.close();
	}
}
