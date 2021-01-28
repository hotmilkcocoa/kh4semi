package groupware.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import groupware.util.JdbcUtil;

public class MessageDao {
	
	public static final String USERNAME = "groupware";
	public static final String PASSWORD = "groupware";
	
//	시퀀스 번호 생성
	public int getSequence() throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "select message.nextval from dual";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		rs.next();
		int seq = rs.getInt(1);
		
		con.close();
		return seq;
	}

	//메세지 보내기
	public void insert(MessageDto dto) throws Exception{
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "insert into message values(message_seq.nextval, ?, ?, ?, ?, sysdate)";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, dto.getMessage_sender());
		ps.setInt(2, dto.getMessage_receiver());
		ps.setString(3, dto.getMessage_title());
		ps.setString(4, dto.getMessage_content());
		
		ps.execute();
		
		con.close();
		
	}
	
	//받은 메세지 조회
	public List<MessageDto> select(int emp_no) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "select "
						+ "rownum, E.emp_no, E.emp_name, E.emp_title, M.* "
					+ "from "
						+ "message M inner join employee E on M.message_sender = E.emp_no "
					+ "where "
						+ "message_receiver = ?";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, emp_no);
		ResultSet rs = ps.executeQuery();
		List<MessageDto> list = new ArrayList<>();
		while(rs.next()) {
			MessageDto msgDto = new MessageDto();
			msgDto.setRownum(rs.getInt("rownum"));
			msgDto.setEmp_no(rs.getInt("emp_no"));
			msgDto.setEmp_name(rs.getString("emp_name"));
			msgDto.setEmp_title(rs.getString("emp_title"));
			msgDto.setMessage_no(rs.getInt("message_no"));
			msgDto.setMessage_title(rs.getString("message_title"));
			msgDto.setMessage_content(rs.getString("message_content"));
			msgDto.setMessage_time(rs.getDate("message_time"));
			msgDto.setMessage_sender(rs.getInt("message_sender"));
			msgDto.setMessage_receiver(rs.getInt("message_receiver"));
			msgDto.setRead_check(rs.getString("read_check"));
			msgDto.setDel_receiver(rs.getString("del_receiver"));
			msgDto.setDel_sender(rs.getString("del_sender"));
			
			list.add(msgDto);
		}
		con.close();
		return list;
	}
	
	//메세지 상세조회
	public MessageDto find(int message_no) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "select "
						+ "E.emp_no, E.emp_name, E.emp_title, M.* "
					+ "from "
						+ "message M inner join employee E on M.message_sender = E.emp_no "
					+ "where "
						+ "M.message_no = ?";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, message_no);
		ResultSet rs = ps.executeQuery();
		
		MessageDto msgDto;
		if(rs.next()) {
			msgDto =  new MessageDto();
			msgDto.setEmp_no(rs.getInt("emp_no"));
			msgDto.setEmp_name(rs.getString("emp_name"));
			msgDto.setEmp_title(rs.getString("emp_title"));
			msgDto.setMessage_no(rs.getInt("message_no"));
			msgDto.setMessage_title(rs.getString("message_title"));
			msgDto.setMessage_content(rs.getString("message_content"));
			msgDto.setMessage_time(rs.getDate("message_time"));
			msgDto.setMessage_receiver(rs.getInt("message_receiver"));
			msgDto.setMessage_sender(rs.getInt("message_sender"));
			msgDto.setRead_check(rs.getString("read_check"));
			msgDto.setDel_receiver(rs.getString("del_receiver"));
			msgDto.setDel_sender(rs.getString("del_sender"));
		} else {
			msgDto = null;
		}
		
		
		con.close();
		return msgDto;
	}
	
		//메세지 상세조회(이전 다음글 조회)
		public MessageDto rnFind(int emp_no, int rn) throws Exception {
			Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
			
			String sql = "select * from("
						+ "select rownum rn, tmp.* from("
							+ "select E.emp_no, E.emp_name, E.emp_title, M.* "
						+ "from "
							+ "message M inner join employee E on M.message_sender = E.emp_no "
						+ "where "
							+ "M.message_receiver = ?) tmp) where rn = ?";
			
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, emp_no);
			ps.setInt(2, rn);
			ResultSet rs = ps.executeQuery();
			
			MessageDto msgDto;
			if(rs.next()) {
				msgDto =  new MessageDto();
				msgDto.setRownum(rs.getInt("rn"));
				msgDto.setEmp_no(rs.getInt("emp_no"));
				msgDto.setEmp_name(rs.getString("emp_name"));
				msgDto.setEmp_title(rs.getString("emp_title"));
				msgDto.setMessage_no(rs.getInt("message_no"));
				msgDto.setMessage_title(rs.getString("message_title"));
				msgDto.setMessage_content(rs.getString("message_content"));
				msgDto.setMessage_time(rs.getDate("message_time"));
				msgDto.setMessage_receiver(rs.getInt("message_receiver"));
				msgDto.setMessage_sender(rs.getInt("message_sender"));
				msgDto.setRead_check(rs.getString("read_check"));
				msgDto.setDel_receiver(rs.getString("del_receiver"));
				msgDto.setDel_sender(rs.getString("del_sender"));
			} else {
				msgDto = null;
			}
			
			
			con.close();
			return msgDto;
		}
		
		//게시글 갯수 조회
		public int getCount(int emp_no) throws Exception {
			Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
			
			String sql = "select count(*) "
							+ "from( "
								+ "select "
									+ "E.emp_no, E.emp_name, E.emp_title, M.* "
								+ "from "
									+ "message M inner join employee E on M.message_sender = E.emp_no "
								+ "where "
									+ "M.message_receiver = ?"
							+ ")";
	
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, emp_no);
			ResultSet rs = ps.executeQuery();
			rs.next();
			int count = rs.getInt(1);
			con.close();
			return count;
		}

		
		//보낸메세지조회
		public List<MessageDto> selectSend(int emp_no) throws Exception {
			Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
			
			String sql = "select "
							+ "rownum, E.emp_no, E.emp_name, E.emp_title, M.* "
						+ "from "
							+ "message M inner join employee E on M.message_receiver = E.emp_no "
						+ "where "
							+ "message_sender = ?";
			
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, emp_no);
			ResultSet rs = ps.executeQuery();
			List<MessageDto> list = new ArrayList<>();
			while(rs.next()) {
				MessageDto msgDto = new MessageDto();
				msgDto.setRownum(rs.getInt("rownum"));
				msgDto.setEmp_no(rs.getInt("emp_no"));
				msgDto.setEmp_name(rs.getString("emp_name"));
				msgDto.setEmp_title(rs.getString("emp_title"));
				msgDto.setMessage_no(rs.getInt("message_no"));
				msgDto.setMessage_title(rs.getString("message_title"));
				msgDto.setMessage_content(rs.getString("message_content"));
				msgDto.setMessage_time(rs.getDate("message_time"));
				msgDto.setMessage_sender(rs.getInt("message_sender"));
				msgDto.setMessage_receiver(rs.getInt("message_receiver"));
				msgDto.setRead_check(rs.getString("read_check"));
				msgDto.setDel_receiver(rs.getString("del_receiver"));
				msgDto.setDel_sender(rs.getString("del_sender"));
				
				list.add(msgDto);
			}
			con.close();
			return list;
		}
		
		
		//보낸메세지 상세조회(이전 다음글 조회)
				public MessageDto rnFindSend(int emp_no, int rn) throws Exception {
					Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
					
					String sql = "select * from("
								+ "select rownum rn, tmp.* from("
									+ "select E.emp_no, E.emp_name, E.emp_title, M.* "
								+ "from "
									+ "message M inner join employee E on M.message_receiver = E.emp_no "
								+ "where "
									+ "M.message_sender = ?) tmp) where rn = ?";
					
					PreparedStatement ps = con.prepareStatement(sql);
					ps.setInt(1, emp_no);
					ps.setInt(2, rn);
					ResultSet rs = ps.executeQuery();
					
					MessageDto msgDto;
					if(rs.next()) {
						msgDto =  new MessageDto();
						msgDto.setRownum(rs.getInt("rn"));
						msgDto.setEmp_no(rs.getInt("emp_no"));
						msgDto.setEmp_name(rs.getString("emp_name"));
						msgDto.setEmp_title(rs.getString("emp_title"));
						msgDto.setMessage_no(rs.getInt("message_no"));
						msgDto.setMessage_title(rs.getString("message_title"));
						msgDto.setMessage_content(rs.getString("message_content"));
						msgDto.setMessage_time(rs.getDate("message_time"));
						msgDto.setMessage_receiver(rs.getInt("message_receiver"));
						msgDto.setMessage_sender(rs.getInt("message_sender"));
						msgDto.setRead_check(rs.getString("read_check"));
						msgDto.setDel_receiver(rs.getString("del_receiver"));
						msgDto.setDel_sender(rs.getString("del_sender"));
					} else {
						msgDto = null;
					}
					
					
					con.close();
					return msgDto;
				}
				
				//게시글 갯수 조회
				public int getCountSend(int emp_no) throws Exception {
					Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
					
					String sql = "select count(*) "
									+ "from( "
										+ "select "
											+ "E.emp_no, E.emp_name, E.emp_title, M.* "
										+ "from "
											+ "message M inner join employee E on M.message_receiver = E.emp_no "
										+ "where "
											+ "M.message_sender = ?"
									+ ")";
			
					PreparedStatement ps = con.prepareStatement(sql);
					ps.setInt(1, emp_no);
					ResultSet rs = ps.executeQuery();
					rs.next();
					int count = rs.getInt(1);
					con.close();
					return count;
				}
}
