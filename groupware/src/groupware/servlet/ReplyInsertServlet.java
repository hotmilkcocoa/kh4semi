package groupware.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import groupware.beans.BoardFreeDto;
import groupware.beans.BoardReplyDao;
import groupware.beans.BoardReplyDto;
import groupware.beans.EmployeeDao;
@WebServlet(urlPatterns = "/board/reply_insert.do")
public class ReplyInsertServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			req.setCharacterEncoding("UTF-8");
			BoardReplyDto replyDto = new BoardReplyDto();
			replyDto.setReply_context(req.getParameter("reply_context"));
			replyDto.setReply_origin(Integer.parseInt(req.getParameter("reply_origin")));
			
			/*
			 * int emp_no = 1; EmployeeDao employeeDao = new EmployeeDao(); EmployeeDao
			 * EmployeeDao = employeeDao.find(emp_no);
			 */
			 
			replyDto.setReply_writer(1);
			
//			계산 : 댓글 테이블에 등록
			BoardReplyDao replyDao = new BoardReplyDao();
			replyDao.insert(replyDto);
			 
//			출력 : 상세보기 글로 다시 돌아가도록 처리
			resp.sendRedirect("free_detail.jsp?free_no="+replyDto.getReply_origin());
		}catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
