package groupware.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import groupware.util.JdbcUtil;

public class EmployeeDao {

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
	
	//사원 추가 메소드
	public void empAdd(EmployeeDto employeeDto) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "insert into employee(emp_no, emp_name, emp_id, emp_pw, emp_phone, "
						+ "emp_email, emp_addr, emp_birth, emp_title, emp_salary, emp_auth, "
						+ "emp_state, emp_etc, emp_manager_no, emp_dep) "
					+ "	values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, employeeDto.getEmp_no());
		ps.setString(2, employeeDto.getEmp_name());
		ps.setString(3, employeeDto.getEmp_id());
		ps.setString(4, employeeDto.getEmp_pw());
		ps.setString(5, employeeDto.getEmp_phone());
		ps.setString(6, employeeDto.getEmp_email());
		ps.setString(7, employeeDto.getEmp_addr());
		ps.setString(8, employeeDto.getEmp_birth());
		ps.setString(9, employeeDto.getEmp_title());
		ps.setInt(10, employeeDto.getEmp_salary());
		ps.setString(11, employeeDto.getEmp_auth());
		ps.setString(12, employeeDto.getEmp_state());
		ps.setString(13, employeeDto.getEmp_etc());
		ps.setInt(14, employeeDto.getEmp_manager_no());
		ps.setString(15, employeeDto.getEmp_dep());
		ps.execute();
		
		con.close();
			
	}
	
}
