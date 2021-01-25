package groupware.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import groupware.beans.*;

@WebServlet(urlPatterns = "/contactList/add.do")
public class ContInsertServlet extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			req.setCharacterEncoding("UTF-8");
			int check = 1;
			System.out.println(req.getParameter("cont_email"));
			ContactListDto contDto = new ContactListDto();
			contDto.setCont_name(req.getParameter("cont_name"));
			contDto.setCont_corp(req.getParameter("cont_corp"));
			contDto.setCont_phone(req.getParameter("cont_phone"));
			contDto.setCont_email(req.getParameter("cont_email"));
			contDto.setCont_memo(req.getParameter("cont_memo"));
			//contDto.setEmp_no((int) req.getSession().getAttribute("check"));
			contDto.setEmp_no(check);
			
			ContactListDao contDao = new ContactListDao();
			contDao.Insert(contDto);
			
			resp.sendRedirect(req.getContextPath() + "/contactList/contList.jsp");
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
	

}
