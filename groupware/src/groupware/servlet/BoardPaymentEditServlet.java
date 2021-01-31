package groupware.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import groupware.beans.BoardPaymentDao;
import groupware.beans.BoardPaymentDto;
@WebServlet(urlPatterns = "/board/payment_edit.do")
public class BoardPaymentEditServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try{req.setCharacterEncoding("UTF-8");
		
		BoardPaymentDto paymentdto = new BoardPaymentDto();
		paymentdto.setPayment_no(Integer.parseInt(req.getParameter("payment_no")));
		paymentdto.setPayment_heater(req.getParameter("payment_heater"));
		paymentdto.setPayment_title(req.getParameter("payment_title"));
		paymentdto.setPayment_context(req.getParameter("payment_context"));
		paymentdto.setPayment_recive(Integer.parseInt(req.getParameter("payment_recive")));
		
		BoardPaymentDao paymentdao = new BoardPaymentDao();
		paymentdao.update(paymentdto);		
		
		resp.sendRedirect(req.getContextPath()+"/board/payment_detail.jsp?payment_no="+paymentdto.getPayment_no());
		
		}catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
