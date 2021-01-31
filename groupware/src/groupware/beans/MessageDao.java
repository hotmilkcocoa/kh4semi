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
		
		String sql = "select message_seq.nextval from dual";
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
		
		String sql = "insert into "
					+ "message(message_no, message_sender, message_receiver, message_title, message_content) "
					+ "values("
							+ "?, ?, ?, ?, ?)";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, dto.getMessage_no());
		ps.setInt(2, dto.getMessage_sender());
		ps.setInt(3, dto.getMessage_receiver());
		ps.setString(4, dto.getMessage_title());
		ps.setString(5, dto.getMessage_content());
		
		ps.execute();
		
		con.close();
		
	}
	
	//받은 메세지 조회
	public List<MessageDto> selectIn(int emp_no) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "select * from("
				+ "select rownum rn, tmp.* from("
				+ "select "
					+ "E.emp_no, E.emp_name, E.emp_title, M.* "
				+ "from "
					+ "message M inner join employee E on M.message_sender = E.emp_no "
				+ "where "
					+ "message_receiver = ?"
				+ "order by message_no desc"
			+ ")tmp"
		+ ")";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, emp_no);
		ResultSet rs = ps.executeQuery();
		List<MessageDto> list = new ArrayList<>();
		while(rs.next()) {
			MessageDto msgDto = new MessageDto();
			if(rs.getString("del_receiver").equals("N")) {
				
				msgDto.setRownum(rs.getInt("rn"));
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
			} else if(rs.getString("del_sender").equals("Y") && rs.getString("del_receiver").equals("Y")) {
				delete(rs.getInt("message_no"));
			}
			
		}
		con.close();
		return list;
	}
	
	//메세지 상세조회
	public MessageDto find(int message_no) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "select * from("
				+ "select rownum rn, tmp.* from("
				+ "select "
					+ "E.emp_no, E.emp_name, E.emp_title, M.* "
				+ "from "
					+ "message M inner join employee E on M.message_receiver = E.emp_no "
				+ "where "
					+ "message_no = ? "
				+ "order by message_no desc"
			+ ")tmp"
		+ ")";
		
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
	
		//받은메세지 상세조회(이전 다음글 조회)(inbox)
		public MessageDto rnFind(int emp_no, int msg_no) throws Exception {
			Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
			
			String sql = "select * from("
						+ "select rownum rn, tmp.* from("
							+ "select E.emp_no, E.emp_name, E.emp_title, M.* "
						+ "from "
							+ "message M inner join employee E on M.message_sender = E.emp_no "
						+ "where "
							+ "M.message_receiver = ? order by message_no desc) "
						+ "tmp) "
						+ "where message_no = ?";
			
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, emp_no);
			ps.setInt(2, msg_no);
			ResultSet rs = ps.executeQuery();
			
			MessageDto msgDto = null;
			if(rs.next()) {
				if(rs.getString("del_receiver").equals("N")) {
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
				}
			} else {
				msgDto = null;
			}
			
			
			con.close();
			return msgDto;
		}
		
		//받은쪽지함 갯수 조회(inbox)
		public int getCount(int emp_no) throws Exception {
			Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
			
			String sql = "select count(*) "
							+ "from( "
								+ "select "
									+ "E.emp_no, E.emp_name, E.emp_title, M.* "
								+ "from "
									+ "message M inner join employee E on M.message_sender = E.emp_no "
								+ "where "
									+ "M.message_receiver = ?)";
	
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, emp_no);
			ResultSet rs = ps.executeQuery();
			rs.next();
			int count = rs.getInt(1);
			con.close();
			return count;
		}

		
		//보낸메세지조회
		public List<MessageDto> selectSent(int emp_no) throws Exception {
			Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
			
			String sql = "select * from("
							+ "select rownum rn, tmp.* from("
								+ "select "
									+ "E.emp_no, E.emp_name, E.emp_title, M.* "
								+ "from "
									+ "message M inner join employee E on M.message_receiver = E.emp_no "
								+ "where "
									+ "message_sender = ? "
								+ "order by message_no desc"
							+ ")tmp"
						+ ")";
			
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, emp_no);
			ResultSet rs = ps.executeQuery();
			List<MessageDto> list = new ArrayList<>();
			while(rs.next()) {
				MessageDto msgDto = new MessageDto();
				if(rs.getString("del_sender").equals("N")) {
					msgDto.setRownum(rs.getInt("rn"));
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
				} else if(rs.getString("del_sender").equals("Y") && rs.getString("del_receiver").equals("Y")) {
					delete(rs.getInt("message_no"));
				}
			}
			con.close();
			return list;
		}
		
		
		//보낸메세지 상세조회(이전 다음글 조회)
		public MessageDto rnFindSend(int emp_no, int msg_no) throws Exception {
			Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
			
			String sql = "select * from("
						+ "select rownum rn, tmp.* from("
							+ "select E.emp_no, E.emp_name, E.emp_title, M.* "
						+ "from "
							+ "message M inner join employee E on M.message_receiver = E.emp_no "
						+ "where "
							+ "M.message_sender = ? order by message_no desc) "
						+ "tmp) "
						+ "where message_no = ?";
			
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, emp_no);
			ps.setInt(2, msg_no);
			ResultSet rs = ps.executeQuery();
			
			MessageDto msgDto = null;
			if(rs.next()) {
				if(rs.getString("del_sender").equals("N")) {
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
				}
			} else {
				msgDto = null;
			}
			
			con.close();
			return msgDto;
		}
		
		//보낸쪽지함 갯수 조회(sentbox)
		public int getCountSend(int emp_no) throws Exception {
			Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
			
			String sql = "select count(*) "
							+ "from( "
								+ "select "
									+ "E.emp_no, E.emp_name, E.emp_title, M.* "
								+ "from "
									+ "message M inner join employee E on M.message_receiver = E.emp_no "
								+ "where "
									+ "M.message_sender = ? and del_sender = 'N')";
	
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, emp_no);
			ResultSet rs = ps.executeQuery();
			rs.next();
			int count = rs.getInt(1);
			con.close();
			return count;
		}
		
		//쪽지 아예 삭제
		public void delete(int message_no) throws Exception {
			Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
			
			String sql = "delete message where message_no = ?";
			
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, message_no);
			ps.execute();
			
			con.close();
		}
		
		//쪽지 삭제 체크(받은쪽지함)
		public void deleteCkInbox(int message_no) throws Exception {
			Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
			
			String sql = "update message set del_receiver = 'Y' where message_no = ?";
			
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, message_no);
			ps.execute();
			con.close();
		}
		
		//쪽지 삭제 체크(보낸쪽지함)
		public void deleteCkSentbox(int message_no) throws Exception {
			Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
			
			String sql = "update message set del_sender = 'Y' where message_no = ?";
			
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, message_no);
			ps.execute();
			con.close();
		}
		
		//쪽지 읽음 체크
		public void readCk(int message_no) throws Exception {
			Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
			
			String sql = "update message set read_check = 'Y' where message_no = ?";
			
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, message_no);
			ps.execute();
			con.close();
		}
		
		
		
		//보낸메세지 이전글 가져오기(sentbox)
		public int prevSend(int message_no, int emp_no) throws Exception {
			Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
			
			String sql = "select message_no from message where message_no = (select max(message_no)from message where message_no < ? and message_sender = ? and del_sender = 'N')";
			
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, message_no);
			ps.setInt(2, emp_no);
			ResultSet rs = ps.executeQuery();
			
			int msg_no;
			if(rs.next()) {
				msg_no = rs.getInt("message_no");
			} else {
				msg_no = 0;
			}
			
			con.close();
			return msg_no;
			
		}
		
		
		//다음글 가져오기(sentbox)보낸메세지
		public int nextSend(int message_no, int emp_no) throws Exception {
			Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
			
			String sql = "select message_no from message where message_no = (select min(message_no)from message where message_no > ? and message_sender = ? and del_sender = 'N')";
			
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, message_no);
			ps.setInt(2, emp_no);
			ResultSet rs = ps.executeQuery();
			
			int msg_no;
			if(rs.next()) {
				msg_no = rs.getInt("message_no");
			} else {
				msg_no = 0;
			}
			
			con.close();
			return msg_no;
			
		}
		
		
		//이전글 가져오기(inbox) 받은메세지
		public int prev(int message_no, int emp_no) throws Exception {
			Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
			
			String sql = "select message_no from message where message_no = (select max(message_no)from message where message_no < ? and message_receiver = ? and del_receiver = 'N')";
			
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, message_no);
			ps.setInt(2, emp_no);
			ResultSet rs = ps.executeQuery();
			
			int msg_no;
			if(rs.next()) {
				msg_no = rs.getInt("message_no");
			} else {
				msg_no = 0;
			}
			
			con.close();
			return msg_no;
			
		}
		
		
		//다음글 가져오기(inbox) 받은메세지
		public int next(int message_no, int emp_no) throws Exception {
			Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
			
			String sql = "select message_no from message where message_no = (select min(message_no)from message where message_no > ? and message_receiver = ? and del_receiver = 'N')";
			
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, message_no);
			ps.setInt(2, emp_no);
			ResultSet rs = ps.executeQuery();
			
			int msg_no;
			if(rs.next()) {
				msg_no = rs.getInt("message_no");
			} else {
				msg_no = 0;
			}
			System.out.println(msg_no);
			con.close();
			return msg_no;
			
		}
		
		//해당 메세지가 받는사람이 나라면
		public int boxCheck(int msg_no) throws Exception {
			Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
			
			String sql = "select message_receiver from message where message_no = ?";
			
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, msg_no);
			ResultSet rs = ps.executeQuery();
			int no;
			if(rs.next()) {
				no = rs.getInt("message_receiver");
			} else {
				no = 0;
			}
			
			con.close();
			return no;
		}
		
		//페이징 받은메세지(inbox)
		public List<MessageDto> paginationIn(int emp_no, int startRow, int endRow) throws Exception {
			Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
			
			String sql = "select * from("
							+ "select rownum rn, tmp.* from("
							+ "select E.emp_no, E.emp_name, E.emp_title, M.* "
							+ "from "
								+ "message M inner join employee E on M.message_sender = E.emp_no "
							+ "where "
								+ "message_receiver = ? "
							+ "order by message_no desc)tmp) "
						+ "where rn between ? and ?";
			
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, emp_no);
			ps.setInt(2, startRow);
			ps.setInt(3, endRow);
			ResultSet rs = ps.executeQuery();
			List<MessageDto> list = new ArrayList<>();
			while(rs.next()) {
				MessageDto msgDto = new MessageDto();
				if(rs.getString("del_receiver").equals("N")) {
					
					msgDto.setRownum(rs.getInt("rn"));
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
				} else if(rs.getString("del_sender").equals("Y") && rs.getString("del_receiver").equals("Y")) {
					delete(rs.getInt("message_no"));
				}
				
			}
			con.close();
			return list;
		}
		
		
		//페이징 보낸메세지(sentbox)
		public List<MessageDto> paginationSent(int emp_no, int startRow, int endRow) throws Exception {
			Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
			
			String sql = "select * from("
							+ "select rownum rn, tmp.* from("
								+ "select E.emp_no, E.emp_name, E.emp_title, M.* "
								+ "from "
									+ "message M inner join employee E on M.message_receiver = E.emp_no "
								+ "where "
									+ "message_sender = ? "
								+ "order by message_no desc)tmp) "
							+ "where rn between ? and ?";
			
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, emp_no);
			ps.setInt(2, startRow);
			ps.setInt(3, endRow);
			ResultSet rs = ps.executeQuery();
			List<MessageDto> list = new ArrayList<>();
			while(rs.next()) {
				MessageDto msgDto = new MessageDto();
				if(rs.getString("del_sender").equals("N")) {
					msgDto.setRownum(rs.getInt("rn"));
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
				} else if(rs.getString("del_sender").equals("Y") && rs.getString("del_receiver").equals("Y")) {
					delete(rs.getInt("message_no"));
				}
			}
			con.close();
			return list;
		}
		
		
		//검색페이징(inbox) 받은메세지
		public List<MessageDto> paginationInSearch(String type, String key, int emp_no, int startRow, int endRow) throws Exception {
			Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
			
			String sql = "select * from("
						+ "select "
							+ "rownum rn, E.emp_no, E.emp_name, E.emp_title, M.* "
						+ "from "
							+ "message M inner join employee E on M.message_sender = E.emp_no "
						+ "where "
							+ "message_receiver = ? and instr(#1, ?) > 0 "
						+ "order by message_no desc) where rn between ? and ?";
			
			sql = sql.replace("#1", type);
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, emp_no);
			ps.setString(2, key);
			ps.setInt(3, startRow);
			ps.setInt(4, endRow);
			ResultSet rs = ps.executeQuery();
			List<MessageDto> list = new ArrayList<>();
			while(rs.next()) {
				MessageDto msgDto = new MessageDto();
				if(rs.getString("del_receiver").equals("N")) {
					
					msgDto.setRownum(rs.getInt("rn"));
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
				} else if(rs.getString("del_sender").equals("Y") && rs.getString("del_receiver").equals("Y")) {
					delete(rs.getInt("message_no"));
				}
				
			}
			con.close();
			return list;
		}
		
		//검색페이징(sentbox) 보낸메세지
		public List<MessageDto> paginationSentSearch(String type, String key, int emp_no, int startRow, int endRow) throws Exception {
			Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
			
			String sql = "select * from("
						+ "select "
								+ "rownum rn, E.emp_no, E.emp_name, E.emp_title, M.* "
							+ "from "
								+ "message M inner join employee E on M.message_receiver = E.emp_no "
							+ "where "
								+ "message_sender = ? and instr(#1, ?) > 0 "
							+ "order by message_no desc) "
						+ "where rn between ? and ?";
			
			sql = sql.replace("#1", type);
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, emp_no);
			ps.setString(2, key);
			ps.setInt(3, startRow);
			ps.setInt(4, endRow);
			ResultSet rs = ps.executeQuery();
			List<MessageDto> list = new ArrayList<>();
			while(rs.next()) {
				MessageDto msgDto = new MessageDto();
				if(rs.getString("del_sender").equals("N")) {
					msgDto.setRownum(rs.getInt("rn"));
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
				} else if(rs.getString("del_sender").equals("Y") && rs.getString("del_receiver").equals("Y")) {
					delete(rs.getInt("message_no"));
				}
			}
			con.close();
			return list;
		}
		
		//검색 후 갯수(inbox) 받은메세지
		public int searchCountIn(String type, String key, int emp_no) throws Exception {
			Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
			
			String sql = "select count(*) from(" + 
							"select E.emp_name, M.message_title, M.message_content " + 
							"from message M inner join employee E on M.message_sender = E.emp_no " + 
							"where message_receiver = ? and instr (#1, ?) > 0)";
			
			sql = sql.replace("#1", type);
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, emp_no);
			ps.setString(2, key);
			ResultSet rs = ps.executeQuery();
			rs.next();
			
			int count = rs.getInt(1);
			
			con.close();
			return count;
		}
		
		//검색 후 갯수(sentbox) 보낸메세지
		public int searchCountSent(String type, String key, int emp_no) throws Exception {
			Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
			
			String sql = "select count(*) from(" + 
							"select E.emp_name, M.message_title, M.message_content " + 
							"from message M inner join employee E on M.message_receiver = E.emp_no " + 
							"where message_sender = ? and instr (#1, ?) > 0)";
			
			sql = sql.replace("#1", type);
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, emp_no);
			ps.setString(2, key);
			ResultSet rs = ps.executeQuery();
			rs.next();
			
			int count = rs.getInt(1);
			
			con.close();
			return count;
		}
}
