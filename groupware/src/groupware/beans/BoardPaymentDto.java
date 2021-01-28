package groupware.beans;

import java.sql.Date;

public class BoardPaymentDto {
	public int payment_no;
	public int payment_writer;
	public String payment_header;
	public String payment_title;
	public String payment_context;
	public Date payment_date;
	public int payment_recive;
	public String board_dep;
	public BoardPaymentDto() {
		super();
	}

	public int getPayment_no() {
		return payment_no;
	}

	public void setPayment_no(int payment_no) {
		this.payment_no = payment_no;
	}

	public int getPayment_writer() {
		return payment_writer;
	}

	public void setPayment_writer(int payment_writer) {
		this.payment_writer = payment_writer;
	}

	public String getPayment_header() {
		return payment_header;
	}

	public void setPayment_header(String payment_header) {
		this.payment_header = payment_header;
	}

	public String getPayment_title() {
		return payment_title;
	}

	public void setPayment_title(String payment_title) {
		this.payment_title = payment_title;
	}

	public String getPayment_context() {
		return payment_context;
	}

	public void setPayment_context(String payment_context) {
		this.payment_context = payment_context;
	}

	public Date getPayment_date() {
		return payment_date;
	}

	public void setPayment_date(Date payment_date) {
		this.payment_date = payment_date;
	}

	public int getPayment_recive() {
		return payment_recive;
	}

	public void setPayment_recive(int payment_recive) {
		this.payment_recive = payment_recive;
	}

	public String getBoard_dep() {
		return board_dep;
	}

	public void setBoard_dep(String board_dep) {
		this.board_dep = board_dep;
	}

	public String getPayment_header_string() {
		if(this.payment_header == null) 
			return "";
		else
			return this.payment_header;
	}
}



