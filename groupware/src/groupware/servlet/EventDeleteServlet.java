package groupware.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import groupware.beans.ScheduleDao;

@WebServlet(urlPatterns = "/admin/event_delete.do")
public class EventDeleteServlet extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			//준비
			req.setCharacterEncoding("UTF-8");
			String prev = req.getParameter("prev");//지난일정관리에서 왔을 시 데이터 값 추가됨
			int sch_no = Integer.parseInt(req.getParameter("sch_no"));
			
			//처리
			ScheduleDao scheduleDao = new ScheduleDao();
			scheduleDao.deleteOne(sch_no);
			
			//출력
			if(prev != null) {
				//지난일정관리에서 왔으면 지난일정관리로
				resp.sendRedirect(req.getContextPath()+"/admin/prev_event_list.jsp");
			}
			else {
				//추가일정관리에서 왔으면 추가일정관리로
				resp.sendRedirect(req.getContextPath()+"/admin/event_list.jsp");				
			}
			
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
