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
			dto.setPayment_writer(rs.getString("payment_writer"));
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
}
