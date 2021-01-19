package groupware.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import groupware.beans.EmployeeDao;

@WebServlet(urlPatterns = "/admin/emp_delete.do")
public class EmployeeDeleteServlet extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			//준비
			int emp_no = Integer.parseInt(req.getParameter("emp_no"));
			
			//처리
			EmployeeDao employeeDao = new EmployeeDao();
			employeeDao.delete(emp_no);
			
			//출력
			resp.sendRedirect(req.getContextPath()+"/admin/employee.jsp");
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
