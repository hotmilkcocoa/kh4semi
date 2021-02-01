package groupware.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import groupware.beans.BoardReplyDao;
import groupware.beans.BoardReplyDto;
@WebServlet(urlPatterns = "/board/reply_edit.do")
public class BoardReplyEditServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			req.setCharacterEncoding("UTF-8");
			
			BoardReplyDto replyDto = new BoardReplyDto();
			replyDto.setReply_no(Integer.parseInt(req.getParameter("reply_no")));
			replyDto.setReply_origin(Integer.parseInt(req.getParameter("reply_origin")));
			replyDto.setReply_context(req.getParameter("reply_context"));
			
//			계산 : 수정
			BoardReplyDao replyDao = new BoardReplyDao();
			replyDao.update(replyDto);
			
//			출력 : detail.jsp로 복귀
			resp.sendRedirect("free_detail.jsp?free_no="+replyDto.getReply_origin());
		}catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
