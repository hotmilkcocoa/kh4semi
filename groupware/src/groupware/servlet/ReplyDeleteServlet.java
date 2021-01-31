package groupware.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import groupware.beans.BoardReplyDao;
@WebServlet(urlPatterns = "/board/reply_delete.do")
public class ReplyDeleteServlet extends HttpServlet{
@Override
protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	try{
		int reply_no=Integer.parseInt(req.getParameter("reply_no"));
		int free_no = Integer.parseInt(req.getParameter("free_no"));
		
		BoardReplyDao replyDao= new BoardReplyDao();
		replyDao.delete(reply_no);
		
		resp.sendRedirect("free_detail.jsp?free_no="+free_no);
		
	}catch(Exception e) {
		e.printStackTrace();
		resp.sendError(500);
	}
	}
}
