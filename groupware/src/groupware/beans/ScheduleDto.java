package groupware.beans;

import java.sql.Timestamp;

public class ScheduleDto {
	private int sch_no;
	private String sch_name;
	private String sch_content;
	private String sch_place;
	private Timestamp sch_start;
	private Timestamp sch_end;
	private String sch_open;
	private int emp_no;
	private String sch_for_com;
	
	public ScheduleDto() {
		// TODO Auto-generated constructor stub
	}

	public int getSch_no() {
		return sch_no;
	}

	public void setSch_no(int sch_no) {
		this.sch_no = sch_no;
	}

	public String getSch_name() {
		return sch_name;
	}

	public void setSch_name(String sch_name) {
		this.sch_name = sch_name;
	}

	public String getSch_content() {
		return sch_content;
	}

	public void setSch_content(String sch_content) {
		this.sch_content = sch_content;
	}

	public String getSch_place() {
		return sch_place;
	}

	public void setSch_place(String sch_place) {
		this.sch_place = sch_place;
	}

	public Timestamp getSch_start() {
		return sch_start;
	}

	public void setSch_start(Timestamp sch_start) {
		this.sch_start = sch_start;
	}

	public Timestamp getSch_end() {
		return sch_end;
	}

	public void setSch_end(Timestamp sch_end) {
		this.sch_end = sch_end;
	}

	public String getSch_open() {
		return sch_open;
	}

	public void setSch_open(String sch_open) {
		this.sch_open = sch_open;
	}

	public int getEmp_no() {
		return emp_no;
	}

	public void setEmp_no(int emp_no) {
		this.emp_no = emp_no;
	}

	public String getSch_for_com() {
		return sch_for_com;
	}

	public void setSch_for_com(String sch_for_com) {
		this.sch_for_com = sch_for_com;
	}
	
	
}
