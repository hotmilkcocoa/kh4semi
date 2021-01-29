package groupware.servlet;

import java.io.IOException;
import java.time.LocalDate;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import groupware.beans.AnnualDao;
import groupware.beans.AnnualDto;
import groupware.beans.EmployeeDao;
import groupware.beans.EmployeeDto;
import groupware.beans.LeaveWorkDao;
import groupware.beans.VacationApprovalDao;
import groupware.beans.VacationDao;
import groupware.beans.VacationDto;

@WebServlet(urlPatterns = "/vacation/vac_sign.do")
public class VacationSignServlet extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			req.setCharacterEncoding("utf-8");
			
			int vac_no = Integer.parseInt(req.getParameter("vac_no"));
			String approver = req.getParameter("approver");
			
			VacationDao vacationDao = new VacationDao();
			VacationApprovalDao vacationApprovalDao = new VacationApprovalDao();
			
			String addr = "";
			//개인이 휴가신청 취소
			if(req.getParameter("cancel")!=null) {
				vacationDao.cancel(vac_no);		
				vacationApprovalDao.cancel(vac_no);
				addr = "vac_status.jsp";
			//상급자가 승인 or 반려일 때
			} else {
				//반려일 때
				addr = "vac_app.jsp";
				String sign;
				if(req.getParameter("reject")!=null) {
					sign = "반려";
					//부서장
					if(approver.equals("dephead")) {
						vacationApprovalDao.signForDephead(vac_no, sign);
					//인사 팀장
					} else {
						if(vacationApprovalDao.find(vac_no).getDep_head_app().equals("대기")) {
							vacationApprovalDao.signForDephead(vac_no, sign);
						}
						vacationApprovalDao.rejectForHrhead(vac_no);
					}
					vacationDao.reject(vac_no);
				//승인일 때
				} else {
					sign = "승인";
					//부서장
					if(approver.equals("dephead")) {
						vacationApprovalDao.signForDephead(vac_no, sign);
						vacationDao.process(vac_no);
					//인사 팀장
					} else {
						//최종 승인일 때 연차 소모
						VacationDto vacationDto = vacationDao.find(vac_no);
						AnnualDao annualDao = new AnnualDao();
						
						double use = 0;
						int daycount = 0;
						
						if(vacationDto.getVac_category().equals("반차")) {
							use = 0.5;
						} else if(vacationDto.getVac_category().equals("연차")) {
							LocalDate start = LocalDate.parse(vacationDto.getVac_start().toString());
							LocalDate end = LocalDate.parse(vacationDto.getVac_end().toString());				
							
							for(; !start.equals(end.plusDays(1)); start=start.plusDays(1)) {
								if(start.getDayOfWeek().getValue()!=7 && start.getDayOfWeek().getValue()!=6) {
									use++;
								}
								daycount++;
							}
						} else {
							LocalDate start = LocalDate.parse(vacationDto.getVac_start().toString());
							LocalDate end = LocalDate.parse(vacationDto.getVac_end().toString());				
							
							for(; !start.equals(end.plusDays(1)); start=start.plusDays(1)) {
								daycount++;
							}
						}
						
						AnnualDto annualDto = annualDao.find(vacationDto.getVac_target_no());
						double remain = annualDto.getAnn_occurred() - annualDto.getAnn_used();
						
						if(use > remain) {//잔여연차보다 사용될 연차가 많으면 에러로 리턴
							addr = "vac_app.jsp?error";
						} else {
							if(vacationApprovalDao.find(vac_no).getDep_head_app().equals("대기")) {
								vacationApprovalDao.signForDephead(vac_no, sign);
							}
							vacationApprovalDao.approveForHrhead(vac_no);
							
							if(daycount>=30) {//30일 이상일 경우 휴가로 설정하고 휴직자 테이블에 추가
								EmployeeDao empDao = new EmployeeDao();
								empDao.setLeave(vacationDto.getVac_target_no());
								new LeaveWorkDao().insert(vacationDto.getVac_target_no(), vacationDto.getVac_no());
							}
							vacationDao.approve(vac_no);

							annualDao.use(vacationDto.getVac_target_no(), use);
						}
					}
				}
			}
			
			resp.sendRedirect(addr);
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
