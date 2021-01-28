package groupware.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import groupware.util.JdbcUtil;

public class BoardReplyDao {
	public static final String USERNAME = "groupware";
	public static final String PASSWORD = "groupware";

//댓글작성
	public void insert(BoardReplyDto replyDto) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "insert into reply("
						+ "reply_no, reply_context, reply_date, reply_origin, reply_writer"
					+ ") "
					+ "values(reply_no.nextval, ?, sysdate, ?, ?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, replyDto.getReply_context());
		ps.setInt(2, replyDto.getReply_origin());
		ps.setInt(3, replyDto.getReply_writer());
		ps.execute();
		
		con.close();
	}
	
	public List<BoardReplyDto> select(int reply_origin) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "select * from reply where reply_origin=? order by reply_no asc";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, reply_origin);
		ResultSet rs = ps.executeQuery();
		
		List<BoardReplyDto> list = new ArrayList<>();
		while(rs.next()) {
			BoardReplyDto replyDto = new BoardReplyDto();
			replyDto.setReply_no(rs.getInt("reply_no"));
			replyDto.setReply_context(rs.getString("reply_context"));
			replyDto.setReply_date(rs.getDate("reply_date"));
			replyDto.setReply_origin(rs.getInt("reply_origin"));
			replyDto.setReply_writer(rs.getInt("reply_writer"));
			list.add(replyDto);
		}
		con.close();
		return list;
	}
	
//	댓글 삭제 기능
	public void delete(int reply_no) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "delete reply where reply_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, reply_no);
		ps.execute();
		
		con.close();
	}
	
//	댓글 수정
	public void update(BoardReplyDto replyDto) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "update reply set reply_context = ? where reply_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, replyDto.getReply_context());
		ps.setInt(2, replyDto.getReply_no());
		ps.execute();
		
		con.close();
	}
	//페이징(검색)
			public List<BoardReplyDto> pagingList(String type, String key, int startRow, int endRow) throws Exception {
				Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
						
				String sql = 	"select * from(" + 
									"select rownum rn, TMP.* from(" + 
										"select * from reply where instr(#1, ?) > 0 " + 
										"order by reply_no desc" + 
									")TMP" + 
								") where rn between ? and ?";
				
				sql = sql.replace("#1", type);
				PreparedStatement ps = con.prepareStatement(sql);
				ps.setString(1, key);
				ps.setInt(2, startRow);
				ps.setInt(3, endRow);
				ResultSet rs = ps.executeQuery();
						
				List<BoardReplyDto> list = new ArrayList<>();
				while(rs.next()) {
					BoardReplyDto replyDto = new BoardReplyDto();
					replyDto.setReply_no(rs.getInt("reply_no"));
					replyDto.setReply_context(rs.getString("reply_context"));
					replyDto.setReply_date(rs.getDate("reply_date"));
					replyDto.setReply_origin(rs.getInt("reply_origin"));
					replyDto.setReply_writer(rs.getInt("reply_writer"));
					list.add(replyDto);
					}
					con.close();
						
					return list; 
			}
	//페이징(목)
			public List<BoardReplyDto> pagingList(int startRow, int endRow) throws Exception {
				Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
						
				String sql = 	"select * from(" + 
									"select rownum rn, TMP.* from(" + 
										"select * from reply order  by reply_no desc" + 
									")TMP" + 
								") where rn between ? and ?";
				
				PreparedStatement ps = con.prepareStatement(sql);
				ps.setInt(1, startRow);
				ps.setInt(2, endRow);
				ResultSet rs = ps.executeQuery();
						
				List<BoardReplyDto> list = new ArrayList<>();
				while(rs.next()) {
					BoardReplyDto replyDto = new BoardReplyDto();
					replyDto.setReply_no(rs.getInt("reply_no"));
					replyDto.setReply_context(rs.getString("reply_context"));
					replyDto.setReply_date(rs.getDate("reply_date"));
					replyDto.setReply_origin(rs.getInt("reply_origin"));
					replyDto.setReply_writer(rs.getInt("reply_writer"));
					list.add(replyDto);
					}
					con.close();
						
					return list; 
			}
//			검색 개수를 구하는 메소드
			public int getCount(String type, String key) throws Exception {
				Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
				
				String sql = "select count(*) from board_free where instr(#1, ?) > 0";
				sql = sql.replace("#1", type);
				PreparedStatement ps = con.prepareStatement(sql);
				ps.setString(1, key);
				
				ResultSet rs = ps.executeQuery();
				rs.next();
				int count = rs.getInt(1);
//				int count = rs.getInt("count(*)");
				con.close();
				
				return count;
			}
			
//			목록 개수를 구하는 메소드
			public int getCount() throws Exception {
				Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
				
				String sql = "select count(*) from board_free";
				PreparedStatement ps = con.prepareStatement(sql);
				ResultSet rs = ps.executeQuery();
				rs.next();
				int count = rs.getInt(1);
//				int count = rs.getInt("count(*)");
				con.close();
				
				return count;
			}		
			
		}