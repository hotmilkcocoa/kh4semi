package groupware.beans;

public class ContactListDto {
	private int cont_no;
	private String cont_name;
	private String cont_corp;
	private String cont_phone;
	private String cont_email;
	private String cont_memo;
	private int emp_no;
	
	public ContactListDto() {
		super();
	}
	public int getCont_no() {
		return cont_no;
	}
	public void setCont_no(int cont_no) {
		this.cont_no = cont_no;
	}
	public String getCont_name() {
		return cont_name;
	}
	public void setCont_name(String cont_name) {
		this.cont_name = cont_name;
	}
	public String getCont_corp() {
		if(this.cont_corp == null) 
			return "";
		else
			return this.cont_corp;
	}
	public void setCont_corp(String cont_corp) {
		this.cont_corp = cont_corp;
	}
	public String getCont_phone() {
		return cont_phone;
	}
	public void setCont_phone(String cont_phone) {
		this.cont_phone = cont_phone;
	}
	public String getCont_email() {
		if(this.cont_email == null) 
			return "";
		else
			return this.cont_email;
	}
	public void setCont_email(String cont_email) {
		this.cont_email = cont_email;
	}
	public String getCont_memo() {
		if(this.cont_memo == null) 
			return "";
		else
			return this.cont_memo;
	}
	public void setCont_memo(String cont_memo) {
		this.cont_memo = cont_memo;
	}
	public int getEmp_no() {
		return emp_no;
	}
	public void setEmp_no(int emp_no) {
		this.emp_no = emp_no;
	}
	
}
