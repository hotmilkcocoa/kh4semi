package groupware.beans;

import java.sql.Timestamp;

public class AttendanceDto {
	private int att_no;
	private Timestamp att_start;
	private Timestamp att_end;
	private int emp_no;
	
	public AttendanceDto() {
		// TODO Auto-generated constructor stub
	}

	public int getAtt_no() {
		return att_no;
	}

	public void setAtt_no(int att_no) {
		this.att_no = att_no;
	}

	public Timestamp getAtt_start() {
		return att_start;
	}

	public void setAtt_start(Timestamp att_start) {
		this.att_start = att_start;
	}

	public Timestamp getAtt_end() {
		return att_end;
	}

	public void setAtt_end(Timestamp att_end) {
		this.att_end = att_end;
	}

	public int getEmp_no() {
		return emp_no;
	}

	public void setEmp_no(int emp_no) {
		this.emp_no = emp_no;
	}
	
	
}
