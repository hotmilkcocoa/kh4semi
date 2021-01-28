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
		
		String sql = "insert into department values(dep_seq.nextval, ?, '')";
		
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
	
	//페이징을 이용한 목록
	public List<DataSettingDto> depSelect(int startRow, int endRow) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
				
		String sql = "select * from(" +
						"select rownum rn, TMP.* from(" +
							"select * from department order by dep_no asc" +
						")TMP" +
					") where rn between ? and ?";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, startRow);
		ps.setInt(2, endRow);
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
	
	//근태설정정보 검색
	public DataSettingDto att_setFind(int att_set_no) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "select * from att_set where att_set_no = ?";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, att_set_no);
		ResultSet rs = ps.executeQuery();
		DataSettingDto dataSettingDto;
		
		if(rs.next()) {
			dataSettingDto = new DataSettingDto();
			dataSettingDto.setAtt_set_no(rs.getInt("att_set_no"));
			dataSettingDto.setAtt_set_start(rs.getDate("att_set_start"));
			dataSettingDto.setAtt_set_end(rs.getDate("att_set_end"));
			dataSettingDto.setAtt_set_late(rs.getInt("att_set_late"));
			
		}
		else {
			dataSettingDto = null;
		}
		
		con.close();
		
		return dataSettingDto;
	}

	//근태관리 기본설정 수정
	public void att_setUpdate(DataSettingDto dataSettingDto, String att_set_start, String att_set_end) throws Exception{
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "update att_set set att_set_start = to_date(?, 'HH24:MI'), att_set_end = to_date(?, 'HH24:MI'), att_set_late = ? where att_set_no = ?";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, att_set_start);
		ps.setString(2, att_set_end);
		ps.setInt(3, dataSettingDto.getAtt_set_late());
		ps.setInt(4, dataSettingDto.getAtt_set_no());
		ps.execute();
		
		con.close();
	}
}
