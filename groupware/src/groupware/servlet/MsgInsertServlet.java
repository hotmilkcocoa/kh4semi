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
			
			int message_sender = (int)req.getSession().getAttribute("check"); //보내는사람
			
			MessageDto msgDto = new MessageDto();
			MessageDao msgDao = new MessageDao();
			String[] msg_receiver = req.getParameterValues("msg_receiver");//받는사람들
			System.out.println(req.getParameter("msg_receiver"));
			System.out.println(req.getParameter("msg_title"));
			String message_title = req.getParameter("msg_title"); //제목
			String message_content = req.getParameter("msg_content"); //타이틀
			
			int[] message_receiver = new int[msg_receiver.length];
			for(int i = 0; i < message_receiver.length; i ++) {
				int message_no = msgDao.getSequence();
				message_receiver[i] = Integer.parseInt(msg_receiver[i]);
				msgDto.setMessage_no(message_no);
				msgDto.setMessage_sender(message_sender);
				msgDto.setMessage_receiver(message_receiver[i]); //받는사람들
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
