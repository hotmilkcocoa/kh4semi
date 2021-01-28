package groupware.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import groupware.beans.EmployeeDto;
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
//			System.out.println(dto.getEmp_id());
//			System.out.println(dto.getEmp_pw());

			LoginDao dao = new LoginDao();
			boolean result = dao.login(dto);
//			System.out.println(result);

			if(result) {
				EmployeeDto e = dao.login(dto.getEmp_id());
				req.getSession().setAttribute("check",e.getEmp_no());
				req.getSession().setAttribute("auth", e.getEmp_auth());
				resp.sendRedirect(req.getContextPath()+"/main.jsp");//절대경로
			}
			else {
				resp.sendRedirect(req.getContextPath()+"/login_fail.jsp");//절대경로
			}
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}