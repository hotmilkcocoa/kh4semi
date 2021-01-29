package groupware.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;

import groupware.util.JdbcUtil;

public class LeaveWorkDao {
	public static final String USER = "groupware";
	public static final String PW = "groupware";
	
	public void insert(int emp_no, int vac_no) throws Exception{
		Connection con = JdbcUtil.getConnection(USER, PW);
		
		String sql = "insert into leave_work values(leave_work_seq.nextval, ?, ?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, emp_no);
		ps.setInt(2, vac_no);
		
		ps.execute();
		
		con.close();
	}
}
