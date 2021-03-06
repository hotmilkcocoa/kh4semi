package groupware.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.TreeMap;

import groupware.util.JdbcUtil;

public class ScheduleDao {
	public static final String USER = "groupware";
	public static final String PW = "groupware";
	
	//개인 일정 등록
	public void insert(ScheduleDto scheduleDto) throws Exception{
		Connection con = JdbcUtil.getConnection(USER, PW);
		
		String sql = "insert into schedule values(schedule_seq.nextval, ?, ?, ?, ?, ?, ?, ?, 'false')";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, scheduleDto.getSch_name());
		ps.setString(2, scheduleDto.getSch_content());
		ps.setString(3, scheduleDto.getSch_place());
		ps.setTimestamp(4, scheduleDto.getSch_start());
		ps.setTimestamp(5, scheduleDto.getSch_end());
		ps.setString(6, scheduleDto.getSch_open());
		ps.setInt(7, scheduleDto.getEmp_no());
		
		ps.execute();
		
		con.close();
	}
	//회사 일정 등록
	public void insertForCom(ScheduleDto scheduleDto) throws Exception{
		Connection con = JdbcUtil.getConnection(USER, PW);
		
		String sql = "insert into schedule values(schedule_seq.nextval, ?, ?, ?, ?, ?, ?, ?, 'true')";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, scheduleDto.getSch_name());
		ps.setString(2, scheduleDto.getSch_content());
		ps.setString(3, scheduleDto.getSch_place());
		ps.setTimestamp(4, scheduleDto.getSch_start());
		ps.setTimestamp(5, scheduleDto.getSch_end());
		ps.setString(6, scheduleDto.getSch_open());
		ps.setInt(7, scheduleDto.getEmp_no());
		
		ps.execute();
		
		con.close();
	}
	//일정 단일 조회
	public ScheduleDto find(int sch_no) throws Exception{
		Connection con = JdbcUtil.getConnection(USER, PW);
		
		String sql = "select * from schedule where sch_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, sch_no);
		
		ResultSet rs = ps.executeQuery();
		
		ScheduleDto scheduleDto;
		if(rs.next()) {
			scheduleDto = new ScheduleDto();
			scheduleDto.setSch_no(rs.getInt("sch_no"));
			scheduleDto.setSch_name(rs.getString("sch_name"));
			scheduleDto.setSch_content(rs.getString("sch_content"));
			scheduleDto.setSch_place(rs.getString("sch_place"));
			scheduleDto.setSch_start(rs.getTimestamp("sch_start"));
			scheduleDto.setSch_end(rs.getTimestamp("sch_end"));
			scheduleDto.setSch_open(rs.getString("sch_open"));
			scheduleDto.setEmp_no(rs.getInt("emp_no"));
			scheduleDto.setSch_for_com(rs.getString("sch_for_com"));
		} else {
			scheduleDto = null;
		}
		
		con.close();
		return scheduleDto;
	}
	//일정 수정
	public void update(ScheduleDto scheduleDto) throws Exception{
		Connection con = JdbcUtil.getConnection(USER, PW);
		
		String sql = "update schedule set sch_name=?, sch_content=?, sch_place=?, sch_start=?, sch_end=?, sch_open=? where sch_no=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, scheduleDto.getSch_name());
		ps.setString(2, scheduleDto.getSch_content());
		ps.setString(3, scheduleDto.getSch_place());
		ps.setTimestamp(4, scheduleDto.getSch_start());
		ps.setTimestamp(5, scheduleDto.getSch_end());
		ps.setString(6, scheduleDto.getSch_open());
		ps.setInt(7, scheduleDto.getSch_no());
		
		ps.execute();
		
		con.close();
	}
	//일정 전체 삭제
	public void delete(int emp_no) throws Exception{
		Connection con = JdbcUtil.getConnection(USER, PW);
		
		String sql = "delete from schedule where emp_no = ? and sch_for_com = 'false'";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, emp_no);
		
		ps.execute();
		
		con.close();
	}
	//일정 기간 삭제
	public void delete(int emp_no, Timestamp del_from) throws Exception {
		Connection con = JdbcUtil.getConnection(USER, PW);
		
		String sql = "delete from schedule where emp_no = ? and sch_end < ? and sch_for_com = 'false'";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, emp_no);
		ps.setTimestamp(2, del_from);
		
		ps.execute();
		
		con.close();
	}
	//일정 단일 삭제
	public void deleteOne(int sch_no) throws Exception{
		Connection con = JdbcUtil.getConnection(USER, PW);
		
		String sql = "delete from schedule where sch_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, sch_no);
		
		ps.execute();
		
		con.close();
	}
	//일정 사원별 기간 조회
	public TreeMap<LocalDate, List<ScheduleDto>> select(int emp_no, int index, Timestamp startOfCal, Timestamp endOfCal) throws Exception{
		Connection con = JdbcUtil.getConnection(USER, PW);
		
		String sql = "select * from schedule where sch_for_com = 'false' and emp_no = ? and sch_start >= ? and sch_start < ? order by sch_no desc";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, emp_no);
		ps.setTimestamp(2, startOfCal);
		ps.setTimestamp(3, endOfCal);
		ResultSet rs = ps.executeQuery();
		
		List<ScheduleDto> schList = new ArrayList<ScheduleDto>();
		
		while(rs.next()) {
			ScheduleDto scheduleDto = new ScheduleDto();
			scheduleDto.setSch_no(rs.getInt("sch_no"));
			scheduleDto.setSch_name(rs.getString("sch_name"));
			scheduleDto.setSch_content(rs.getString("sch_content"));
			scheduleDto.setSch_place(rs.getString("sch_place"));
			scheduleDto.setSch_start(rs.getTimestamp("sch_start"));
			scheduleDto.setSch_end(rs.getTimestamp("sch_end"));
			scheduleDto.setSch_open(rs.getString("sch_open"));
			scheduleDto.setEmp_no(rs.getInt("emp_no"));
			scheduleDto.setSch_for_com(rs.getString("sch_for_com"));
			
			schList.add(scheduleDto);
		}
		con.close();
		
		TreeMap<LocalDate, List<ScheduleDto>> schMap = new TreeMap<>();
		
		for(int i=0; i<index; i++) {
			schMap.put(startOfCal.toLocalDateTime().toLocalDate().plusDays(i), null);
		}
		for(LocalDate key : schMap.keySet()) {
			List<ScheduleDto> newList = new ArrayList<ScheduleDto>();
			for(ScheduleDto schDto : schList) {
				if(key.isEqual(schDto.getSch_start().toLocalDateTime().toLocalDate())) {
					newList.add(schDto);
				}
			}
			schMap.replace(key, newList);
		}
		
		
		return schMap;
	}
	
	//공유 일정 기간 조회
	public TreeMap<LocalDate, List<ScheduleDto>> selectForShare(List<Share_schDto> shareList, int index, Timestamp startOfCal, Timestamp endOfCal) throws Exception{
		Connection con = JdbcUtil.getConnection(USER, PW);
		
		StringBuffer sb = new StringBuffer("select * from schedule where sch_start >= ? and sch_start < ? and sch_for_com = 'true'");
		for(int i=1; i<=shareList.size(); i++) {
			if(i==1) {
				sb.append(" or (sch_open = 'true' and (emp_no = ? ");
			} else {
				sb.append(" or emp_no = ? ");
			}
			if(i==shareList.size()) {
				sb.append("))");
			}
		}
		sb.append(" order by sch_no desc");
		
		String sql = sb.toString();
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setTimestamp(1, startOfCal);
		ps.setTimestamp(2, endOfCal);
		int j = 3;
		for(Share_schDto shareDto : shareList) {
			ps.setInt(j, shareDto.getTarget_no());
			j++;
		}
		ResultSet rs = ps.executeQuery();
		
		List<ScheduleDto> schList = new ArrayList<ScheduleDto>();
		
		while(rs.next()) {
			ScheduleDto scheduleDto = new ScheduleDto();
			scheduleDto.setSch_no(rs.getInt("sch_no"));
			scheduleDto.setSch_name(rs.getString("sch_name"));
			scheduleDto.setSch_content(rs.getString("sch_content"));
			scheduleDto.setSch_place(rs.getString("sch_place"));
			scheduleDto.setSch_start(rs.getTimestamp("sch_start"));
			scheduleDto.setSch_end(rs.getTimestamp("sch_end"));
			scheduleDto.setSch_open(rs.getString("sch_open"));
			scheduleDto.setEmp_no(rs.getInt("emp_no"));
			scheduleDto.setSch_for_com(rs.getString("sch_for_com"));
			
			schList.add(scheduleDto);
		}
		con.close();
		
		TreeMap<LocalDate, List<ScheduleDto>> schMap = new TreeMap<>();
		
		for(int i=0; i<index; i++) {
			schMap.put(startOfCal.toLocalDateTime().toLocalDate().plusDays(i), null);
		}
		for(LocalDate key : schMap.keySet()) {
			List<ScheduleDto> newList = new ArrayList<ScheduleDto>();
			for(ScheduleDto schDto : schList) {
				if(key.isEqual(schDto.getSch_start().toLocalDateTime().toLocalDate())) {
					newList.add(schDto);
				}
			}
			schMap.replace(key, newList);
		}
		
		
		return schMap;
	}
	
	//회사일정 기간 조회
	public TreeMap<LocalDate, List<ScheduleDto>> selectForCom(int index, Timestamp startOfCal, Timestamp endOfCal) throws Exception{
      Connection con = JdbcUtil.getConnection(USER, PW);
      
      String sql = "select * from schedule where sch_for_com = 'true' and sch_start >= ? and sch_start < ? order by sch_no desc";
      PreparedStatement ps = con.prepareStatement(sql);
      ps.setTimestamp(1, startOfCal);
      ps.setTimestamp(2, endOfCal);
      ResultSet rs = ps.executeQuery();
      
      List<ScheduleDto> schList = new ArrayList<ScheduleDto>();
      
      while(rs.next()) {
         ScheduleDto scheduleDto = new ScheduleDto();
         scheduleDto.setSch_no(rs.getInt("sch_no"));
         scheduleDto.setSch_name(rs.getString("sch_name"));
         scheduleDto.setSch_content(rs.getString("sch_content"));
         scheduleDto.setSch_place(rs.getString("sch_place"));
         scheduleDto.setSch_start(rs.getTimestamp("sch_start"));
         scheduleDto.setSch_end(rs.getTimestamp("sch_end"));
         scheduleDto.setSch_open(rs.getString("sch_open"));
         scheduleDto.setEmp_no(rs.getInt("emp_no"));
         scheduleDto.setSch_for_com(rs.getString("sch_for_com"));
         
         schList.add(scheduleDto);
      }
      con.close();
      
      TreeMap<LocalDate, List<ScheduleDto>> schMap = new TreeMap<>();
      
      for(int i=0; i<index; i++) {
         schMap.put(startOfCal.toLocalDateTime().toLocalDate().plusDays(i), null);
      }
      for(LocalDate key : schMap.keySet()) {
         List<ScheduleDto> newList = new ArrayList<ScheduleDto>();
         for(ScheduleDto schDto : schList) {
            if(key.isEqual(schDto.getSch_start().toLocalDateTime().toLocalDate())) {
               newList.add(schDto);
            }
         }
         schMap.replace(key, newList);
      }
      
      
      return schMap;
   }

   //메인 페이지용 기간 조회
	public TreeMap<LocalDate, List<ScheduleDto>> selectForMain(int emp_no, List<Share_schDto> shareList, int index, Timestamp startOfCal, Timestamp endOfCal) throws Exception{
		Connection con = JdbcUtil.getConnection(USER, PW);
		
		StringBuffer sb = new StringBuffer("select * from schedule where sch_start >= ? and sch_start < ? and sch_for_com = 'true' or emp_no = ? ");
		for(int i=1; i<=shareList.size(); i++) {
			if(i==1) {
				sb.append(" or (sch_open = 'true' and (emp_no = ? ");
			} else {
				sb.append(" or emp_no = ? ");
			}
			if(i==shareList.size()) {
				sb.append("))");
			}
		}
		sb.append(" order by sch_no desc");
		
		String sql = sb.toString();
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setTimestamp(1, startOfCal);
		ps.setTimestamp(2, endOfCal);
		ps.setInt(3, emp_no);
		int j = 4;
		for(Share_schDto shareDto : shareList) {
			ps.setInt(j, shareDto.getTarget_no());
			j++;
		}
		ResultSet rs = ps.executeQuery();
		
		List<ScheduleDto> schList = new ArrayList<ScheduleDto>();
		
		while(rs.next()) {
			ScheduleDto scheduleDto = new ScheduleDto();
			scheduleDto.setSch_no(rs.getInt("sch_no"));
			scheduleDto.setSch_name(rs.getString("sch_name"));
			scheduleDto.setSch_content(rs.getString("sch_content"));
			scheduleDto.setSch_place(rs.getString("sch_place"));
			scheduleDto.setSch_start(rs.getTimestamp("sch_start"));
			scheduleDto.setSch_end(rs.getTimestamp("sch_end"));
			scheduleDto.setSch_open(rs.getString("sch_open"));
			scheduleDto.setEmp_no(rs.getInt("emp_no"));
			scheduleDto.setSch_for_com(rs.getString("sch_for_com"));
			
			schList.add(scheduleDto);
		}
		con.close();
		
		TreeMap<LocalDate, List<ScheduleDto>> schMap = new TreeMap<>();
		
		for(int i=0; i<index; i++) {
			schMap.put(startOfCal.toLocalDateTime().toLocalDate().plusDays(i), null);
		}
		for(LocalDate key : schMap.keySet()) {
			List<ScheduleDto> newList = new ArrayList<ScheduleDto>();
			for(ScheduleDto schDto : schList) {
				if(key.isEqual(schDto.getSch_start().toLocalDateTime().toLocalDate())) {
					newList.add(schDto);
				}
			}
			schMap.replace(key, newList);
		}
		
		
		return schMap;
	}
   
   //회사일정 리스트
   public List<ScheduleDto> selectForCom() throws Exception {
      Connection con = JdbcUtil.getConnection(USER, PW);
      
      String sql = "select * from schedule where sch_for_com = 'true' order by sch_no desc";
      
      PreparedStatement ps = con.prepareStatement(sql);
      ResultSet rs = ps.executeQuery();
      
      List<ScheduleDto> scheduleDtoList = new ArrayList<>();
      
      while(rs.next()) {
         ScheduleDto scheduleDto = new ScheduleDto();
         scheduleDto.setSch_no(rs.getInt("sch_no"));
         scheduleDto.setSch_name(rs.getString("sch_name"));
         scheduleDto.setSch_content(rs.getString("sch_content"));
         scheduleDto.setSch_place(rs.getString("sch_place"));
         scheduleDto.setSch_start(rs.getTimestamp("sch_start"));
         scheduleDto.setSch_end(rs.getTimestamp("sch_end"));
         scheduleDto.setSch_open(rs.getString("sch_open"));
         scheduleDto.setEmp_no(rs.getInt("emp_no"));
         scheduleDto.setSch_for_com(rs.getString("sch_for_com"));
         
         scheduleDtoList.add(scheduleDto);
         
      }
      con.close();
      return scheduleDtoList;
   }
   
   //회사일정 리스트(검색 결과)
   public List<ScheduleDto> select(String start, String end) throws Exception {
      Connection con = JdbcUtil.getConnection(USER, PW);
      
      String sql = "select * from schedule where sch_for_com = 'true' and sch_start between to_date(?) and to_date(?) order by sch_no desc";
      
      PreparedStatement ps = con.prepareStatement(sql);
      ps.setString(1, start);
      ps.setString(2, end);
      ResultSet rs = ps.executeQuery();
      
      List<ScheduleDto> scheduleDtoList = new ArrayList<>();
      
      while(rs.next()) {
         ScheduleDto scheduleDto = new ScheduleDto();
         scheduleDto.setSch_no(rs.getInt("sch_no"));
         scheduleDto.setSch_name(rs.getString("sch_name"));
         scheduleDto.setSch_content(rs.getString("sch_content"));
         scheduleDto.setSch_place(rs.getString("sch_place"));
         scheduleDto.setSch_start(rs.getTimestamp("sch_start"));
         scheduleDto.setSch_end(rs.getTimestamp("sch_end"));
         scheduleDto.setSch_open(rs.getString("sch_open"));
         scheduleDto.setEmp_no(rs.getInt("emp_no"));
         scheduleDto.setSch_for_com(rs.getString("sch_for_com"));
         
         scheduleDtoList.add(scheduleDto);
         
      }
      con.close();
      return scheduleDtoList;
   }
   //페이징을 이용한 검색
   public List<ScheduleDto> pagingList(String start, String end, int startRow, int endRow) throws Exception {
      Connection con = JdbcUtil.getConnection(USER, PW);
      
      String sql = "select * from(" +
                  "select rownum rn, TMP.* from(" +
                     "select * from schedule "
                        + "where sch_for_com = 'true' and sch_start between to_date(?) and to_date(?) "
                        + "order by sch_no desc" +
                     ")TMP" +
                  ") where rn between ? and ?";
      
      PreparedStatement ps = con.prepareStatement(sql);
      ps.setString(1, start);
      ps.setString(2, end);
      ps.setInt(3, startRow);
      ps.setInt(4, endRow);
      ResultSet rs = ps.executeQuery();
      
      List<ScheduleDto> scheduleDtoList = new ArrayList<>();
      
      while(rs.next()) {
         ScheduleDto scheduleDto = new ScheduleDto();
         scheduleDto.setSch_no(rs.getInt("sch_no"));
         scheduleDto.setSch_name(rs.getString("sch_name"));
         scheduleDto.setSch_content(rs.getString("sch_content"));
         scheduleDto.setSch_place(rs.getString("sch_place"));
         scheduleDto.setSch_start(rs.getTimestamp("sch_start"));
         scheduleDto.setSch_end(rs.getTimestamp("sch_end"));
         scheduleDto.setSch_open(rs.getString("sch_open"));
         scheduleDto.setEmp_no(rs.getInt("emp_no"));
         scheduleDto.setSch_for_com(rs.getString("sch_for_com"));
         
         scheduleDtoList.add(scheduleDto);
         
      }
      con.close();
      return scheduleDtoList;
   }
   
   //페이징을 이용한 목록
   public List<ScheduleDto> pagingList(int startRow, int endRow) throws Exception {
      Connection con = JdbcUtil.getConnection(USER, PW);
      
      String sql = "select * from(" +
                  "select rownum rn, TMP.* from(" +
                     "select * from schedule where sch_for_com = 'true' order by sch_no desc" +
                  ")TMP" +
               ") where rn between ? and ?";
      
      PreparedStatement ps = con.prepareStatement(sql);
      ps.setInt(1, startRow);
      ps.setInt(2, endRow);
      ResultSet rs = ps.executeQuery();
      
      List<ScheduleDto> scheduleDtoList = new ArrayList<>();
      
      while(rs.next()) {
         ScheduleDto scheduleDto = new ScheduleDto();
         scheduleDto.setSch_no(rs.getInt("sch_no"));
         scheduleDto.setSch_name(rs.getString("sch_name"));
         scheduleDto.setSch_content(rs.getString("sch_content"));
         scheduleDto.setSch_place(rs.getString("sch_place"));
         scheduleDto.setSch_start(rs.getTimestamp("sch_start"));
         scheduleDto.setSch_end(rs.getTimestamp("sch_end"));
         scheduleDto.setSch_open(rs.getString("sch_open"));
         scheduleDto.setEmp_no(rs.getInt("emp_no"));
         scheduleDto.setSch_for_com(rs.getString("sch_for_com"));
         
         scheduleDtoList.add(scheduleDto);
         
      }
      con.close();
      return scheduleDtoList;
      
   }
   
   //검색 개수를 구하는 메소드
   public int getCount(String start, String end) throws Exception{
      Connection con = JdbcUtil.getConnection(USER, PW);
      
      String sql ="select count(*) from schedule where sch_for_com = 'true' and sch_start between to_date(?) and to_date(?)";
      
      PreparedStatement ps = con.prepareStatement(sql);
      ps.setString(1, start);
      ps.setString(2, end);
      ResultSet rs = ps.executeQuery();
      rs.next();
      int count = rs.getInt(1); 
   
      con.close();
      return count;
      
   }
   
   //목록 개수를 구하는 메소드
   public int getCount() throws Exception{
      Connection con = JdbcUtil.getConnection(USER, PW);
      
      String sql = "select count(*) from schedule where sch_for_com = 'true'";
      
      PreparedStatement ps = con.prepareStatement(sql);
      ResultSet rs = ps.executeQuery();
      rs.next();
      int count = rs.getInt(1);
   
      con.close();
      return count;
   }
}
