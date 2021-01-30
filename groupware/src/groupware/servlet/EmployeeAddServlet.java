package groupware.servlet;

import java.io.IOException;
import java.sql.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import groupware.beans.AnnualDao;
import groupware.beans.EmployeeDao;
import groupware.beans.EmployeeDto;

@WebServlet(urlPatterns = "/admin/emp_add.do")
public class EmployeeAddServlet extends HttpServlet{

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			//준비
			req.setCharacterEncoding("UTF-8");
			EmployeeDto employeeDto = new EmployeeDto();
			employeeDto.setEmp_name(req.getParameter("emp_name"));
			employeeDto.setEmp_id(req.getParameter("emp_id"));
			employeeDto.setEmp_pw(req.getParameter("emp_pw"));
			employeeDto.setEmp_email(req.getParameter("emp_email"));
			employeeDto.setEmp_phone(req.getParameter("emp_phone"));
			employeeDto.setEmp_birth(Date.valueOf(req.getParameter("emp_birth")));
			employeeDto.setEmp_addr(req.getParameter("emp_addr"));
			employeeDto.setEmp_dep(req.getParameter("emp_dep"));
			employeeDto.setEmp_title(req.getParameter("emp_title"));
			employeeDto.setEmp_salary(Integer.parseInt(req.getParameter("emp_salary")));
			employeeDto.setEmp_auth(req.getParameter("emp_auth"));
			employeeDto.setEmp_state(req.getParameter("emp_state"));
			employeeDto.setEmp_etc(req.getParameter("emp_etc"));
					
			//처리
			EmployeeDao employeeDao = new EmployeeDao();
			int emp_no = employeeDao.getSequence();
			employeeDto.setEmp_no(emp_no);
			employeeDao.empAdd(employeeDto);
			
			AnnualDao annDao = new AnnualDao();
			annDao.insert(emp_no);
			
			//출력
			resp.sendRedirect(req.getContextPath()+"/admin/emp_detail.jsp?emp_no="+emp_no);
			
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
		
	}
}