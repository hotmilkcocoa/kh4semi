package groupware.beans;

public class VacationApprovalDto {
	private int vac_no;
	private int dep_head_no;
	private String dep_head_app;
	private int hr_app_no;
	private String hr_app;
	
	public VacationApprovalDto() {
		// TODO Auto-generated constructor stub
	}

	public int getVac_no() {
		return vac_no;
	}

	public void setVac_no(int vac_no) {
		this.vac_no = vac_no;
	}

	public String getDep_head_app() {
		return dep_head_app;
	}

	public void setDep_head_app(String dep_head_app) {
		this.dep_head_app = dep_head_app;
	}

	public String getHr_app() {
		return hr_app;
	}

	public void setHr_app(String hr_app) {
		this.hr_app = hr_app;
	}

	public int getDep_head_no() {
		return dep_head_no;
	}

	public void setDep_head_no(int dep_head_no) {
		this.dep_head_no = dep_head_no;
	}

	public int getHr_app_no() {
		return hr_app_no;
	}

	public void setHr_app_no(int hr_app_no) {
		this.hr_app_no = hr_app_no;
	}
	
	
}
