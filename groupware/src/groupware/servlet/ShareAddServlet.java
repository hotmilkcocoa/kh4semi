package groupware.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import groupware.beans.EmployeeDao;
import groupware.beans.EmployeeDto;
import groupware.beans.Share_schDao;

@WebServlet(urlPatterns = "/calendar/share_add.do")
public class ShareAddServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			req.setCharacterEncoding("utf-8");
//			int emp_no = req.getSession().getAttribute("check");
			int emp_no = 3;
			
			EmployeeDao empDao = new EmployeeDao();
			EmployeeDto empDto = empDao.findByEmail(req.getParameter("emp_email"));
			
			if(empDto == null) {
				resp.sendRedirect("sch_manage.jsp?error");
			} else {
				Share_schDao shareDao = new Share_schDao();
				shareDao.insert(emp_no, empDto.getEmp_no());
				
				resp.sendRedirect("sch_manage.jsp");
			}
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
