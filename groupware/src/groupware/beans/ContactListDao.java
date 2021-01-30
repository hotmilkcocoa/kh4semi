package groupware.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import groupware.util.JdbcUtil;

public class ContactListDao {
	
	private static final String USERNAME = "groupware";
	private static final String PASSWORD = "groupware";

	//등록메소드
	public void Insert(ContactListDto contDto) throws Exception{
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		String sql = "insert into emp_contact_list values(cont_seq.nextval, ?, ?, ?, ?, ?, ?)";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, contDto.getCont_name());
		ps.setString(2, contDto.getCont_corp());
		ps.setString(3, contDto.getCont_phone());
		ps.setString(4, contDto.getCont_email());
		ps.setString(5, contDto.getCont_memo());
		ps.setInt(6, contDto.getEmp_no());
		
		ps.execute();
		con.close();
		
	}
	
	public ContactListDto find(int cont_no) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		String sql = "select * from emp_contact_list where cont_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		
		ps.setInt(1, cont_no);
		ResultSet rs = ps.executeQuery();
		rs.next();
		ContactListDto contDto = new ContactListDto();
		contDto.setCont_no(rs.getInt("cont_no"));
		contDto.setCont_name(rs.getString("cont_name"));
		contDto.setCont_corp(rs.getString("cont_corp"));
		contDto.setCont_phone(rs.getString("cont_phone"));
		contDto.setCont_email(rs.getString("cont_email"));
		contDto.setCont_memo(rs.getString("cont_memo"));
		contDto.setEmp_no(rs.getInt("emp_no"));
		
		con.close();
		return contDto;
		
	}
	
	//조회메소드
	public List<ContactListDto> select(int emp_no) throws Exception{
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		String sql = "select * from emp_contact_list where emp_no = ? order by cont_no desc";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, emp_no);
		ResultSet rs = ps.executeQuery();
		
		List<ContactListDto> list = new ArrayList<>();
		while(rs.next()) {
			ContactListDto contDto = new ContactListDto();
			contDto.setCont_no(rs.getInt("cont_no"));
			contDto.setCont_name(rs.getString("cont_name"));
			contDto.setCont_corp(rs.getString("cont_corp"));
			contDto.setCont_phone(rs.getString("cont_phone"));
			contDto.setCont_email(rs.getString("cont_email"));
			contDto.setCont_memo(rs.getString("cont_memo"));
			contDto.setEmp_no(rs.getInt("emp_no"));
			
			list.add(contDto);
		}
		con.close();
		return list;
	}
	
	//검색조회 메소드
	public List<ContactListDto> searchSelect(int emp_no, String key) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		String sql = "select * from emp_contact_list where emp_no = ? and (cont_name || cont_corp || cont_phone || cont_email) like ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, emp_no);
		ps.setString(2, "%"+key+"%");
		ResultSet rs = ps.executeQuery();
		
		List<ContactListDto> list = new ArrayList<>();
		while(rs.next()) {
			ContactListDto contDto = new ContactListDto();
			contDto.setCont_no(rs.getInt("Cont_no"));
			contDto.setCont_name(rs.getString("cont_name"));
			contDto.setCont_corp(rs.getString("cont_corp"));
			contDto.setCont_phone(rs.getString("cont_phone"));
			contDto.setCont_email(rs.getString("cont_email"));
			contDto.setCont_memo(rs.getString("cont_memo"));
			contDto.setEmp_no(rs.getInt("emp_no"));
			
			list.add(contDto);
		}
		
		con.close();
		return list;
	}
	
	public int searchCount(int emp_no, String key) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "select count(*) from emp_contact_list where emp_no and (cont_name || cont_corp || cont_phone || cont_email) like ?";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, emp_no);
		ps.setString(2, "%"+key+"%");
		ResultSet rs = ps.executeQuery();
		rs.next();
		
		int count = rs.getInt(1);
		
		con.close();
		return count;
	}
	
	public int selectCount(int emp_no) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		String sql = "select count(*) from emp_contact_list where emp_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, emp_no);
		ResultSet rs = ps.executeQuery();
		rs.next();
		
		int count = rs.getInt(1);
		
		con.close();
		return count;
	}
	
	//삭제
	public void delete(int cont_no) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
			String sql = "delete emp_contact_list where cont_no = ?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, cont_no);
			ps.executeUpdate();
			
		con.close();
	}
	
	//페이징
	public List<ContactListDto> pagination(int emp_no, int startRow, int endRow) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		String sql = "select * from (" + 
						"select rownum rn, TMP.* from (" + 
							"select * from emp_contact_list where emp_no = ? order by cont_no desc" + 
						")TMP" + 
					") where rn between ? and ?";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, emp_no);
		ps.setInt(2, startRow);
		ps.setInt(3, endRow);
		ResultSet rs = ps.executeQuery();
		
		List<ContactListDto> list = new ArrayList<>();
		while(rs.next()) {
			ContactListDto contDto = new ContactListDto();
			contDto.setCont_no(rs.getInt("Cont_no"));
			contDto.setCont_name(rs.getString("cont_name"));
			contDto.setCont_corp(rs.getString("cont_corp"));
			contDto.setCont_phone(rs.getString("cont_phone"));
			contDto.setCont_email(rs.getString("cont_email"));
			contDto.setCont_memo(rs.getString("cont_memo"));
			contDto.setEmp_no(rs.getInt("emp_no"));
			
			list.add(contDto);
		}
		con.close();
		return list;
	}

	public List<ContactListDto> pagination(int emp_no, String key, int startRow, int endRow) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		String sql = "select * from (" + 
						"select rownum rn, TMP.* from (" + 
							"select * from emp_contact_list where emp_no = ? and (cont_name || cont_corp || cont_phone || cont_email) like ? "
							+ "order by cont_no desc" + 
						")TMP" + 
					") where rn between ? and ?";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, emp_no);
		ps.setString(2, "%"+key+"%");
		ps.setInt(3, startRow);
		ps.setInt(4, endRow);
		ResultSet rs = ps.executeQuery();
		
		List<ContactListDto> list = new ArrayList<>();
		while(rs.next()) {
			ContactListDto contDto = new ContactListDto();
			contDto.setCont_no(rs.getInt("Cont_no"));
			contDto.setCont_name(rs.getString("cont_name"));
			contDto.setCont_corp(rs.getString("cont_corp"));
			contDto.setCont_phone(rs.getString("cont_phone"));
			contDto.setCont_email(rs.getString("cont_email"));
			contDto.setCont_memo(rs.getString("cont_memo"));
			contDto.setEmp_no(rs.getInt("emp_no"));
			
			list.add(contDto);
		}
		con.close();
		return list;
	}
	
	public void update(ContactListDto contDto) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "update emp_contact_list set cont_name=?, cont_corp=?, cont_phone=?, cont_email=?, cont_memo=? where cont_no=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, contDto.getCont_name());
		ps.setString(2, contDto.getCont_corp());
		ps.setString(3, contDto.getCont_phone());
		ps.setString(4, contDto.getCont_email());
		ps.setString(5, contDto.getCont_memo());
		ps.setInt(6, contDto.getCont_no());
		
		ps.executeUpdate();
		
		con.close();
	}

}
