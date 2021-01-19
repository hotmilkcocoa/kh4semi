package groupware.beans;

import java.sql.Date;

public class AnnualDto {
	private int ann_no;
	private Date ann_base;
	private int ann_occurred;
	private int ann_total;
	private int ann_used;
	private int emp_no;
	
	public AnnualDto() {
		// TODO Auto-generated constructor stub
	}

	public int getAnn_no() {
		return ann_no;
	}

	public void setAnn_no(int ann_no) {
		this.ann_no = ann_no;
	}

	public Date getAnn_base() {
		return ann_base;
	}

	public void setAnn_base(Date ann_base) {
		this.ann_base = ann_base;
	}

	public int getAnn_occurred() {
		return ann_occurred;
	}

	public void setAnn_occurred(int ann_occurred) {
		this.ann_occurred = ann_occurred;
	}

	public int getAnn_total() {
		return ann_total;
	}

	public void setAnn_total(int ann_total) {
		this.ann_total = ann_total;
	}

	public int getAnn_used() {
		return ann_used;
	}

	public void setAnn_used(int ann_used) {
		this.ann_used = ann_used;
	}

	public int getEmp_no() {
		return emp_no;
	}

	public void setEmp_no(int emp_no) {
		this.emp_no = emp_no;
	}
	
	
}
