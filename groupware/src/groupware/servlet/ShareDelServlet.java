package groupware.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import groupware.beans.Share_schDao;

@WebServlet(urlPatterns = "/calendar/share_del.do")
public class ShareDelServlet extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			Share_schDao shareDao = new Share_schDao();
			shareDao.delete(Integer.parseInt(req.getParameter("share_no")));
			
			resp.sendRedirect("sch_manage.jsp");
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
