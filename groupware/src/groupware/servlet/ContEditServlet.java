package groupware.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import groupware.beans.ContactListDao;
import groupware.beans.ContactListDto;

@WebServlet(urlPatterns = "/contactList/edit.do")
public class ContEditServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			req.setCharacterEncoding("UTF-8");

			ContactListDto contDto = new ContactListDto();
			contDto.setCont_no(Integer.parseInt(req.getParameter("cont_no")));
			contDto.setCont_name(req.getParameter("cont_name"));
			contDto.setCont_corp(req.getParameter("cont_corp"));
			contDto.setCont_phone(req.getParameter("cont_phone"));
			contDto.setCont_email(req.getParameter("cont_email"));
			contDto.setCont_memo(req.getParameter("cont_memo"));
			contDto.setEmp_no((int)req.getSession().getAttribute("check"));
			
			ContactListDao contDao = new ContactListDao();
			contDao.update(contDto);
			
			resp.sendRedirect(req.getContextPath() + "/contactList/contList.jsp");
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}

}
