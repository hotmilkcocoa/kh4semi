package groupware.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import groupware.beans.DataSettingDao;
import groupware.beans.DataSettingDto;

@WebServlet(urlPatterns = "/admin/group_add.do")
public class DepartmentHeadAddServlet extends HttpServlet{

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			//준비
			req.setCharacterEncoding("UTF-8");
			DataSettingDto dataSettingDto = new DataSettingDto();
			dataSettingDto.setDep_no(Integer.parseInt(req.getParameter("dep_no")));
			dataSettingDto.setDep_head(req.getParameter("dep_head"));
			dataSettingDto.setDep_name(req.getParameter("dep_name"));
			
			//처리
			DataSettingDao dataSettingDao = new DataSettingDao();
			dataSettingDao.depUpdate(dataSettingDto);
			
			//출력
			resp.sendRedirect(req.getContextPath()+"/admin/group.jsp");
			
			
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
