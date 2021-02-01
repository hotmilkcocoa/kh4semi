package groupware.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import groupware.beans.BoardDao;
import groupware.beans.BoardDto;
import groupware.beans.EmployeeDao;
import groupware.beans.EmployeeDto;
@WebServlet(urlPatterns = "/board/write.do")
public class BoardWriteServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			req.setCharacterEncoding("UTF-8");
			
			//내용
			BoardDto boardDto = new BoardDto();
			boardDto.setBoard_header(req.getParameter("board_header"));
			boardDto.setBoard_title(req.getParameter("board_title"));
			boardDto.setBoard_context(req.getParameter("board_context"));
			
//			현재 로그인한 사용자 정보를 불러오는 코드
			int emp_no=(int)req.getSession().getAttribute("check");
			EmployeeDao employeeDao = new EmployeeDao();
			EmployeeDto employeeDto = employeeDao.find(emp_no);
			
			boardDto.setBoard_writer(emp_no);
			
			BoardDao boardDao = new BoardDao();
			int board_no = boardDao.getSequence();	
			boardDto.setBoard_no(board_no);			
			boardDto.setBoard_dep(employeeDto.getEmp_dep());
			boardDao.writeWithPrimaryKey(boardDto);	
			
			resp.sendRedirect("notice_list.jsp?board_no="+board_no);
			
		}catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
