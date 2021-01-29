package groupware.servlet;

import java.io.IOException;
import java.sql.Date;
import java.time.LocalDate;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import groupware.beans.AnnualDao;
import groupware.beans.AnnualDto;
import groupware.beans.VacationApprovalDao;
import groupware.beans.VacationDao;
import groupware.beans.VacationDto;

@WebServlet(urlPatterns = "/vacation/vac_add.do")
public class VacationAddServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			req.setCharacterEncoding("utf-8");
			
			int emp_no = (int) req.getSession().getAttribute("check");
			
			//휴가 정보 등록
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
			
			//사용될 연차기간 산출
			double use = 0;//기타는 0
			if(vacationDto.getVac_category().equals("반차")) {//반차는 0.5
				use = 0.5;
			} else if(vacationDto.getVac_category().equals("연차")) {//연차는 주말 제외 산출
				LocalDate start = LocalDate.parse(vacationDto.getVac_start().toString());
				LocalDate end = LocalDate.parse(vacationDto.getVac_end().toString());				
				for(; !start.equals(end.plusDays(1)); start=start.plusDays(1)) {
					if(start.getDayOfWeek().getValue()!=7 && start.getDayOfWeek().getValue()!=6) {
						use++;
					}
				}				
			}
			
			AnnualDao annualDao = new AnnualDao();
			AnnualDto annualDto = annualDao.find(vacationDto.getVac_target_no());
			double remain = annualDto.getAnn_occurred() - annualDto.getAnn_used();
			
			if(use > remain) {//잔여연차보다 사용될 연차가 많으면 에러로 리턴
				resp.sendRedirect("vac_add.jsp?error");
			} else {
				VacationDao vacationDao = new VacationDao();
				VacationApprovalDao vacAppDao = new VacationApprovalDao();
				
				if(req.getParameter("edit") == null) {//등록
					vacationDto.setVac_no(vacationDao.getSequence());
					vacationDao.insert(vacationDto);
					
					vacAppDao.insert(vacationDto.getVac_no(), vacationDto.getVac_target_no());
				} else {//수정
					vacationDto.setVac_no(Integer.parseInt(req.getParameter("vac_no")));
					vacationDao.update(vacationDto);
				}
				
				resp.sendRedirect("vac_status.jsp");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}