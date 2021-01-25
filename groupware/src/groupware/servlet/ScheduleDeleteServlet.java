package groupware.servlet;

import java.io.IOException;
import java.sql.Timestamp;
import java.time.LocalDate;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import groupware.beans.ScheduleDao;

@WebServlet(urlPatterns = "/calendar/sch_del.do")
public class ScheduleDeleteServlet extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			req.setCharacterEncoding("utf-8");
			
//			int emp_no = (int) req.getSession().getAttribute("check");
			int emp_no = 3;
			
			ScheduleDao scheduleDao = new ScheduleDao();
			
			String del_from = req.getParameter("del_from");
			if(del_from == null) {
				scheduleDao.delete(emp_no);
			} else {
				scheduleDao.delete(emp_no, Timestamp.valueOf(LocalDate.parse(del_from).atStartOfDay()));
			}
			
			resp.sendRedirect("sch_manage.jsp");
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
