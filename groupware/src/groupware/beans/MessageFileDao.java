package groupware.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import groupware.util.JdbcUtil;

public class MessageFileDao {
	public static final String USERNAME = "groupware";
	public static final String PASSWORD = "groupware";
	
	//등록기능
		public void insert(MessageFileDto msgFileDto) throws Exception {
			Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
			
			String sql = "insert into message_file values(msg_file_seq.nextval, ?, ?, ?, ?, ?)";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, msgFileDto.getFile_upload_name());
			ps.setString(2, msgFileDto.getFile_save_name());
			ps.setLong(3, msgFileDto.getFile_size());
			ps.setString(4, msgFileDto.getFile_type());
			ps.setInt(5, msgFileDto.getMessage_no());
			ps.execute();
			
			con.close();
		}
		
		
		//단일조회가능
		public MessageFileDto find(int msg_no) throws Exception {
			Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
			
			String sql = "select * from message_file where message_no = ?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, msg_no);
			ResultSet rs = ps.executeQuery(); //데이터개수 없거나 한개있거나
			
			MessageFileDto msgFileDto;
			if(rs.next()) {
				msgFileDto = new MessageFileDto();
				msgFileDto.setMsg_file_no(rs.getInt("msg_file_no"));
				msgFileDto.setFile_upload_name(rs.getString("file_upload_name"));
				msgFileDto.setFile_save_name(rs.getString("file_save_name"));
				msgFileDto.setFile_size(rs.getInt("file_size"));
				msgFileDto.setFile_type(rs.getString("file_type"));
				msgFileDto.setMessage_no(rs.getInt("message_no"));
				
			}
			else {
				msgFileDto = null;
			}
			con.close();
			return msgFileDto;
		}
		
		//파일 여부조회
		public boolean check(int msg_no) throws Exception {
			Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
			String sql = "select file_upload_name from message_file where message_no = ?";
			

			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, msg_no);
			ResultSet rs = ps.executeQuery(); //데이터개수 없거나 한개있거나
			
			boolean check = rs.next();
			
			con.close();
			return check;
		}
}
