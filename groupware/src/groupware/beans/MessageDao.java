package groupware.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import groupware.util.JdbcUtil;

public class MessageDao {
	
	public void insert(MessageDto dto) throws Exception{
		Connection con = JdbcUtil.getConnection("testTable", "testTable");
		
		String sql = "inset into chat values(chat_seq.nextval, ?, ?, ?, ?, sysdate";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, dto.getMessage_sender());
		ps.setInt(2, dto.getMessage_receiver());
		ps.setString(3, dto.getMessage_title());
		ps.setString(4, dto.getMessage_content());
		
		ps.execute();
		
		con.close();
		
	}
	
	public List<MessageDto> select() throws Exception {
		Connection con = JdbcUtil.getConnection("testTable", "testTable");
		
		String sql = "select * from chat";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		List<MessageDto> list = new ArrayList<>();
		if(rs.next()) {
			
		}
		return list;
	}

}
