package groupware.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import groupware.util.JdbcUtil;

public class LoginDao {

	public static final String USERNAME = "groupware";
	public static final String PASSWORD = "groupware";
	
	//시퀀스 번호 생성 메소드
	public int getSequence() throws Exception{
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql ="select emp_seq.nextval from dual";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		rs.next();
		int seq = rs.getInt(1); 
			
		con.close();
		
		return seq; 
			
	}

	public boolean login(LoginDto dto) {
		
		return false;
	}

	public LoginDto find(String emp_id) {
		
		return null;
	}
	
}