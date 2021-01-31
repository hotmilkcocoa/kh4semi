package groupware.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import groupware.beans.BoardPaymentDao;
@WebServlet(urlPatterns = "/board/payment_btn_submit.do")
public class BoardBtnSubmitServlet extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			req.setCharacterEncoding("UTF-8");
			
			int payment_no = Integer.parseInt(req.getParameter("payment_no"));
			BoardPaymentDao dao = new BoardPaymentDao();
			dao.submit(payment_no);
			
			resp.sendRedirect("payment_list.jsp");
			
		}catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
