package groupware.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import groupware.util.JdbcUtil;
import groupware.beans.LoginDto;

public class LoginDao {

	public static final String USERNAME = "groupware";
	public static final String PASSWORD = "groupware";
	
	
	
	//로그인
	public boolean login(LoginDto dto) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
			
		String sql = "select * from employee where emp_id=? and emp_pw=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, dto.getEmp_id());
		ps.setString(2, dto.getEmp_pw());
		ResultSet rs = ps.executeQuery();
			
		boolean result = rs.next();
			
			con.close();
			
			return result;
	}



	public EmployeeDto login(String emp_id) {
		// TODO Auto-generated method stub
		return null;
	}



	
	
}