package groupware.beans;

import java.sql.Date;

public class BoardFreeDto {
	public int free_no;
	public String free_writer;
	public String free_header;
	public String free_title;
	public String free_context;
	public Date free_writedate;
	public BoardFreeDto() {
		super();
	}
	public int getFree_no() {
		return free_no;
	}
	public void setFree_no(int free_no) {
		this.free_no = free_no;
	}
	public String getFree_writer() {
		return free_writer;
	}
	public void setFree_writer(String free_writer) {
		this.free_writer = free_writer;
	}
	public String getFree_header() {
		return free_header;
	}
	public void setFree_header(String free_header) {
		this.free_header = free_header;
	}
	public String getFree_title() {
		return free_title;
	}
	public void setFree_title(String free_title) {
		this.free_title = free_title;
	}
	public String getFree_context() {
		return free_context;
	}
	public void setFree_context(String free_context) {
		this.free_context = free_context;
	}
	public Date getFree_writedate() {
		return free_writedate;
	}
	public void setFree_writedate(Date free_writedate) {
		this.free_writedate = free_writedate;
	}

}
