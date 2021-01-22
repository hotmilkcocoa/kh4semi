package groupware.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;

import groupware.util.JdbcUtil;

public class VacationApprovalDao {
	public static final String USER = "groupware";
	public static final String PW = "groupware";

	public void insert(int vac_no, int vac_target_no) throws Exception{
		Connection con = JdbcUtil.getConnection(USER, PW);
		
		String sql = "insert into vacation_approval values(?, "
				+ "(select dep_head from department where dep_name = ("
				+ "select emp_dep from employee where emp_no = ?)"
				+ "), '대기', '', '대기')";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, vac_no);
		ps.setInt(2, vac_target_no);
		
		ps.execute();
		
		con.close();
	}

}
