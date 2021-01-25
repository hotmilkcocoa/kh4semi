package groupware.servlet;

import java.io.IOException;
import java.sql.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import groupware.beans.EmployeeDao;
import groupware.beans.EmployeeDto;

@WebServlet(urlPatterns = "/admin/emp_edit.do")
public class EmployeeEditServlet extends HttpServlet{

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			//준비 : 데이터 (이메일, 전화번호, 주소, 부서, 직급, 급여, 사수, 권한, 상태, 기타사항)
			req.setCharacterEncoding("UTF-8");
			EmployeeDto employeeDto = new EmployeeDto();
			employeeDto.setEmp_email(req.getParameter("emp_email"));
			employeeDto.setEmp_phone(req.getParameter("emp_phone"));
			employeeDto.setEmp_addr(req.getParameter("emp_addr"));
			employeeDto.setEmp_dep(req.getParameter("emp_dep"));
			employeeDto.setEmp_title(req.getParameter("emp_title"));
			employeeDto.setEmp_salary(Integer.parseInt(req.getParameter("emp_salary")));
			employeeDto.setEmp_auth(req.getParameter("emp_auth"));
			employeeDto.setEmp_state(req.getParameter("emp_state"));
			employeeDto.setEmp_etc(req.getParameter("emp_etc"));
			employeeDto.setEmp_no(Integer.parseInt(req.getParameter("emp_no")));
			employeeDto.setEmp_hiredate(Date.valueOf(req.getParameter("emp_hiredate")));
			
			//처리
			EmployeeDao employeeDao = new EmployeeDao();
			//boolean result = employeeDao.update(employeeDto);
			employeeDao.update(employeeDto);
			
			//출력
//			if(result) {
//				resp.sendRedirect(req.getContextPath()+"/admin/emp_detail.jsp?emp_no="+employeeDto.getEmp_no());				
//			}
//			else {
//				resp.sendRedirect(req.getContextPath()+"/admin/employee.jsp");
//			}
			resp.sendRedirect(req.getContextPath()+"/admin/emp_detail.jsp?emp_no="+employeeDto.getEmp_no());
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
		
		
		
	}
}
