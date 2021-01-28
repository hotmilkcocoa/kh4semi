package groupware.servlet;

import java.io.IOException;
import java.sql.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import groupware.beans.DataSettingDao;
import groupware.beans.DataSettingDto;

@WebServlet(urlPatterns = "/admin/tna_setting_edit.do")
public class TnASettingEditServlet extends HttpServlet{

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			//준비
			req.setCharacterEncoding("UTF-8");
			DataSettingDto dataSettingDto = new DataSettingDto();
			dataSettingDto.setAtt_set_no(Integer.parseInt(req.getParameter("att_set_no")));			
			String att_set_start = req.getParameter("att_set_start");
			String att_set_end = req.getParameter("att_set_end");
			//insert into ... values(to_date(?, 'MI:SS'))
			//dataSettingDto.setAtt_set_start(Date.valueOf(req.getParameter("att_set_start")));
			//dataSettingDto.setAtt_set_end(Date.valueOf(req.getParameter("att_set_end")));
			dataSettingDto.setAtt_set_late(Integer.parseInt(req.getParameter("att_set_late")));
			
			//처리
			DataSettingDao dataSettingDao = new DataSettingDao();
			dataSettingDao.att_setUpdate(dataSettingDto, att_set_start, att_set_end);
			
			//출력
			resp.sendRedirect(req.getContextPath()+"/admin/tna_setting.jsp");
			
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
