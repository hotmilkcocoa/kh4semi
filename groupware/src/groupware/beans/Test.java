package groupware.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import groupware.util.JdbcUtil;

public class Test {
	public static void main(String[] args) throws Exception{
		Connection con = JdbcUtil.getConnection("groupware", "groupware");
		String sql = "select * from employee";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		
		while(rs.next()) {
			System.out.println(rs.getString("emp_id"));
		}
		
		con.close();
	}
}
