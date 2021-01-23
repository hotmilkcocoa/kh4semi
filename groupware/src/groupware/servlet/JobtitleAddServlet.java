package groupware.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import groupware.beans.DataSettingDao;
import groupware.beans.DataSettingDto;

@WebServlet(urlPatterns = "/admin/title_add.do")
public class JobtitleAddServlet extends HttpServlet{

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			//준비
			req.setCharacterEncoding("UTF-8");
			DataSettingDto dataSettingDto = new DataSettingDto();
			dataSettingDto.setTitle_name(req.getParameter("title_name"));
			
			//처리
			DataSettingDao dataSettingDao = new DataSettingDao();
			dataSettingDao.titleAdd(dataSettingDto);
			
			//출력
			resp.sendRedirect(req.getContextPath()+"/admin/data_list.jsp");
			
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
