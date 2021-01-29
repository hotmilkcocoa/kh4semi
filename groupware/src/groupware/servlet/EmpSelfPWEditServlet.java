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

@WebServlet(urlPatterns = "/employee/pw.do")
public class EmpSelfPWEditServlet extends HttpServlet{

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			//준비 
			req.setCharacterEncoding("UTF-8");
			int emp_no = (int)req.getSession().getAttribute("check");
			String emp_pw = req.getParameter("emp_pw");
			String change_pw = req.getParameter("change_pw");
			
			//처리
			EmployeeDao employeeDao = new EmployeeDao();
			boolean result = employeeDao.editPW(emp_no, emp_pw, change_pw);
			
			//출력
			if(result) {
				resp.sendRedirect(req.getContextPath()+"/employee/setting.jsp");
			}
			else {
				resp.sendRedirect("pw_edit.jsp?error");
			}
			
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
			
	}
}
