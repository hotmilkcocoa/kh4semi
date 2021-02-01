package groupware.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import groupware.beans.BoardFreeDao;
import groupware.beans.BoardFreeDto;
@WebServlet(urlPatterns = "/board/free_edit.do")
public class BoardFreeEditServlet extends HttpServlet{
@Override
protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	try {
		req.setCharacterEncoding("UTF-8");
		BoardFreeDto freeDto = new BoardFreeDto();
		freeDto.setFree_no(Integer.parseInt(req.getParameter("free_no")));
		freeDto.setFree_header(req.getParameter("free_header"));
		freeDto.setFree_title(req.getParameter("free_title"));
		freeDto.setFree_context(req.getParameter("free_context"));
		
		BoardFreeDao boardfreeDao = new BoardFreeDao();
		boardfreeDao.update(freeDto);
		
		resp.sendRedirect(req.getContextPath()+"/board/free_detail.jsp?free_no="+freeDto.getFree_no());
		
	}catch(Exception e) {
		e.printStackTrace();
		resp.sendError(500);
	}
	}
}
