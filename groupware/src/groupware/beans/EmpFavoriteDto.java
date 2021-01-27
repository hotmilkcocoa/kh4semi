package groupware.beans;

public class EmpFavoriteDto {
	private int emp_no;
	private String emp_name;
	private String emp_title;
	private String emp_dep;
	public String getEmp_dep() {
		return emp_dep;
	}
	public void setEmp_dep(String emp_dep) {
		this.emp_dep = emp_dep;
	}
	private String emp_phone;
	private String emp_email;
	private int fav_emp_no;
	public EmpFavoriteDto() {
		super();
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
	public String getEmp_phone() {
		return emp_phone;
	}
	public void setEmp_phone(String emp_phone) {
		this.emp_phone = emp_phone;
	}
	public String getEmp_email() {
		return emp_email;
	}
	public void setEmp_email(String emp_email) {
		this.emp_email = emp_email;
	}
	public int getFav_emp_no() {
		return fav_emp_no;
	}
	public void setFav_emp_no(int fav_emp_no) {
		this.fav_emp_no = fav_emp_no;
	}
	
	
}
