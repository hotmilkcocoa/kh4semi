package groupware.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import groupware.util.JdbcUtil;

public class EmployeeDao {

	public static final String USERNAME = "groupware";
	public static final String PASSWORD = "groupware";
	
	//시퀀스 번호 생성 메소드
	public int getSequence() throws Exception{
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql ="select emp_seq.nextval from dual";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		rs.next();
		int seq = rs.getInt(1); 
			
		con.close();
		
		return seq; 
			
	}
	
	//사원 추가 메소드
	public void empAdd(EmployeeDto employeeDto) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "insert into employee(emp_no, emp_name, emp_id, emp_pw, emp_phone, "
						+ "emp_email, emp_addr, emp_birth, emp_title, emp_salary, emp_auth, "
						+ "emp_state, emp_etc, emp_dep) "
					+ "	values(?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, employeeDto.getEmp_no());
		ps.setString(2, employeeDto.getEmp_name());
		ps.setString(3, employeeDto.getEmp_id());
		ps.setString(4, employeeDto.getEmp_pw());
		ps.setString(5, employeeDto.getEmp_phone());
		ps.setString(6, employeeDto.getEmp_email());
		ps.setString(7, employeeDto.getEmp_addr());
		ps.setDate(8, employeeDto.getEmp_birth());
		ps.setString(9, employeeDto.getEmp_title());
		ps.setInt(10, employeeDto.getEmp_salary());
		ps.setString(11, employeeDto.getEmp_auth());
		ps.setString(12, employeeDto.getEmp_state());
		ps.setString(13, employeeDto.getEmp_etc());
		ps.setString(14, employeeDto.getEmp_dep());
		ps.execute();
		
		con.close();
			
	}
	
	//사원 상세 조회 메소드
	public EmployeeDto find(int emp_no) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "select * from employee where emp_no = ?";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, emp_no);
		ResultSet rs = ps.executeQuery();
		EmployeeDto employeeDto;
		
		if(rs.next()) {
			employeeDto = new EmployeeDto();
			employeeDto.setEmp_no(rs.getInt("emp_no"));
			employeeDto.setEmp_name(rs.getString("emp_name"));
			employeeDto.setEmp_id(rs.getString("emp_id"));
			employeeDto.setEmp_email(rs.getString("emp_email"));
			employeeDto.setEmp_phone(rs.getString("emp_phone"));
			employeeDto.setEmp_birth(rs.getDate("emp_birth")); 
			employeeDto.setEmp_addr(rs.getString("emp_addr"));
			employeeDto.setEmp_dep(rs.getString("emp_dep"));
			employeeDto.setEmp_title(rs.getString("emp_title"));
			employeeDto.setEmp_hiredate(rs.getDate("emp_hiredate"));
			employeeDto.setEmp_salary(rs.getInt("emp_salary"));
			employeeDto.setEmp_auth(rs.getString("emp_auth"));
			employeeDto.setEmp_state(rs.getString("emp_state"));
			employeeDto.setEmp_etc(rs.getString("emp_etc"));
		}
		else {
			employeeDto = null;
		}
		
		con.close();
		
		return employeeDto;
	}
	
	//사원 상세 조회 메소드
	public EmployeeDto find(String emp_id) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "select * from employee where emp_id = ?";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, emp_id);
		ResultSet rs = ps.executeQuery();
		EmployeeDto employeeDto;
		
		if(rs.next()) {
			employeeDto = new EmployeeDto();
			employeeDto.setEmp_no(rs.getInt("emp_no"));
			employeeDto.setEmp_name(rs.getString("emp_name"));
			employeeDto.setEmp_id(rs.getString("emp_id"));
			employeeDto.setEmp_email(rs.getString("emp_email"));
			employeeDto.setEmp_phone(rs.getString("emp_phone"));
			employeeDto.setEmp_birth(rs.getDate("emp_birth")); 
			employeeDto.setEmp_addr(rs.getString("emp_addr"));
			employeeDto.setEmp_dep(rs.getString("emp_dep"));
			employeeDto.setEmp_title(rs.getString("emp_title"));
			employeeDto.setEmp_hiredate(rs.getDate("emp_hiredate"));
			employeeDto.setEmp_salary(rs.getInt("emp_salary"));
			employeeDto.setEmp_auth(rs.getString("emp_auth"));
			employeeDto.setEmp_state(rs.getString("emp_state"));
			employeeDto.setEmp_etc(rs.getString("emp_etc"));
			
		}
		else {
			employeeDto = null;
		}
		
		con.close();
		
		return employeeDto;
	}
		
	//이메일로 사원 찾기
	public EmployeeDto findByEmail(String emp_email) throws Exception{
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "select * from employee where emp_email = ?";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, emp_email);
		ResultSet rs = ps.executeQuery();
		EmployeeDto employeeDto;
		
		if(rs.next()) {
			employeeDto = new EmployeeDto();
			employeeDto.setEmp_no(rs.getInt("emp_no"));
			employeeDto.setEmp_name(rs.getString("emp_name"));
			employeeDto.setEmp_id(rs.getString("emp_id"));
			employeeDto.setEmp_email(rs.getString("emp_email"));
			employeeDto.setEmp_phone(rs.getString("emp_phone"));
			employeeDto.setEmp_birth(rs.getDate("emp_birth")); 
			employeeDto.setEmp_addr(rs.getString("emp_addr"));
			employeeDto.setEmp_dep(rs.getString("emp_dep"));
			employeeDto.setEmp_title(rs.getString("emp_title"));
			employeeDto.setEmp_hiredate(rs.getDate("emp_hiredate"));
			employeeDto.setEmp_salary(rs.getInt("emp_salary"));
			employeeDto.setEmp_auth(rs.getString("emp_auth"));
			employeeDto.setEmp_state(rs.getString("emp_state"));
			employeeDto.setEmp_etc(rs.getString("emp_etc"));
			
		}
		else {
			employeeDto = null;
		}
		
		con.close();
		
		return employeeDto;
	}
	
	//사원 리스트 
	public List<EmployeeDto> select() throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "select * from employee order by emp_no desc";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		
		List<EmployeeDto> list = new ArrayList<>();
		
		while(rs.next()) {
			EmployeeDto employeeDto = new EmployeeDto();
			employeeDto.setEmp_no(rs.getInt("emp_no"));
			employeeDto.setEmp_name(rs.getString("emp_name"));
			employeeDto.setEmp_dep(rs.getString("emp_dep"));
			employeeDto.setEmp_title(rs.getString("emp_title"));
			employeeDto.setEmp_auth(rs.getString("emp_auth"));
			employeeDto.setEmp_state(rs.getString("emp_state"));
			employeeDto.setEmp_email(rs.getString("emp_email"));
			employeeDto.setEmp_phone(rs.getString("emp_phone"));
			
			list.add(employeeDto);
		}
		
		con.close(); 
		
		return list;
	}
	
	//사원 리스트(검색 결과)
	public List<EmployeeDto> select(String type, String keyword) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "select * from employee where instr(#1, ?) > 0 order by emp_no desc";
		
		sql = sql.replace("#1", type);
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, keyword);
		ResultSet rs = ps.executeQuery();
		
		List<EmployeeDto> list = new ArrayList<>();
		
		while(rs.next()) {
			EmployeeDto employeeDto = new EmployeeDto();
			employeeDto.setEmp_no(rs.getInt("emp_no"));
			employeeDto.setEmp_name(rs.getString("emp_name"));
			employeeDto.setEmp_dep(rs.getString("emp_dep"));
			employeeDto.setEmp_title(rs.getString("emp_title"));
			employeeDto.setEmp_auth(rs.getString("emp_auth"));
			employeeDto.setEmp_state(rs.getString("emp_state"));
			employeeDto.setEmp_email(rs.getString("emp_email"));
			employeeDto.setEmp_phone(rs.getString("emp_phone"));
			
			list.add(employeeDto);
			
		}
		
		con.close(); 
		
		return list;		
	}
	
	//사원 정보 수정 메소드
	//데이터 (사원번호, 이메일, 전화번호, 주소, 부서, 직급, 급여, 사수, 권한, 상태, 기타사항)
	public void update(EmployeeDto employeeDto) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "update employee set emp_email = ?, emp_phone = ?, emp_addr = ?, "
				+ "emp_dep = ?, emp_title = ?, emp_salary = ?, emp_auth = ?, "
				+ "emp_state = ?, emp_hiredate = ?, emp_etc =? where emp_no = ?";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, employeeDto.getEmp_email());
		ps.setString(2, employeeDto.getEmp_phone());
		ps.setString(3, employeeDto.getEmp_addr());
		ps.setString(4, employeeDto.getEmp_dep());
		ps.setString(5, employeeDto.getEmp_title());
		ps.setInt(6, employeeDto.getEmp_salary());
		ps.setString(7, employeeDto.getEmp_auth());
		ps.setString(8, employeeDto.getEmp_state());
		ps.setDate(9, employeeDto.getEmp_hiredate());
		ps.setString(10, employeeDto.getEmp_etc());
		ps.setInt(11, employeeDto.getEmp_no());
		ps.execute();
		
		con.close();
			
	}
	
	//사원 삭제
	public void delete(int emp_no) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "delete employee where emp_no = ?";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, emp_no);
		ps.execute();
		
		con.close();
		
	}
	
	//사원용 비밀번호 변경
	public boolean editPW(int emp_no, String emp_pw, String change_pw) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "update employee set emp_pw=? where emp_no=? and emp_pw=?";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, change_pw);
		ps.setInt(2, emp_no);
		ps.setString(3, emp_pw);
		int count = ps.executeUpdate();
		
		con.close();
		
		return count > 0;
	}
	
	//페이징을 이용한 검색
	public List<EmployeeDto> pagingList(String type, String keyword, int startRow, int endRow) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "select * from(" +
						"select rownum rn, TMP.* from(" +
							"select * from employee "
								+ "where instr(#1, ?) > 0 "
								+ "order by emp_no desc" +
							")TMP" +
						") where rn between ? and ?";
		
		
		sql = sql.replace("#1", type);
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, keyword);
		ps.setInt(2, startRow);
		ps.setInt(3, endRow);
		ResultSet rs = ps.executeQuery();
		
		List<EmployeeDto> list = new ArrayList<>();
		
		while(rs.next()) {
			EmployeeDto employeeDto = new EmployeeDto();
			employeeDto.setEmp_no(rs.getInt("emp_no"));
			employeeDto.setEmp_name(rs.getString("emp_name"));
			employeeDto.setEmp_dep(rs.getString("emp_dep"));
			employeeDto.setEmp_title(rs.getString("emp_title"));
			employeeDto.setEmp_auth(rs.getString("emp_auth"));
			employeeDto.setEmp_state(rs.getString("emp_state"));
			employeeDto.setEmp_email(rs.getString("emp_email"));
			employeeDto.setEmp_phone(rs.getString("emp_phone"));
			
			list.add(employeeDto);
		}
		
		con.close(); 
		
		return list;
	}
	
	//페이징을 이용한 목록
	public List<EmployeeDto> pagingList(int startRow, int endRow) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "select * from(" +
						"select rownum rn, TMP.* from(" +
							"select * from employee order by emp_no desc" +
						")TMP" +
					") where rn between ? and ?";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, startRow);
		ps.setInt(2, endRow);
		ResultSet rs = ps.executeQuery();
		
		List<EmployeeDto> list = new ArrayList<>();
		
		while(rs.next()) {
			EmployeeDto employeeDto = new EmployeeDto();
			employeeDto.setEmp_no(rs.getInt("emp_no"));
			employeeDto.setEmp_name(rs.getString("emp_name"));
			employeeDto.setEmp_dep(rs.getString("emp_dep"));
			employeeDto.setEmp_title(rs.getString("emp_title"));
			employeeDto.setEmp_auth(rs.getString("emp_auth"));
			employeeDto.setEmp_state(rs.getString("emp_state"));
			employeeDto.setEmp_email(rs.getString("emp_email"));
			employeeDto.setEmp_phone(rs.getString("emp_phone"));
			
			list.add(employeeDto);
		}
		
		con.close(); 
		
		return list;
		
	}
	
	//페이징을 이용한 검색(type제외)
	public List<EmployeeDto> pagingList(int startRow, int endRow, String keyword) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "select * from(" +
						"select rownum rn, TMP.* from(" +
							"select * from employee "
								+ "where (emp_name || emp_dep || emp_phone || emp_email) like ? "
								+ "order by emp_no desc" +
							")TMP" +
						") where rn between ? and ?";
		
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, "%"+keyword+"%");
		ps.setInt(2, startRow);
		ps.setInt(3, endRow);
		ResultSet rs = ps.executeQuery();
		
		List<EmployeeDto> list = new ArrayList<>();
		
		while(rs.next()) {
			EmployeeDto employeeDto = new EmployeeDto();
			employeeDto.setEmp_no(rs.getInt("emp_no"));
			employeeDto.setEmp_name(rs.getString("emp_name"));
			employeeDto.setEmp_dep(rs.getString("emp_dep"));
			employeeDto.setEmp_title(rs.getString("emp_title"));
			employeeDto.setEmp_auth(rs.getString("emp_auth"));
			employeeDto.setEmp_state(rs.getString("emp_state"));
			employeeDto.setEmp_email(rs.getString("emp_email"));
			employeeDto.setEmp_phone(rs.getString("emp_phone"));
			
			
			list.add(employeeDto);
		}
		
		con.close(); 
		
		return list;
	}
	
	//페이징을 이용한 목록(부서)
	public List<EmployeeDto> pagingList(String emp_dep, int startRow, int endRow) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "select * from(" +
						"select rownum rn, TMP.* from(" +
							"select * from employee where emp_dep = ? order by emp_no desc" +
						")TMP" +
					") where rn between ? and ?";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, emp_dep);
		ps.setInt(2, startRow);
		ps.setInt(3, endRow);
		ResultSet rs = ps.executeQuery();
		
		List<EmployeeDto> list = new ArrayList<>();
		
		while(rs.next()) {
			EmployeeDto employeeDto = new EmployeeDto();
			employeeDto.setEmp_no(rs.getInt("emp_no"));
			employeeDto.setEmp_name(rs.getString("emp_name"));
			employeeDto.setEmp_dep(rs.getString("emp_dep"));
			employeeDto.setEmp_title(rs.getString("emp_title"));
			employeeDto.setEmp_auth(rs.getString("emp_auth"));
			employeeDto.setEmp_state(rs.getString("emp_state"));
			employeeDto.setEmp_email(rs.getString("emp_email"));
			employeeDto.setEmp_phone(rs.getString("emp_phone"));
			
			list.add(employeeDto);
		}
		
		con.close(); 
		
		return list;
		
	}
	
	//페이징을 이용한 검색(부서/type제외)
	public List<EmployeeDto> pagingList(String emp_dep, int startRow, int endRow, String keyword) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "select * from (" + 
						"select rownum rn, TMP.* from(" + 
							"select * from(select * from employee where emp_dep = ?) " + 
							"where (emp_name || emp_phone || emp_email) like ?" + 
						")TMP" + 
						")where rn between ? and ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, emp_dep);
		ps.setString(2, "%" + keyword + "%");
		ps.setInt(3, startRow);
		ps.setInt(4, endRow);
		ResultSet rs = ps.executeQuery();
		
		List<EmployeeDto> list = new ArrayList<>();
		
		while(rs.next()) {
			EmployeeDto employeeDto = new EmployeeDto();
			employeeDto.setEmp_no(rs.getInt("emp_no"));
			employeeDto.setEmp_name(rs.getString("emp_name"));
			employeeDto.setEmp_dep(rs.getString("emp_dep"));
			employeeDto.setEmp_title(rs.getString("emp_title"));
			employeeDto.setEmp_auth(rs.getString("emp_auth"));
			employeeDto.setEmp_state(rs.getString("emp_state"));
			employeeDto.setEmp_email(rs.getString("emp_email"));
			employeeDto.setEmp_phone(rs.getString("emp_phone"));
			
			list.add(employeeDto);
		}
		
		con.close(); 
		
		return list;
		
	}
	
	//검색 개수를 구하는 메소드
	public int getCount(String type, String keyword) throws Exception{
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql ="select count(*) from employee where instr(#1,?) > 0";
		
		sql=sql.replace("#1", type);
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, keyword);
		ResultSet rs = ps.executeQuery();
		rs.next();
		int count = rs.getInt(1); 
	
		con.close();
		return count;
		
	}
	
	//검색 개수를 구하는 메소드(type제외)
	public int getCount(String keyword) throws Exception{
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql ="select count(*) from employee where (emp_name || emp_phone || emp_email ||emp_dep) like ?";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, "%"+keyword+"%");
		ResultSet rs = ps.executeQuery();
		rs.next();
		int count = rs.getInt(1); 
	
		con.close();
		return count;
		
	}
	
	//목록 개수를 구하는 메소드
	public int getCount() throws Exception{
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "select count(*) from employee";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		rs.next();
		int count = rs.getInt(1);
	
		con.close();
		return count;
	}
	
	//부서이름으로 조회한 목록 개수
	public int getDepCount(String emp_dep) throws Exception{
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "select count(*) from employee where emp_dep=?";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, emp_dep);
		ResultSet rs = ps.executeQuery();
		rs.next();
		int count = rs.getInt(1);
	
		con.close();
		return count;
	}
	
	//부서이름+검색으로 조회한 목록 개수
	public int getDepCount(String emp_dep, String keyword) throws Exception{
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "select count(*) from employee where emp_dep=? and (emp_name || emp_phone || emp_email ||emp_dep) like ?";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, emp_dep);
		ps.setString(2, "%"+keyword+"%");
		ResultSet rs = ps.executeQuery();
		rs.next();
		int count = rs.getInt(1);
	
		con.close();
		return count;
	}
	
	//목록 구하는 메소드(부서이름)
	public List<EmployeeDto> getDep(String emp_dep) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "select * from employee where emp_dep = ?";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, emp_dep);
		ResultSet rs = ps.executeQuery();
		
		List<EmployeeDto> list = new ArrayList<>();
		while(rs.next()) {
			EmployeeDto empDto = new EmployeeDto();
			empDto.setEmp_no(rs.getInt("emp_no"));
			empDto.setEmp_name(rs.getString("emp_name"));
			empDto.setEmp_dep(rs.getString("emp_dep"));
			empDto.setEmp_title(rs.getString("emp_title"));
			empDto.setEmp_auth(rs.getString("emp_auth"));
			empDto.setEmp_state(rs.getString("emp_state"));
			empDto.setEmp_email(rs.getString("emp_email"));
			empDto.setEmp_phone(rs.getString("emp_phone"));
			
			list.add(empDto);
		}
		
		con.close();
		return list;
		
	}
	
	//로그인
	public boolean login(EmployeeDto dto) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
			
		String sql = "select * from employee where emp_id=? and emp_pw=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, dto.getEmp_id());
		ps.setString(2, dto.getEmp_pw());
		ResultSet rs = ps.executeQuery();
			
		boolean result = rs.next();
			
		con.close();
		
		return result;
	}

	//장기 이탈자 상태 변경
	public void setLeave(int vac_target_no) throws Exception{
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "update employee set emp_state = '휴가' where emp_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, vac_target_no);
		
		ps.execute();
		
		con.close();
	}
	
	
}