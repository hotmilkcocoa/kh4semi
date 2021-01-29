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
			
			int emp_no = (int) req.getSession().getAttribute("check");
			
			ScheduleDao scheduleDao = new ScheduleDao();
			
			String delDate = req.getParameter("delDate");
			
			String only = req.getParameter("only");
			if(delDate != null) {
				scheduleDao.delete(emp_no, Timestamp.valueOf(LocalDate.parse(delDate).atStartOfDay()));
				resp.getWriter().println("<script>window.history.back()</script>");
			} else if(only != null){
				int sch_no = Integer.parseInt(req.getParameter("sch_no"));
				scheduleDao.deleteOne(sch_no);
				String link = "calendar.jsp?calType={1}&date={2}".replace("{1}", req.getParameter("calType")).replace("{2}", req.getParameter("date"));
				resp.sendRedirect(link);
			} else {
				scheduleDao.delete(emp_no);
				resp.getWriter().println("<script>window.history.back()</script>");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
