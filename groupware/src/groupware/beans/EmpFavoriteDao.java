package groupware.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import groupware.util.JdbcUtil;

public class EmpFavoriteDao {
	
	public static final String USERNAME = "groupware";
	public static final String PASSWORD = "groupware";
	
	//즐겨찾기 추가
	public void insert(int emp_no, int fav_emp_no) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "insert into emp_fav values(?, ?)";
		PreparedStatement ps = con.prepareStatement(sql);
		
		ps.setInt(1, emp_no);
		ps.setInt(2, fav_emp_no);
		
		ps.execute();
		
		con.close();
	}
	
	//조회
	public List<EmpFavoriteDto> select() throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "select * from emp_fav";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		
		List<EmpFavoriteDto> list = new ArrayList<>();
		while(rs.next()) {
			EmpFavoriteDto dto = new EmpFavoriteDto();
			dto.setEmp_no(rs.getInt("emp_no"));
			dto.setFav_emp_no(rs.getInt("fav_emp_no"));
			
			list.add(dto);
		}
		
		con.close();
		return list;
	}
	
	//조회
	public List<EmpFavoriteDto> select(int emp_no) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "select * from emp_fav where emp_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, emp_no);
		ResultSet rs = ps.executeQuery();
		
		List<EmpFavoriteDto> list = new ArrayList<>();
		while(rs.next()) {
			EmpFavoriteDto dto = new EmpFavoriteDto();
			dto.setEmp_no(rs.getInt("emp_no"));
			dto.setFav_emp_no(rs.getInt("fav_emp_no"));
			
			list.add(dto);
		}
		
		con.close();
		return list;
	}
	
	//삭제
	public void delete(int emp_no, int fav_emp_no) throws Exception{
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "delete emp_fav where emp_no=? and fav_emp_no=?";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, emp_no);
		ps.setInt(2, fav_emp_no);
		ps.execute();
		
		con.close();
	}
	
	//즐겨찾기 목록 조회
	public List<EmpFavoriteDto> fav_select(int emp_no) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "select "
						+ "F.emp_no, E.emp_no, E.emp_title, E.emp_name, E.emp_dep, E.emp_phone, E.emp_email, F.fav_emp_no "
					+ "from "
						+ "emp_fav F inner join employee E on E.emp_no = F.fav_emp_no "
					+ "where F.emp_no = ?";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, emp_no);
		ResultSet rs = ps.executeQuery();
		
		List<EmpFavoriteDto> list = new ArrayList<>();
		while(rs.next()) {
			EmpFavoriteDto dto = new EmpFavoriteDto();
			dto.setEmp_no(rs.getInt("emp_no"));
			dto.setEmp_name(rs.getString("emp_name"));
			dto.setEmp_title(rs.getString("emp_title"));
			dto.setEmp_dep(rs.getString("emp_dep"));
			dto.setEmp_phone(rs.getString("emp_phone"));
			dto.setEmp_email(rs.getString("emp_email"));
			dto.setFav_emp_no(rs.getInt("fav_emp_no"));
			
			list.add(dto);
		}
		con.close();
		return list;
	}
	
	public List<EmpFavoriteDto> fav_select(int emp_no, String keyword) throws Exception{
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		String sql = "select "
				+ "F.emp_no, E.emp_no, E.emp_title, E.emp_name, E.emp_dep, E.emp_phone, E.emp_email, F.fav_emp_no "
			+ "from "
				+ "emp_fav F inner join employee E on E.emp_no = F.fav_emp_no "
			+ "where F.emp_no = ? and (E.emp_title || E.emp_name) like ?";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, emp_no);
		ps.setString(2, "%"+keyword+"%");
		ResultSet rs = ps.executeQuery();
		
		List<EmpFavoriteDto> list = new ArrayList<>();
		while(rs.next()) {
			EmpFavoriteDto dto = new EmpFavoriteDto();
			dto.setEmp_no(rs.getInt("emp_no"));
			dto.setEmp_name(rs.getString("emp_name"));
			dto.setEmp_title(rs.getString("emp_title"));
			dto.setEmp_dep(rs.getString("emp_dep"));
			dto.setEmp_phone(rs.getString("emp_phone"));
			dto.setEmp_email(rs.getString("emp_email"));
			dto.setFav_emp_no(rs.getInt("fav_emp_no"));
			
			list.add(dto);
		}
		con.close();
		return list;
	}

}
