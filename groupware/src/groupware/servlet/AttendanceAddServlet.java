package groupware.servlet;

import java.io.IOException;
import java.sql.Timestamp;
import java.time.LocalDateTime;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import groupware.beans.AttendanceDao;

@WebServlet(urlPatterns = "/attendance/att_add.do")
public class AttendanceAddServlet extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			req.setCharacterEncoding("utf-8");
			
			int att_no;
//			int emp_no = (int) req.getSession().getAttribute("check");
			int emp_no = 3;
			
			AttendanceDao attendanceDao = new AttendanceDao();
			if(req.getParameter("arrive") != null) {
				att_no = attendanceDao.getSequence();
				attendanceDao.arrive(att_no, emp_no);
			} else {
				att_no = Integer.parseInt(req.getParameter("att_no"));
				attendanceDao.leave(att_no);
			}
			
			resp.sendRedirect(req.getContextPath());
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
