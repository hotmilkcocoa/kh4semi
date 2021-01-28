package groupware.beans;

import java.util.Date;

public class BoardReplyDto {
	private int reply_no;
	private int reply_origin;
	private int reply_writer;
	private String reply_context;
	private Date reply_date;
	public BoardReplyDto() {
		super();
	}
	public int getReply_no() {
		return reply_no;
	}
	public void setReply_no(int reply_no) {
		this.reply_no = reply_no;
	}
	public int getReply_origin() {
		return reply_origin;
	}
	public void setReply_origin(int reply_origin) {
		this.reply_origin = reply_origin;
	}
	public int getReply_writer() {
		return reply_writer;
	}
	public void setReply_writer(int reply_writer) {
		this.reply_writer = reply_writer;
	}
	public String getReply_context() {
		return reply_context;
	}
	public void setReply_context(String reply_context) {
		this.reply_context = reply_context;
	}
	public Date getReply_date() {
		return reply_date;
	}
	public void setReply_date(Date reply_date) {
		this.reply_date = reply_date;
	}

}
