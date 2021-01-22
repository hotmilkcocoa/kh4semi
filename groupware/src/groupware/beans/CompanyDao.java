package groupware.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;

import groupware.util.JdbcUtil;

public class CompanyDao {

	public static final String USERNAME = "groupware";
	public static final String PASSWORD = "groupware";
	
	//회사정보 조회
	public CompanyDto find(int com_no) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "select * from company where com_no = ?";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, com_no);		
		ResultSet rs = ps.executeQuery();
		CompanyDto companyDto; 
		
		if(rs.next()) {
			companyDto = new CompanyDto();
			companyDto.setCom_no(rs.getInt("com_no"));
			companyDto.setCom_name(rs.getString("com_name"));
			companyDto.setCom_type(rs.getString("com_type"));
			companyDto.setCom_corpnum(rs.getString("com_corpnum"));
			companyDto.setCom_registnum(rs.getString("com_registnum"));
			companyDto.setCom_ceo(rs.getString("com_ceo"));
			companyDto.setCom_call(rs.getString("com_call"));
			companyDto.setCom_condition(rs.getString("com_condition"));
			companyDto.setCom_event(rs.getString("com_event"));
			companyDto.setCom_addr(rs.getString("com_addr"));
			companyDto.setCom_emp(rs.getString("com_emp"));
			companyDto.setCom_phone(rs.getString("com_phone"));
			
		}
		else {
			companyDto = null;
		}
		
		con.close();
		return companyDto;
	}
	
	//회사정보 수정
	public void update(CompanyDto companyDto) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "update company set com_name = ?, com_type = ?, com_registnum=?, "
				+ "com_corpnum =?, com_ceo=?, com_call=?, com_condition=?, "
				+ "com_event=?, com_emp=?, com_phone=?, com_addr=? where com_no=?";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, companyDto.getCom_name());
		ps.setString(2, companyDto.getCom_type());
		ps.setString(3, companyDto.getCom_registnum());
		ps.setString(4, companyDto.getCom_corpnum());
		ps.setString(5, companyDto.getCom_ceo());
		ps.setString(6, companyDto.getCom_call());
		ps.setString(7, companyDto.getCom_condition());
		ps.setString(8, companyDto.getCom_event());
		ps.setString(9, companyDto.getCom_emp());
		ps.setString(10, companyDto.getCom_phone());
		ps.setString(11, companyDto.getCom_addr());
		ps.setInt(12, companyDto.getCom_no());
		ps.execute();
		
		con.close();
		
	}
	
}
