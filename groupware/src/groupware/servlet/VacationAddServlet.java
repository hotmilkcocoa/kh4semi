package groupware.servlet;

import java.io.IOException;
import java.sql.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import groupware.beans.VacationApprovalDao;
import groupware.beans.VacationDao;
import groupware.beans.VacationDto;

@WebServlet(urlPatterns = "/vacation/vac_add.do")
public class VacationAddServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			req.setCharacterEncoding("utf-8");
			
//			int emp_no = (int) req.getSession().getAttribute("check");
			int emp_no = 3;
			
			VacationDto vacationDto = new VacationDto();
			vacationDto.setVac_category(req.getParameter("vac_category"));
			vacationDto.setVac_start(Date.valueOf(req.getParameter("vac_start")));
			vacationDto.setVac_end(Date.valueOf(req.getParameter("vac_end")));
			vacationDto.setVac_reason(req.getParameter("vac_reason"));
			vacationDto.setVac_comment(req.getParameter("vac_comment"));
			vacationDto.setVac_writer_no(emp_no);
			if(Boolean.parseBoolean(req.getParameter("vac_target"))) {
				vacationDto.setVac_target_no(emp_no);
			} else {
				vacationDto.setVac_target_no(Integer.parseInt(req.getParameter("othres_emp_no")));
			}
			
			VacationDao vacationDao = new VacationDao();
			
			VacationApprovalDao vacAppDao = new VacationApprovalDao();
			if(req.getParameter("edit") == null) {
				vacationDto.setVac_no(vacationDao.getSequence());
				vacationDao.insert(vacationDto);
				
				vacAppDao.insert(vacationDto.getVac_no(), vacationDto.getVac_target_no());
			} else {
				vacationDto.setVac_no(Integer.parseInt(req.getParameter("vac_no")));
				vacationDao.update(vacationDto);
			}
			
			resp.sendRedirect("vac_status.jsp");
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
