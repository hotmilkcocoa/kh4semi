package groupware.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import groupware.util.JdbcUtil;

public class DataSettingDao {

	public static final String USERNAME = "groupware";
	public static final String PASSWORD = "groupware";
	
	//부서데이터 추가
	public void depAdd(DataSettingDto dataSettingDto) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "insert into department values(dep_seq.nextval, ?)";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, dataSettingDto.getDep_name());
		ps.execute();
		
		con.close();
	}
	
	//직급데이터 추가
	public void titleAdd(DataSettingDto dataSettingDto) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "insert into jobtitle values(title_seq.nextval, ?)";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, dataSettingDto.getTitle_name());
		ps.execute();
		
		con.close();
	}
	
	//부서데이터 삭제
	public void depDelete(int dep_no) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "delete department where dep_no = ?";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, dep_no);
		ps.execute();
		
		con.close();
	}
	
	//직급데이터 삭제
	public void titleDelete(int title_no) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "delete jobtitle where title_no = ?";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, title_no);
		ps.execute();
		
		con.close();
	}
	
	//부서데이터 검색
	public List<DataSettingDto> depSelect() throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
				
		String sql = "select * from department order by dep_no asc";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		
		List<DataSettingDto> depList = new ArrayList<>();
		
		while(rs.next()) {
			DataSettingDto dataSettingDto = new DataSettingDto();
			dataSettingDto.setDep_no(rs.getInt("dep_no"));
			dataSettingDto.setDep_name(rs.getString("dep_name"));
			dataSettingDto.setDep_head(rs.getString("dep_head"));
			
			depList.add(dataSettingDto);
		}
		con.close();
		return depList;
	}
	
	
	//직급데이터 검색
	public List<DataSettingDto> titleSelect() throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
				
		String sql = "select * from jobtitle order by title_no desc";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		
		List<DataSettingDto> titleList = new ArrayList<>();
		
		while(rs.next()) {
			DataSettingDto dataSettingDto = new DataSettingDto();
			dataSettingDto.setTitle_no(rs.getInt("title_no"));
			dataSettingDto.setTitle_name(rs.getString("title_name"));
			
			titleList.add(dataSettingDto);
		}
		con.close();
		return titleList;
	}
	
	//부서정보 검색
	public DataSettingDto find(int dep_no) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "select * from department where dep_no = ?";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, dep_no);
		ResultSet rs = ps.executeQuery();
		DataSettingDto dataSettingDto;
		
		if(rs.next()) {
			dataSettingDto = new DataSettingDto();
			dataSettingDto.setDep_no(rs.getInt("dep_no"));
			dataSettingDto.setDep_name(rs.getString("dep_name"));
			dataSettingDto.setDep_head(rs.getString("dep_head"));
			
		}
		else {
			dataSettingDto = null;
		}
		
		con.close();
		
		return dataSettingDto;
	}

	//목록 개수를 구하는 메소드
	public int getCount() throws Exception{
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "select count(*) from department";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		rs.next();
		int count = rs.getInt(1);
	
		con.close();
		return count;
	}
	
	//부서장 추가 및 수정
	public void depUpdate(DataSettingDto dataSettingDto) throws Exception{
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "update department set dep_head = ? where dep_no = ?";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, dataSettingDto.getDep_head());
		ps.setInt(2, dataSettingDto.getDep_no());
		ps.execute();
		
		con.close();
	}
	
	
	
}