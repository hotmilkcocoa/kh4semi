package groupware.servlet;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import groupware.beans.MessageFileDao;
import groupware.beans.MessageFileDto;

@WebServlet(urlPatterns = "/message/download.do")
public class MsgFileDownloadServlet extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			//준비 : 메세지번호 수신
			int msg_no = Integer.parseInt(req.getParameter("msg_no"));
			
			//계산 : 메세지번호로 파일정보를 불러오고 파일명을 이용해서 실제 파일을 불러온다
			// ( 번호 --> DTO --> 파일 --> byte[])
			MessageFileDao msgFileDao = new MessageFileDao();
			MessageFileDto msgFileDto = msgFileDao.find(msg_no);
			System.out.println(msgFileDto.getFile_save_name());
			String path = "D:/upload/kh41/msg";
			File target = new File(path, msgFileDto.getFile_save_name());
			byte[] data = new byte[(int)target.length()];//파일크기만큼 배열생성
			FileInputStream in = new FileInputStream(target);
			in.read(data);//data에 파일의 모든 내용을 저장(크기가 일치하므로 딱 맞게 들어간다)
			
			//출력 : 사용자에게 결론적으로 data를 보내면 되지만, 추가적인 정보를 줘서 사용자가 좀 더 많은 정보를 알 수 있도록 도움을 준다.
			// = 정보 설정은 header 에 수행한다. 설정 명령은 resp.setHeader("이름", "정보")
			resp.setHeader("Content-Type", "application/octet-stream");
			resp.setHeader("Content-Encoding", "UTF-8");
			resp.setHeader("Content-length", String.valueOf(msgFileDto.getFile_size()));
			resp.setHeader("Content-Disposition", "attachment; filename="+msgFileDto.getFile_upload_name());
			
			resp.getOutputStream().write(data); //읽어온 데이터를 사용자에게 전해줌

		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}	
	}
	
}
