package groupware.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import groupware.beans.BoardFreeDao;

@WebServlet(urlPatterns = "/board/free_delete.do")
public class BoardFreeDeleteServlet extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
		int free_no = Integer.parseInt(req.getParameter("free_no"));
		
		BoardFreeDao freeDao = new BoardFreeDao();
		freeDao.delete(free_no);
		
		resp.sendRedirect(req.getContextPath()+"/board/free_list.jsp");
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
