package groupware.beans;

import java.sql.Date;

public class MessageDto {
	private int rownum;
	private int emp_no;
	private String emp_name;
	private String emp_title;
	private int message_no;
	private String message_title;
	private String message_content;
	private Date message_time;
	private int message_sender;
	private int message_receiver;
	private String read_check;
	private String del_sender;
	private String del_receiver;
	public MessageDto() {
		super();
	}
	
	
	public int getRownum() {
		return rownum;
	}


	public void setRownum(int rownum) {
		this.rownum = rownum;
	}


	public int getEmp_no() {
		return emp_no;
	}


	public void setEmp_no(int emp_no) {
		this.emp_no = emp_no;
	}


	public String getEmp_name() {
		return emp_name;
	}


	public void setEmp_name(String emp_name) {
		this.emp_name = emp_name;
	}


	public String getEmp_title() {
		return emp_title;
	}


	public void setEmp_title(String emp_title) {
		this.emp_title = emp_title;
	}


	public int getMessage_no() {
		return message_no;
	}
	public void setMessage_no(int message_no) {
		this.message_no = message_no;
	}
	public String getMessage_title() {
		return message_title;
	}
	public void setMessage_title(String message_title) {
		this.message_title = message_title;
	}
	public String getMessage_content() {
		return message_content;
	}
	public void setMessage_content(String message_content) {
		this.message_content = message_content;
	}
	public Date getMessage_time() {
		return message_time;
	}
	public void setMessage_time(Date message_time) {
		this.message_time = message_time;
	}
	public int getMessage_sender() {
		return message_sender;
	}
	public void setMessage_sender(int message_sender) {
		this.message_sender = message_sender;
	}
	public int getMessage_receiver() {
		return message_receiver;
	}
	public void setMessage_receiver(int message_receiver) {
		this.message_receiver = message_receiver;
	}
	public String getRead_check() {
		return read_check;
	}
	public void setRead_check(String read_check) {
		this.read_check = read_check;
	}
	public String getDel_sender() {
		return del_sender;
	}
	public void setDel_sender(String del_sender) {
		this.del_sender = del_sender;
	}
	public String getDel_receiver() {
		return del_receiver;
	}
	public void setDel_receiver(String del_receiver) {
		this.del_receiver = del_receiver;
	}
	
	
}
