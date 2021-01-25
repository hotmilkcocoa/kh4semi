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

}
