package groupware.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import groupware.beans.EmpFavoriteDao;

@WebServlet(urlPatterns = "/contactList/favDelete.do")
public class FavDeleteServlet extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			req.setCharacterEncoding("UTF-8");
			
			int emp_no = 1;
			//int emp_no = (int) req.getSession().getAttribute("check");
			int fav_emp_no = Integer.parseInt(req.getParameter("fav_emp_no"));

			EmpFavoriteDao emp_favDao = new EmpFavoriteDao();
			emp_favDao.delete(emp_no, fav_emp_no);
			
			resp.sendRedirect(req.getHeader("referer"));
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
