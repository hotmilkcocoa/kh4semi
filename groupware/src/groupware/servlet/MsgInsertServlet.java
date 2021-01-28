package groupware.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import groupware.beans.MessageDao;
import groupware.beans.MessageDto;

@WebServlet(urlPatterns = "/message/insert.do")
public class MsgInsertServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			req.setCharacterEncoding("UTF-8");
			
			//int message_receiver = (int)req.getSession().getAttribute("check");
			
			MessageDto msgDto = new MessageDto();
			MessageDao msgDao = new MessageDao();
			int message_receiver = 1; //보내는 사람
			String emp_no = req.getParameter("emp_no");//받는사람들
			String message_title = req.getParameter("msg_title");
			String message_content = req.getParameter("msg_content");
			int message_no;
			
			String[] sender = emp_no.split(",");
			int[] message_sender = new int[sender.length];
			for(int i = 0; i < message_sender.length; i ++) {
				message_sender[i] = Integer.parseInt(sender[i]);
				
				message_no = msgDao.getSequence();
				msgDto.setMessage_no(message_no);
				msgDto.setMessage_receiver(message_receiver);
				msgDto.setMessage_sender(message_sender[i]); //받는사람들
				msgDto.setMessage_title(message_title);
				msgDto.setMessage_content(message_content);
				
				msgDao.insert(msgDto);
			}
			
			resp.sendRedirect(req.getContextPath()+"/message/inbox.jsp");
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
