package groupware.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import groupware.beans.MessageDao;

@WebServlet(urlPatterns = "/message/sentbox_delete.do")
public class MsgSentboxDeleteServlet extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			//보낸쪽지함에서 온 삭제요청
			String no = req.getParameter("msg_no");
			String[] message_no = no.split(",");
			MessageDao msgDao = new MessageDao();
			int[] msg_no = new int[message_no.length];
			for(int i = 0; i < msg_no.length; i++) {
				msg_no[i] = Integer.parseInt(message_no[i]);
				msgDao.deleteCkSentbox(msg_no[i]);
			}
			
			resp.sendRedirect(req.getContextPath() + "/message/sentbox.jsp");
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
