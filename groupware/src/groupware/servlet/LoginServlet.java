package groupware.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import groupware.beans.LoginDao;
import groupware.beans.LoginDto;

@WebServlet(urlPatterns = "/login.do")
public class LoginServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {			
			req.setCharacterEncoding("UTF-8");
			LoginDto dto = new LoginDto();
			dto.setEmp_id(req.getParameter("emp_id"));
			dto.setEmp_pw(req.getParameter("emp_pw"));
			

			LoginDao dao = new LoginDao();
			LoginDto result = dao.find(dto.getEmp_id());

			boolean login;
			if(result != null) {
//				login = dto.getMember_pw().equals(result.getEmp_pw());
				if(dto.getEmp_pw().equals(result.getEmp_pw())) {
					login = true;
				}
				else {
					login = false;
				}
			}
			else {
				login = false;
			}
			if(login) {
				resp.sendRedirect("../main.jsp");//상대경로
//				resp.sendRedirect(req.getContextPath()+"/main.jsp");//절대경로
			}
			else {
				resp.sendRedirect("main.jsp?error");//상대경로
//				resp.sendRedirect(req.getContextPath()+"/index.jsp");//절대경로
			}
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}