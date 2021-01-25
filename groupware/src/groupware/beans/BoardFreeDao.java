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
	
	public List<BoardFreeDto> freelist() throws Exception{
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		String sql = "select*from board_free order by free_no desc";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs =  ps.executeQuery();
		
		List<BoardFreeDto> freelist = new ArrayList<>();
		while(rs.next()) {
			BoardFreeDto dto = new BoardFreeDto();
			dto.setFree_no(rs.getInt("free_no"));
			dto.setFree_writer(rs.getString("free_write"));
			dto.setFree_header(rs.getString("free_header"));
			dto.setFree_context(rs.getString("free_context"));
			dto.setFree_writedate(rs.getDate("free_date"));
			freelist.add(dto);
		}
		con.close();
		return freelist;
	}
}
