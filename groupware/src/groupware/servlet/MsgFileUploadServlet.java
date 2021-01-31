package groupware.servlet;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import groupware.beans.MessageDao;
import groupware.beans.MessageDto;
import groupware.beans.MessageFileDao;
import groupware.beans.MessageFileDto;

@WebServlet(urlPatterns = "/message/upload.do")
public class MsgFileUploadServlet extends HttpServlet{
	/*
	 * 파일 업로드를 테스트하기 위한 서블릿
	 * = 파일은 무조건 doPost()로 수신해야 한다.
	 * = 기존 방식이 아닌 변경된 방식 (multipart/form-data)로 전송되어 req를 이용한 데이터 수신이 불가능하다.
	 * = 라이브러리(cos.jar)를 이용한 Multipart 방식의 요청을 수신할 수 있는 도구를 생성해야 한다.
	 *
	 * */
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			req.setCharacterEncoding("UTF-8");
			int message_sender = (int)req.getSession().getAttribute("check"); //보내는사람
			
			//수신 : req로 불가능하기 때문에 새로운 해석기를 생성해야 한다.(MultipartRequest) - cos.jar 필요
			String path = "/Users/yujin/Documents/kh_upload";
			int max = 10 * 1024 * 1024; //10MB
			String encoding = "UTF-8";
			DefaultFileRenamePolicy policy = new DefaultFileRenamePolicy();
			
			//수신폴더 생성
			File dir = new File(path);
			dir.mkdir();
			
			//MultipartRequest mRequest = new MultipartRequest(요청객체, 저장경로, 저장크기, 인코딩방식, 작명정책);
			MultipartRequest mRequest = new MultipartRequest(req, path, max, encoding, policy);
			
			MessageDto msgDto = new MessageDto();
			MessageDao msgDao = new MessageDao();
			
			String receiver = mRequest.getParameter("msg_receiver");//받는사람들
			String[] msg_receiver = receiver.split(",");
			String message_title = mRequest.getParameter("msg_title"); //제목
			String message_content = mRequest.getParameter("msg_content"); //타이틀
			MessageFileDto msgFileDto = new MessageFileDto();
			File target = mRequest.getFile("f");
			MessageFileDao tmpFileDao = new MessageFileDao();
			
			int[] message_receiver = new int[msg_receiver.length];
			int message_no;
			for(int i = 0; i < message_receiver.length; i ++) {
				message_no = msgDao.getSequence();
				message_receiver[i] = Integer.parseInt(msg_receiver[i]);
				
				msgDto.setMessage_no(message_no);
				msgDto.setMessage_sender(message_sender);
				msgDto.setMessage_receiver(message_receiver[i]); //받는사람들
				msgDto.setMessage_title(message_title);
				msgDto.setMessage_content(message_content);
				
				msgDao.insert(msgDto);
				
				if(mRequest.getFilesystemName("f") != null) {
					msgFileDto.setMessage_no(message_no);
					msgFileDto.setFile_save_name(mRequest.getFilesystemName("f"));
					msgFileDto.setFile_upload_name(mRequest.getOriginalFileName("f"));
					
					
					msgFileDto.setFile_size(target.length());
					msgFileDto.setFile_type(mRequest.getContentType("f"));
					
					
					tmpFileDao.insert(msgFileDto);
				}
			}
			
			//계산 : 파일의 주요 정보들을 데이터베이스에 저장
			// = 파일이 아닌 기존 파라미터들은 mRequest.getParameter("") 로 수신하면 된다.(명령동일)
			// = 파일데이터 명령은 따로 존재
			// = 저장된 파일명은 mRequest.getFileSystemName("파라미터명") 으로 수신
			// = 업로드한 파일명은 mRequest.getOriginalFileName("파라미터명") 으로 수신
			// = 저장된 파일 객체를 꺼내는 명령은 mRequest.getFile("파라미터명")
			// = 파일 유형은 mRequest.getContentType("파라미터명") 으로 수신
			
			
			resp.sendRedirect("inbox.jsp");
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
