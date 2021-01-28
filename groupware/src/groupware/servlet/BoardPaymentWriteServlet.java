package groupware.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import groupware.beans.BoardPaymentDao;
import groupware.beans.BoardPaymentDto;
import groupware.beans.EmployeeDao;
import groupware.beans.EmployeeDto;
@WebServlet(urlPatterns = "/board/payment_write.do")
public class BoardPaymentWriteServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	try {
		req.setCharacterEncoding("UTF-8");
		
		BoardPaymentDto paymentDto = new BoardPaymentDto();
		paymentDto.setPayment_header(req.getParameter("payment_header"));
		paymentDto.setPayment_title(req.getParameter("payment_title"));
		paymentDto.setPayment_context(req.getParameter("payment_context"));
		paymentDto.setPayment_recive(req.getParameter("payment_recive"));
		
		int emp_no=1;
		EmployeeDao employeeDao = new EmployeeDao();
		EmployeeDto employeeDto = employeeDao.find(emp_no);
		
		paymentDto.setPayment_writer(emp_no);
		
		BoardPaymentDao paymentDao = new BoardPaymentDao();
		int payment_no = paymentDao.getSequence();
		paymentDto.setPayment_no(payment_no);
		paymentDto.setBoard_dep(employeeDto.getEmp_dep());
		paymentDao.writeWithPrimaryKey(paymentDto);	
		
		resp.sendRedirect("payment_list.jsp?payment_no="+payment_no);
		
	}catch(Exception e) {
		e.printStackTrace();
		resp.sendError(500);
	}
	}
}
