package groupware.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import groupware.beans.BoardPaymentDao;
@WebServlet(urlPatterns = "/board/payment_delete.do")
public class BoardPaymentDeleteServlet extends HttpServlet{
@Override
protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	try {
		int payment_no = Integer.parseInt(req.getParameter("payment_no"));
		
		BoardPaymentDao paymentdao = new BoardPaymentDao();
		paymentdao.delete(payment_no);
		
		resp.sendRedirect(req.getContextPath()+"/board/payment_list.jsp");
	}catch(Exception e){
		e.printStackTrace();
		resp.sendError(500);
	}
}
}
