package groupware.beans;

import java.sql.Date;

public class BoardDto {
	public int board_no;
	public int board_writer;
	public String board_header;
	public String board_title;
	public String board_context;
	public Date board_writedate;
	public String board_dep;
	public int board_read;
	public BoardDto() {
		super();
	}
	public int getBoard_no() {
		return board_no;
	}
	public void setBoard_no(int board_no) {
		this.board_no = board_no;
	}
	public int getBoard_writer() {
		return board_writer;
	}
	public void setBoard_writer(int board_writer) {
		this.board_writer = board_writer;
	}
	public String getBoard_header() {
		return board_header;
	}
	public void setBoard_header(String board_header) {
		this.board_header = board_header;
	}
	public String getBoard_title() {
		return board_title;
	}
	public void setBoard_title(String board_title) {
		this.board_title = board_title;
	}
	public String getBoard_context() {
		return board_context;
	}
	public void setBoard_context(String board_context) {
		this.board_context = board_context;
	}
	public Date getBoard_writedate() {
		return board_writedate;
	}
	public void setBoard_writedate(Date board_writedate) {
		this.board_writedate = board_writedate;
	}
	public String getBoard_dep() {
		return board_dep;
	}
	public void setBoard_dep(String board_dep) {
		this.board_dep = board_dep;
	}
	public int getBoard_read() {
		return board_read;
	}
	public void setBoard_read(int board_read) {
		this.board_read = board_read;
	}
	public String getBoard_header_string() {
		if(this.board_header == null) 
			return "";
		else
			return this.board_header;
	}
}
