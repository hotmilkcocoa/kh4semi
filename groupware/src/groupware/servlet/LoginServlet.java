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
			boolean login = dao.login(dto);
			

			if(login) {

				LoginDto m = dao.find(dto.getEmp_id());//아이디로 회원정보 다 불러오기
				req.getSession().setAttribute("check", m.getEmp_no());				
				resp.sendRedirect("../main.jsp");//상대경로
//				resp.sendRedirect(req.getContextPath()+"/index.jsp");//절대경로
			}
			else { 
				resp.sendRedirect("main.jsp?error");//상대경로
//				resp.sendRedirect(req.getContextPath()+"/member/login.jsp");//절대경로
			}
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}