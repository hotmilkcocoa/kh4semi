package groupware.servlet;

import java.io.IOException;
import java.util.Arrays;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import groupware.beans.ContactListDao;

@WebServlet(urlPatterns = "/contactList/delete.do")
public class ContDeleteServlet extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		try {
			req.setCharacterEncoding("UTF-8");
			ContactListDao contDao = new ContactListDao();
			
			String check = req.getParameter("cont_no");
			
			String[] checks = check.split(",");
			int[] checked = new int[checks.length];
			for(int i = 0; i < checks.length; i ++) {
				checked[i] = Integer.parseInt(checks[i]);
				contDao.delete(checked[i]);
			}
			
			resp.sendRedirect(req.getContextPath() + "/contactList/contList.jsp");
		}
	
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}

}
