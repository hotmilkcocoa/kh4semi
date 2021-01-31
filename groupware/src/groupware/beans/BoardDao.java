package groupware.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import groupware.util.JdbcUtil;
import groupware.beans.BoardDto;

public class BoardDao {
	
	public static final String USERNAME = "groupware";
	public static final String PASSWORD = "groupware";
	
	public List<BoardDto> mainlist() throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "select * from board order by board_no desc";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		
		List<BoardDto> mainlist = new ArrayList<>();
		while(rs.next()) {
			BoardDto dto = new BoardDto();
			dto.setBoard_no(rs.getInt("board_no"));
			dto.setBoard_header(rs.getString("board_header"));
			dto.setBoard_title(rs.getString("board_title"));
			dto.setBoard_context(rs.getString("board_context"));
			dto.setBoard_dep(rs.getString("board_dep"));
			dto.setBoard_writer(rs.getInt("board_writer"));
			dto.setBoard_writedate(rs.getDate("board_writedate"));
			mainlist.add(dto);
		}
		con.close();
		
		return mainlist;
	}
//공지 검색 -1	
	public List<BoardDto> noticelist() throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "select * from board order by board_no desc";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		
		List<BoardDto> noticelist = new ArrayList<>();
		while(rs.next()) {
			BoardDto dto = new BoardDto();
			dto.setBoard_no(rs.getInt("board_no"));
			dto.setBoard_header(rs.getString("board_header"));
			dto.setBoard_title(rs.getString("board_title"));
			dto.setBoard_context(rs.getString("board_context"));
			dto.setBoard_dep(rs.getString("board_dep"));
			dto.setBoard_writer(rs.getInt("board_writer"));
			dto.setBoard_writedate(rs.getDate("board_writedate"));
			noticelist.add(dto);
		}
		con.close();
		
		return noticelist;
	} 
//공지 검색-2	
	public List<BoardDto> noticelist(String type, String key) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "select * from board order by board_no desc";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		
		List<BoardDto> noticelist = new ArrayList<>();
		while(rs.next()) {
			BoardDto dto = new BoardDto();
			dto.setBoard_no(rs.getInt("board_no"));
			dto.setBoard_header(rs.getString("board_header"));
			dto.setBoard_title(rs.getString("board_title"));
			dto.setBoard_context(rs.getString("board_context"));
			dto.setBoard_dep(rs.getString("board_dep"));
			dto.setBoard_writer(rs.getInt("board_writer"));
			dto.setBoard_writedate(rs.getDate("board_writedate"));
			noticelist.add(dto);
		}
		con.close();
		
		return noticelist;
	} 
	//board_main 검색
	public List<BoardDto> select() throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "select * from board order by board_no desc";

		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		
		List<BoardDto> list = new ArrayList<>();

		while(rs.next()) {
			BoardDto dto = new BoardDto();
			dto.setBoard_no(rs.getInt("board_no"));
			dto.setBoard_writer(rs.getInt("board_writer"));
			dto.setBoard_header(rs.getString("board_header"));
			dto.setBoard_title(rs.getString("board_title"));
			dto.setBoard_context(rs.getString("board_context"));
			dto.setBoard_writedate(rs.getDate("board_writedate"));
			dto.setBoard_dep(rs.getString("board_dep"));
			list.add(dto);
		}
		
		con.close();
		
		return list;
	}
	//board_main 검색2
	public List<BoardDto> select(String key) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "select * from board where instr(board_titld,?)>0 order by board_no desc";

		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, key);
		ResultSet rs = ps.executeQuery();
		
		List<BoardDto> list = new ArrayList<>();

		while(rs.next()) {
			BoardDto dto = new BoardDto();
			dto.setBoard_no(rs.getInt("board_no"));
			dto.setBoard_writer(rs.getInt("board_writer"));
			dto.setBoard_header(rs.getString("board_header"));
			dto.setBoard_title(rs.getString("board_title"));
			dto.setBoard_context(rs.getString("board_context"));
			dto.setBoard_writedate(rs.getDate("writedate"));
			dto.setBoard_dep(rs.getString("board_dep"));
			list.add(dto);
		}
		
		con.close();
		
		return list;
	}
	//board_main 검색3
	public List<BoardDto> select(String type, String key) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "select * from board where instr(#1, ?)>0 order by board_no desc";
		sql = sql.replace("#1", type);
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, key);
		ResultSet rs = ps.executeQuery();
		
		List<BoardDto> list = new ArrayList<>();
		while(rs.next()) {
			BoardDto dto = new BoardDto();
			dto.setBoard_no(rs.getInt("board_no"));
			dto.setBoard_writer(rs.getInt("board_writer"));
			dto.setBoard_header(rs.getString("board_header"));
			dto.setBoard_title(rs.getString("board_title"));
			dto.setBoard_context(rs.getString("board_context"));
			dto.setBoard_writedate(rs.getDate("board_writedate"));
			dto.setBoard_dep(rs.getString("board_dep"));
			list.add(dto);
		}
		
		con.close();
		
		return list;
	}
	//detail상세보기
	public BoardDto find(int board_no)throws Exception{
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "select * from board where board_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, board_no);
		ResultSet rs = ps.executeQuery();
		
		BoardDto dto;
		if(rs.next()) {
			dto = new BoardDto();
			dto.setBoard_no(rs.getInt("board_no"));
			dto.setBoard_writer(rs.getInt("board_writer"));
			dto.setBoard_header(rs.getString("board_header"));
			dto.setBoard_title(rs.getString("board_title"));
			dto.setBoard_context(rs.getString("board_context"));
			dto.setBoard_writedate(rs.getDate("board_writedate"));
			dto.setBoard_dep(rs.getString("board_dep"));
		}
		else {
			dto = null;
		}
		
		con.close();
		
		return dto;
	}
	
//수정기능
	public boolean update(BoardDto dto) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "update board "
				+ "set board_header=?, board_title=?, board_context=? "
				+ "where board_no=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, dto.getBoard_header());
		ps.setString(2, dto.getBoard_title());
		ps.setString(3, dto.getBoard_context());
		ps.setInt(4, dto.getBoard_no());
		int count = ps.executeUpdate();
		
		con.close();
		return count > 0;
	}
//	삭제 기능
	public boolean delete(int board_no) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "delete board where board_no=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, board_no);
		int count = ps.executeUpdate();
		
		con.close();
		
		return count > 0;
	}
	
//	검색 개수를 구하는 메소드
	public int getCount(String type, String key) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "select count(*) from board where instr(#1, ?) > 0";
		sql = sql.replace("#1", type);
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, key);
		
		ResultSet rs = ps.executeQuery();
		rs.next();
		int count = rs.getInt(1);
//		int count = rs.getInt("count(*)");
		con.close();
		
		return count;
	}
	
//	목록 개수를 구하는 메소드
	public int getCount() throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "select count(*) from board";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		rs.next();
		int count = rs.getInt(1);
//		int count = rs.getInt("count(*)");
		con.close();
		
		return count;
	}
//	시퀀스 번호를 미리 생성하는 기능
	public int getSequence() throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "select board_no.nextval from dual";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		rs.next();
		int seq = rs.getInt(1);
		
		con.close();
		return seq;
	}
//	번호까지 함께 등록하는 기능
	public void writeWithPrimaryKey(BoardDto boardDto) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "insert into board values(?, ?, ?, ?, ?,sysdate,?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, boardDto.getBoard_no());
		ps.setInt(2, boardDto.getBoard_writer());
		ps.setString(3, boardDto.getBoard_header());
		ps.setString(4, boardDto.getBoard_title());
		ps.setString(5, boardDto.getBoard_context());
		ps.setString(6, boardDto.getBoard_dep());
		ps.execute();
		
		con.close();
	}
	//페이징(검색)
	public List<BoardDto> pagingList(String type, String key, int startRow, int endRow) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
				
		String sql = 	"select * from(" + 
							"select rownum rn, TMP.* from(" + 
								"select * from board where instr(#1, ?) > 0 " + 
								"order by board_no desc" + 
							")TMP" + 
						") where rn between ? and ?";
		
		sql = sql.replace("#1", type);
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, key);
		ps.setInt(2, startRow);
		ps.setInt(3, endRow);
		ResultSet rs = ps.executeQuery();
				
		List<BoardDto> list = new ArrayList<>();
		while(rs.next()) {
			BoardDto dto = new BoardDto();
			dto.setBoard_no(rs.getInt("board_no"));
			dto.setBoard_writer(rs.getInt("board_writer"));
			dto.setBoard_header(rs.getString("board_header"));
			dto.setBoard_title(rs.getString("board_title"));
			dto.setBoard_context(rs.getString("board_context"));
			dto.setBoard_writedate(rs.getDate("board_writedate"));
			dto.setBoard_dep(rs.getString("board_dep"));
			list.add(dto);
			
			}
			con.close();
				
			return list; 
	}
	
	//페이징(목)
	public List<BoardDto> pagingList(int startRow, int endRow) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
				
		String sql = 	"select * from(" + 
							"select rownum rn, TMP.* from(" + 
								"select * from board order  by board_no desc" + 
							")TMP" + 
						") where rn between ? and ?";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, startRow);
		ps.setInt(2, endRow);
		ResultSet rs = ps.executeQuery();
				
		List<BoardDto> list = new ArrayList<>();
		while(rs.next()) {
			BoardDto dto = new BoardDto();
			dto.setBoard_no(rs.getInt("board_no"));
			dto.setBoard_writer(rs.getInt("board_writer"));
			dto.setBoard_header(rs.getString("board_header"));
			dto.setBoard_title(rs.getString("board_title"));
			dto.setBoard_context(rs.getString("board_context"));
			dto.setBoard_writedate(rs.getDate("board_writedate"));
			dto.setBoard_dep(rs.getString("board_dep"));
			list.add(dto);
			
			}
			con.close();
				
			return list; 
	}
	
	

}
