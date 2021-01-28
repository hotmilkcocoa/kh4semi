package groupware.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import groupware.beans.BoardDao;
import groupware.beans.BoardFreeDao;
import groupware.beans.BoardFreeDto;
import groupware.beans.EmployeeDao;
import groupware.beans.EmployeeDto;
@WebServlet(urlPatterns = "/board/free_write.do")
public class BoardFreeWriteServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			req.setCharacterEncoding("UTF-8");
			
			BoardFreeDto freeDto = new BoardFreeDto();
			freeDto.setFree_header(req.getParameter("free_header"));
			freeDto.setFree_title(req.getParameter("free_title"));
			freeDto.setFree_context(req.getParameter("free_context"));
			
			//로그인한 사람정보
			int emp_no=1;
			EmployeeDao employeeDao = new EmployeeDao();
			EmployeeDto employeeDto = employeeDao.find(emp_no);
			
			freeDto.setFree_writer(emp_no);
			
			//시퀀스, 글 등록
			BoardFreeDao freeDao = new BoardFreeDao();
			int free_no = freeDao.getSequence();	//시퀀스번호생성
			freeDto.setFree_no(free_no);			//생성된 번호를 DTO에 설정
			freeDao.writeWithPrimaryKey(freeDto);	//설정된 정보를 등록!
			
			resp.sendRedirect("free_list.jsp?free_no="+free_no);
			
		}catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
