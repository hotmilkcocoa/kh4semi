package groupware.beans;

import java.sql.Date;

public class AnnualDto {
	private int emp_no;
	private int ann_occurred;
	private int ann_used;
	
	public AnnualDto() {
		// TODO Auto-generated constructor stub
	}

	public int getEmp_no() {
		return emp_no;
	}

	public void setEmp_no(int emp_no) {
		this.emp_no = emp_no;
	}

	public int getAnn_occurred() {
		return ann_occurred;
	}

	public void setAnn_occurred(int ann_occurred) {
		this.ann_occurred = ann_occurred;
	}

	public int getAnn_used() {
		return ann_used;
	}

	public void setAnn_used(int ann_used) {
		this.ann_used = ann_used;
	}

	
}
