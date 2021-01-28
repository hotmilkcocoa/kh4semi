package groupware.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import groupware.util.JdbcUtil;

public class BoardPaymentDao {

	public static final String USERNAME = "groupware";
	public static final String PASSWORD = "groupware";
	
	public List<BoardPaymentDto> paymentlist() throws Exception{
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		String sql = "select * from board_payment order by payment_no desc";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		
		List<BoardPaymentDto> paymentlist = new ArrayList<>();
		while(rs.next()) {
			BoardPaymentDto dto = new BoardPaymentDto();
			dto.setPayment_no(rs.getInt("payment_no"));
			dto.setPayment_writer(rs.getInt("payment_writer"));
			dto.setPayment_header(rs.getString("payment_header"));
			dto.setPayment_title(rs.getString("payment_title"));
			dto.setPayment_context(rs.getString("payment_context"));
			dto.setPayment_date(rs.getDate("payment_date"));
			dto.setBoard_dep(rs.getString("board_dep"));
			paymentlist.add(dto);
		}
		con.close();
		return paymentlist;
		}
//	시퀀스 번호를 미리 생성하는 기능
	public int getSequence() throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "select payment_no.nextval from dual";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		rs.next();
		int seq = rs.getInt(1);
		
		con.close();
		return seq;
	}
//	번호까지 함께 등록하는 기능
	public void writeWithPrimaryKey(BoardPaymentDto paymentDto) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "insert into board_payment values(?, ?, ?, ?, ?,sysdate,?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, paymentDto.getPayment_no());
		ps.setInt(2, paymentDto.getPayment_writer());
		ps.setString(3, paymentDto.getPayment_header());
		ps.setString(4, paymentDto.getPayment_title());
		ps.setString(5, paymentDto.getPayment_context());
		ps.setString(6, paymentDto.getBoard_dep());
		ps.execute();
		
		con.close();
	}
	//페이징(검색)
			public List<BoardPaymentDto> pagingList(String type, String key, int startRow, int endRow) throws Exception {
				Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
						
				String sql = 	"select * from(" + 
									"select rownum rn, TMP.* from(" + 
										"select * from board_payment where instr(#1, ?) > 0 " + 
										"order by payment_no desc" + 
									")TMP" + 
								") where rn between ? and ?";
				
				sql = sql.replace("#1", type);
				PreparedStatement ps = con.prepareStatement(sql);
				ps.setString(1, key);
				ps.setInt(2, startRow);
				ps.setInt(3, endRow);
				ResultSet rs = ps.executeQuery();
						
				List<BoardPaymentDto> paymentlist = new ArrayList<>();
				while(rs.next()) {
					BoardPaymentDto dto = new BoardPaymentDto();
					dto.setPayment_no(rs.getInt("payment_no"));
					dto.setPayment_writer(rs.getInt("payment_writer"));
					dto.setPayment_header(rs.getString("payment_header"));
					dto.setPayment_title(rs.getString("payment_title"));
					dto.setPayment_context(rs.getString("payment_context"));
					dto.setPayment_date(rs.getDate("payment_date"));
					dto.setBoard_dep(rs.getString("board_dep"));
					paymentlist.add(dto);
					}
					con.close();
						
					return paymentlist; 
			}
			
	//페이징(목)
			public List<BoardPaymentDto> pagingList(int startRow, int endRow) throws Exception {
				Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
						
				String sql = 	"select * from(" + 
									"select rownum rn, TMP.* from(" + 
										"select * from board_payment order  by payment_no desc" + 
									")TMP" + 
								") where rn between ? and ?";
				
				PreparedStatement ps = con.prepareStatement(sql);
				ps.setInt(1, startRow);
				ps.setInt(2, endRow);
				ResultSet rs = ps.executeQuery();
						
				List<BoardPaymentDto> paymentlist = new ArrayList<>();
				while(rs.next()) {
					BoardPaymentDto dto = new BoardPaymentDto();
					dto.setPayment_no(rs.getInt("payment_no"));
					dto.setPayment_writer(rs.getInt("payment_writer"));
					dto.setPayment_header(rs.getString("payment_header"));
					dto.setPayment_title(rs.getString("payment_title"));
					dto.setPayment_context(rs.getString("payment_context"));
					dto.setPayment_date(rs.getDate("payment_date"));
					dto.setBoard_dep(rs.getString("board_dep"));
					paymentlist.add(dto);
					}
					con.close();
						
					return paymentlist; 
			}
//			검색 개수를 구하는 메소드
			public int getCount(String type, String key) throws Exception {
				Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
				
				String sql = "select count(*) from board_payment where instr(#1, ?) > 0";
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
				
				String sql = "select count(*) from board_payment";
				PreparedStatement ps = con.prepareStatement(sql);
				ResultSet rs = ps.executeQuery();
				rs.next();
				int count = rs.getInt(1);
//				int count = rs.getInt("count(*)");
				con.close();
				
				return count;
			}		
			
		}

