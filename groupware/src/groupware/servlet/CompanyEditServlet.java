package groupware.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import groupware.beans.CompanyDao;
import groupware.beans.CompanyDto;

@WebServlet(urlPatterns = "/admin/group_edit.do")
public class CompanyEditServlet extends HttpServlet{

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			//준비
			req.setCharacterEncoding("UTF-8");
			CompanyDto companyDto = new CompanyDto();
			companyDto.setCom_no(Integer.parseInt(req.getParameter("com_no")));
			companyDto.setCom_name(req.getParameter("com_name"));
			companyDto.setCom_type(req.getParameter("com_type"));
			companyDto.setCom_ceo(req.getParameter("com_ceo"));
			companyDto.setCom_call(req.getParameter("com_call"));
			companyDto.setCom_corpnum(req.getParameter("com_corpnum"));
			companyDto.setCom_registnum(req.getParameter("com_registnum"));
			companyDto.setCom_condition(req.getParameter("com_condition"));
			companyDto.setCom_event(req.getParameter("com_event"));
			companyDto.setCom_emp(req.getParameter("com_emp"));
			companyDto.setCom_phone(req.getParameter("com_phone"));
			companyDto.setCom_addr(req.getParameter("com_addr"));
			
			//처리
			CompanyDao companyDao = new CompanyDao();
			companyDao.update(companyDto);
			
			//출력
			resp.sendRedirect(req.getContextPath()+"/admin/group.jsp");
			
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
