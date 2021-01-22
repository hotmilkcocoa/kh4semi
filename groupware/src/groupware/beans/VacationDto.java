package groupware.beans;

import java.sql.Date;

public class VacationDto {
	private int vac_no;
	private String vac_category;
	private Date vac_start;
	private Date vac_end;
	private String vac_reason;
	private String vac_comment;
	private String vac_status;
	private Date vac_write_date;

	private int vac_writer_no;
	private int vac_target_no;
	
	public VacationDto() {
		// TODO Auto-generated constructor stub
	}

	public int getVac_no() {
		return vac_no;
	}

	public void setVac_no(int vac_no) {
		this.vac_no = vac_no;
	}

	public String getVac_category() {
		return vac_category;
	}

	public void setVac_category(String vac_category) {
		this.vac_category = vac_category;
	}

	public Date getVac_start() {
		return vac_start;
	}

	public void setVac_start(Date vac_start) {
		this.vac_start = vac_start;
	}

	public Date getVac_end() {
		return vac_end;
	}

	public void setVac_end(Date vac_end) {
		this.vac_end = vac_end;
	}

	public String getVac_reason() {
		return vac_reason;
	}

	public void setVac_reason(String vac_reason) {
		this.vac_reason = vac_reason;
	}

	public String getVac_comment() {
		return vac_comment;
	}

	public void setVac_comment(String vac_comment) {
		this.vac_comment = vac_comment;
	}

	public String getVac_status() {
		return vac_status;
	}

	public void setVac_status(String vac_status) {
		this.vac_status = vac_status;
	}
	
	public Date getVac_write_date() {
		return vac_write_date;
	}

	public void setVac_write_date(Date vac_write_date) {
		this.vac_write_date = vac_write_date;
	}

	public int getVac_writer_no() {
		return vac_writer_no;
	}

	public void setVac_writer_no(int vac_writer_no) {
		this.vac_writer_no = vac_writer_no;
	}

	public int getVac_target_no() {
		return vac_target_no;
	}

	public void setVac_target_no(int vac_target_no) {
		this.vac_target_no = vac_target_no;
	}
	
	
}
