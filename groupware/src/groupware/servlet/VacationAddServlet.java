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
			
//			int emp_no = (int) req.getSession().getAttribute("check");
			int emp_no = 3;
			
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
			
			//받은 기간으로 사용될 연차를 구하고 잔여연차보다 크면 돌아감
			double use = 0;
			if(vacationDto.getVac_category().equals("반차")) {
				use = 0.5;
			} else {
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
			if(use > remain) {
				resp.sendRedirect("vac_add.jsp?error");
			} else {
				VacationDao vacationDao = new VacationDao();
				VacationApprovalDao vacAppDao = new VacationApprovalDao();
				if(req.getParameter("edit") == null) {//수정이 아닐경우 일반 등록, 승인 테이블 생성
					vacationDto.setVac_no(vacationDao.getSequence());
					vacationDao.insert(vacationDto);
					
					vacAppDao.insert(vacationDto.getVac_no(), vacationDto.getVac_target_no());
				} else {//수정일 경우 업데이트
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
