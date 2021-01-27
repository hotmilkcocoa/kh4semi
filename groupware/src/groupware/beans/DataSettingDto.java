package groupware.beans;

import java.sql.Date;

public class DataSettingDto {

	private int dep_no;
	private String dep_name;
	private String dep_head;
	private int title_no;
	private String title_name;
	private int att_set_no;
	private Date att_set_start;
	private Date att_set_end;
	private int att_set_late;
	
	
	public DataSettingDto() {
		super();
	}

	public int getDep_no() {
		return dep_no;
	}

	public void setDep_no(int dep_no) {
		this.dep_no = dep_no;
	}

	public String getDep_name() {
		return dep_name;
	}

	public void setDep_name(String dep_name) {
		this.dep_name = dep_name;
	}

	public int getTitle_no() {
		return title_no;
	}

	public void setTitle_no(int title_no) {
		this.title_no = title_no;
	}

	public String getTitle_name() {
		return title_name;
	}

	public void setTitle_name(String title_name) {
		this.title_name = title_name;
	}

	public String getDep_head() {
		return dep_head;
	}

	public void setDep_head(String dep_head) {
		this.dep_head = dep_head;
	}

	public int getAtt_set_no() {
		return att_set_no;
	}

	public void setAtt_set_no(int att_set_no) {
		this.att_set_no = att_set_no;
	}

	public Date getAtt_set_start() {
		return att_set_start;
	}

	public void setAtt_set_start(Date att_set_start) {
		this.att_set_start = att_set_start;
	}

	public Date getAtt_set_end() {
		return att_set_end;
	}

	public void setAtt_set_end(Date att_set_end) {
		this.att_set_end = att_set_end;
	}

	public int getAtt_set_late() {
		return att_set_late;
	}

	public void setAtt_set_late(int att_set_late) {
		this.att_set_late = att_set_late;
	}

	
}
