package groupware.servlet;

import java.io.IOException;
import java.sql.Timestamp;
import java.time.LocalDateTime;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import groupware.beans.ScheduleDao;
import groupware.beans.ScheduleDto;

@WebServlet(urlPatterns = "/admin/event_add_edit.do")
public class EventAddEditServlet extends HttpServlet{

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			//준비
			req.setCharacterEncoding("UTF-8");
			ScheduleDto scheduleDto = new ScheduleDto();
			scheduleDto.setSch_name(req.getParameter("sch_name"));
			scheduleDto.setSch_content(req.getParameter("sch_content"));
			scheduleDto.setSch_place(req.getParameter("sch_place"));
			scheduleDto.setSch_open(req.getParameter("sch_open"));
			
			String start = req.getParameter("sch_start_date") + "T" + req.getParameter("sch_start_time");
			String end = req.getParameter("sch_end_date") + "T" + req.getParameter("sch_end_time");
			scheduleDto.setSch_start(Timestamp.valueOf(LocalDateTime.parse(start)));
			scheduleDto.setSch_end(Timestamp.valueOf(LocalDateTime.parse(end)));
			
			scheduleDto.setEmp_no((int) req.getSession().getAttribute("check"));
			
			//처리
			ScheduleDao scheduleDao = new ScheduleDao();
			if(req.getParameter("edit") == null) {
				scheduleDao.insertForCom(scheduleDto);
			} else {
				scheduleDto.setSch_no(Integer.parseInt(req.getParameter("sch_no")));
				scheduleDao.update(scheduleDto);
			}
			
			//출력
			resp.sendRedirect(req.getContextPath()+"/admin/event_list.jsp");
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
