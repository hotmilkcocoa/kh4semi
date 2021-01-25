package groupware.servlet;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import groupware.beans.TmpFileDao;
import groupware.beans.TmpFileDto;

/**
 *	사용자가 파일번호를 알려주며 다운로드를 요청하면 그에 맞는 파일을 불러서 사용자에게 전송
 *	= 사용자에게 주는게 화면(text/html)이 아니라 파일(application/octet-stream)이라는 것을 이해해야 한다.
 *	= 파일은 무조건 하나씩만 전송이 가능하다
 *	= 사용자에게 필요한 정보들을 추가적으로 알려줘야 한다
 */
@WebServlet(urlPatterns = "/file/download.do")
public class FileDownloadServlet extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
//			준비 : 파일번호를 수신
			int file_no = Integer.parseInt(req.getParameter("file_no"));
			
//			계산 : 파일번호로 파일정보를 불러오고 파일명을 이용해서 실제 파일을 불러온다
//			(번호 --> DTO --> 파일 --> byte[])
			TmpFileDao tmpFileDao = new TmpFileDao();
			TmpFileDto tmpFileDto = tmpFileDao.find(file_no);
			
			String path = "C:/upload";
			File target = new File(path, tmpFileDto.getSave_name());
			byte[] data = new byte[(int)target.length()];//파일크기만큼 배열 생성
			FileInputStream in = new FileInputStream(target);//파일을 읽기 위한 통로 생성
			in.read(data);//data에 파일의 모든 내용을 저장(크기가 일치하므로 딱 맞게 들어간다)
			in.close();
			
//			출력 : 사용자에게 data를 보내면 되지만, 추가적인 정보들을 줘서 사용자가 좀 더 많은 정보를 알 수 있도록 도움을 준다
//			= 정보 설정은 header 에 수행한다. 설정 명령은 resp.setHeader("이름", "정보")
			
			resp.setHeader("Content-Type", "application/octet-stream");
			resp.setHeader("Content-Encoding", "UTF-8");
			resp.setHeader("Content-Length", String.valueOf(tmpFileDto.getFile_size()));
			resp.setHeader("Content-Disposition", "attachment; filename=\""+URLEncoder.encode(tmpFileDto.getUpload_name(), "UTF-8")+"\"");
			
			resp.getOutputStream().write(data);//읽어온 데이터를 사용자에게 전송
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}







