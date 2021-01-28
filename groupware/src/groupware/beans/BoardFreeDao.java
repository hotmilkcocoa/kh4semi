package groupware.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import groupware.util.JdbcUtil;

public class BoardFreeDao {
	public static final String USERNAME = "groupware";
	public static final String PASSWORD = "groupware";
	//목록
	public List<BoardFreeDto> freelist() throws Exception{
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		String sql = "select*from board_free order by free_no desc";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs =  ps.executeQuery();
		
		List<BoardFreeDto> freelist = new ArrayList<>();
		while(rs.next()) {
			BoardFreeDto dto = new BoardFreeDto();
			dto.setFree_no(rs.getInt("free_no"));
			dto.setFree_writer(rs.getInt("free_writer"));
			dto.setFree_header(rs.getString("free_header"));
			dto.setFree_title(rs.getString("free_title"));
			dto.setFree_context(rs.getString("free_context"));
			dto.setFree_writedate(rs.getDate("free_writedate"));
			freelist.add(dto);
		}
		con.close();
		return freelist;
	}
	//검색
	public List<BoardFreeDto> select(String type,String key) throws Exception{
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "select * from board_free where instr(free_titld,?)>0 order by free_no desc";
	
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, key);
		ResultSet rs = ps.executeQuery();
		
		List<BoardFreeDto> freelist = new ArrayList<>();
		
		while(rs.next()) {
			BoardFreeDto dto = new BoardFreeDto();
			dto.setFree_no(rs.getInt("free_no"));
			dto.setFree_writer(rs.getInt("free_write"));
			dto.setFree_header(rs.getString("free_header"));
			dto.setFree_title(rs.getString("free_title"));
			dto.setFree_context(rs.getString("free_context"));
			dto.setFree_writedate(rs.getDate("free_writedate"));
			freelist.add(dto);
		}
		con.close();
		return freelist;
	}
	
//	시퀀스 번호를 미리 생성하는 기능
	public int getSequence() throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "select free_no_seq.nextval from dual";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		rs.next();
		int seq = rs.getInt(1);
		
		con.close();
		return seq;
	}	
//	번호까지 함께 등록하는 기능
	public void writeWithPrimaryKey(BoardFreeDto freeDto) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "insert into board_free values(?, ?, ?, ?, ?,sysdate)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, freeDto.getFree_no());
		ps.setInt(2, freeDto.getFree_writer());
		ps.setString(3, freeDto.getFree_header());
		ps.setString(4, freeDto.getFree_title());
		ps.setString(5, freeDto.getFree_context());
		ps.execute();
		
		con.close();
	}
	//detail
	public BoardFreeDto find(int free_no)throws Exception{
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "select * from board_free where free_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, free_no);
		ResultSet rs = ps.executeQuery();
		
		BoardFreeDto dto;
		if(rs.next()) {
			dto = new BoardFreeDto();
			dto.setFree_no(rs.getInt("free_no"));
			dto.setFree_writer(rs.getInt("free_writer"));
			dto.setFree_header(rs.getString("free_header"));
			dto.setFree_title(rs.getString("free_title"));
			dto.setFree_context(rs.getString("free_context"));
			dto.setFree_writedate(rs.getDate("free_writedate"));
		}
		else {
			dto = null;
		}
		
		con.close();
		
		return dto;
	}
	//수정기능
		public boolean update(BoardFreeDto dto) throws Exception {
			Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
			
			String sql = "update board_free "
					+ "set free_header=?, free_title=?, free_context=? "
					+ "where free_no=?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, dto.getFree_header());
			ps.setString(2, dto.getFree_title());
			ps.setString(3, dto.getFree_context());
			ps.setInt(4, dto.getFree_no());
			int count = ps.executeUpdate();
			
			con.close();
			return count > 0;
		}
//		삭제 기능
		public boolean delete(int free_no) throws Exception {
			Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
			
			String sql = "delete board_free where free_no=?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, free_no);
			int count = ps.executeUpdate();
			
			con.close();
			
			return count > 0;
		}
//페이징(검색)
		public List<BoardFreeDto> pagingList(String type, String key, int startRow, int endRow) throws Exception {
			Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
					
			String sql = 	"select * from(" + 
								"select rownum rn, TMP.* from(" + 
									"select * from board_free where instr(#1, ?) > 0 " + 
									"order by free_no desc" + 
								")TMP" + 
							") where rn between ? and ?";
			
			sql = sql.replace("#1", type);
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, key);
			ps.setInt(2, startRow);
			ps.setInt(3, endRow);
			ResultSet rs = ps.executeQuery();
					
			List<BoardFreeDto> list = new ArrayList<>();
			while(rs.next()) {
				BoardFreeDto dto = new BoardFreeDto();
				dto.setFree_no(rs.getInt("free_no"));
				dto.setFree_writer(rs.getInt("free_writer"));
				dto.setFree_header(rs.getString("free_header"));
				dto.setFree_title(rs.getString("free_title"));
				dto.setFree_context(rs.getString("free_context"));
				dto.setFree_writedate(rs.getDate("free_writedate"));
				list.add(dto);
				
				}
				con.close();
					
				return list; 
		}
		
//페이징(목)
		public List<BoardFreeDto> pagingList(int startRow, int endRow) throws Exception {
			Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
					
			String sql = 	"select * from(" + 
								"select rownum rn, TMP.* from(" + 
									"select * from board_free order  by free_no desc" + 
								")TMP" + 
							") where rn between ? and ?";
			
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, startRow);
			ps.setInt(2, endRow);
			ResultSet rs = ps.executeQuery();
					
			List<BoardFreeDto> list = new ArrayList<>();
			while(rs.next()) {
				BoardFreeDto dto = new BoardFreeDto();
				dto.setFree_no(rs.getInt("free_no"));
				dto.setFree_writer(rs.getInt("free_writer"));
				dto.setFree_header(rs.getString("free_header"));
				dto.setFree_title(rs.getString("free_title"));
				dto.setFree_context(rs.getString("free_context"));
				dto.setFree_writedate(rs.getDate("free_writedate"));
				list.add(dto);
				
				}
				con.close();
					
				return list; 
		}
//		검색 개수를 구하는 메소드
		public int getCount(String type, String key) throws Exception {
			Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
			
			String sql = "select count(*) from board_free where instr(#1, ?) > 0";
			sql = sql.replace("#1", type);
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, key);
			
			ResultSet rs = ps.executeQuery();
			rs.next();
			int count = rs.getInt(1);
//			int count = rs.getInt("count(*)");
			con.close();
			
			return count;
		}
		
//		목록 개수를 구하는 메소드
		public int getCount() throws Exception {
			Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
			
			String sql = "select count(*) from board_free";
			PreparedStatement ps = con.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			rs.next();
			int count = rs.getInt(1);
//			int count = rs.getInt("count(*)");
			con.close();
			
			return count;
		}		
		
	}

