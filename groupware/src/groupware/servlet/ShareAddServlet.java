package groupware.servlet;

import java.io.IOException;
import java.util.StringTokenizer;

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
			int emp_no = (int) req.getSession().getAttribute("check");
			
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
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			req.setCharacterEncoding("utf-8");
			
			int emp_no = (int) req.getSession().getAttribute("check");
			
			Share_schDao shareDao = new Share_schDao();
			
			String target_no = req.getParameter("target_no");
			StringTokenizer st = new StringTokenizer(target_no, ",");
			while(st.hasMoreTokens()) {
				int parsed = Integer.parseInt(st.nextToken());
				if(!shareDao.find(emp_no, parsed)) {
					shareDao.insert(emp_no, parsed);
				}
			}
			
			resp.sendRedirect("sch_manage.jsp");
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
