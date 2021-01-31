package groupware.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import groupware.beans.Share_schDao;
import groupware.beans.Share_schDto;

@WebServlet(urlPatterns = "/calendar/share_update.do")
public class ShareUpdateServlet extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			req.setCharacterEncoding("utf-8");
			
			int share_no = Integer.parseInt(req.getParameter("share_no"));
			
			Share_schDao shareDao = new Share_schDao();
			Share_schDto shareDto = shareDao.find(share_no);
			
			if(shareDto.getChecked().equals("true")) {
				shareDao.update(share_no, "false");
			} else {
				shareDao.update(share_no, "true");
			}
			
			resp.sendRedirect("sch_manage.jsp");
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			req.setCharacterEncoding("utf-8");
			
			int emp_no = (int) req.getSession().getAttribute("check");
			String[] shareArr = req.getParameterValues("share_no");
			
			Share_schDao shareDao = new Share_schDao();
			shareDao.offAll(emp_no);
			
			if(shareArr != null) {
				shareDao.updateSelected(emp_no, shareArr);
			}
			
			resp.sendRedirect("share_calendar.jsp");
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
