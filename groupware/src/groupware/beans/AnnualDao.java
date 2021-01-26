package groupware.beans;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDate;
import java.time.Period;

import groupware.util.JdbcUtil;

public class AnnualDao {
	public static final String USER = "groupware";
	public static final String PW = "groupware";
	public Date getHireDate(int emp_no) throws Exception{
		Connection con = JdbcUtil.getConnection(USER, PW);
		
		String sql = "select emp_hiredate from employee where emp_no=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, emp_no);
		ResultSet rs = ps.executeQuery();
		
		rs.next();
		
		return rs.getDate(1);
	}

	public void insert(int emp_no) throws Exception{
		Connection con = JdbcUtil.getConnection(USER, PW);
		
		double anuual = getAnnual(getHireDate(emp_no).toLocalDate());
		
		String sql = "insert into annual values(?, ?, 0)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, emp_no);
		ps.setDouble(2, anuual);
		ps.execute();
		
		con.close();
	}

	public AnnualDto find(int emp_no) throws Exception{
		Connection con = JdbcUtil.getConnection(USER, PW);
		
		String sql = "select * from annual where emp_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, emp_no);
		ResultSet rs = ps.executeQuery();
		
		AnnualDto annualDto = new AnnualDto();
		if(rs.next()) {
			annualDto.setEmp_no(rs.getInt("emp_no"));
			annualDto.setAnn_occurred(rs.getDouble("ann_occurred"));
			annualDto.setAnn_used(rs.getDouble("ann_used"));
		}
		
		con.close();
		return annualDto;
	}
	
	public void update(int emp_no) throws Exception{
		Connection con = JdbcUtil.getConnection(USER, PW);
		
		String sql = "update annual set ann_occurred = ? where emp_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		int annual = getAnnual(getHireDate(emp_no).toLocalDate());
		ps.setDouble(1, annual);
		ps.setInt(2, emp_no);
		ps.execute();
		
		Date hireDate = getHireDate(emp_no);
		Period p = Period.between(hireDate.toLocalDate(), LocalDate.now());

		boolean fullYear = p.getMonths() == 0 && p.getDays() == 0;
		if(fullYear) {
			sql = "update annual set ann_used = ? where emp_no = ?";
			ps = con.prepareStatement(sql);
			ps.setDouble(1, 0);
			ps.setInt(2, emp_no);
			ps.execute();			
		}

		con.close();
	}
	
	public void use(int emp_no, double days) throws Exception{
		Connection con = JdbcUtil.getConnection(USER, PW);
		
		String sql = "update annual set ann_used = ann_used + ? where emp_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setDouble(1, days);
		ps.setInt(2, emp_no);
		ps.execute();
		
		con.close();
	}
	
	public static int getAnnual(LocalDate hireDate) {
		LocalDate now = LocalDate.now();
		
		Period p = Period.between(hireDate, now);
		
		int year = p.getYears();
		int month = p.getMonths();
		
		int annual;
		
		if(year < 1) {
			annual = month;
		} else {
			if(year < 3) {
				annual = 15;
			} else {
				annual = (year-1)/2 + 15;
			}
		}
		return (annual > 25) ? 25 : annual;
	}
}
