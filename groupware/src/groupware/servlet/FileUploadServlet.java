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

import groupware.beans.TmpFileDao;
import groupware.beans.TmpFileDto;

/**
 *	파일업로드를 테스트하기 위한 서블릿
 *	= 파일은 무조건 doPost()로 수신해야 한다. 
 *	= 기존 방식이 아닌 변경된 방식(multipart/form-data)로 전송되어 오므로 req를 이용한 데이터 수신이 불가능하다.
 *	= 라이브러리(cos.jar)를 이용한 Multipart 방식의 요청을 수신할 수 있는 도구를 생성해야 한다
 */
@WebServlet(urlPatterns = "/file/receive.do")
public class FileUploadServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
//			수신 : req로 불가능하기 때문에 새로운 해석기를 생성해야 한다(MultipartRequest) - cos.jar 필요
			String path = "C:/upload";
			int max = 10 * 1024 * 1024;//10MB
			String encoding = "UTF-8";
			DefaultFileRenamePolicy policy = new DefaultFileRenamePolicy();
			
//			수신 폴더 생성
			File dir = new File(path);
			dir.mkdirs();
			
			MultipartRequest mRequest = new MultipartRequest(req, path, max, encoding, policy);
			
//			계산 : 파일의 주요 정보들을 데이터베이스에 저장
//			= 파일이 아닌 기존 파라미터들은 mRequest.getParameter("")로 수신하면 된다(명령 동일)
//			= 파일데이터 명령은 따로 존재
//			= 저장된 파일명은 mRequest.getFileSystemName("파라미터명") 으로 수신
//			= 업로드한 파일명은 mRequest.getOriginalFileName("파라미터명") 으로 수신
//			= 저장된 파일 객체를 꺼내는 명령은 mRequest.getFile("파라미터명")
//			= 파일 유형은 mRequest.getContentType("파라미터명") 으로 수신
			
			TmpFileDto tmpFileDto = new TmpFileDto();
			tmpFileDto.setSave_name(mRequest.getFilesystemName("f"));
			tmpFileDto.setUpload_name(mRequest.getOriginalFileName("f"));
			File target = mRequest.getFile("f");
			tmpFileDto.setFile_size(target.length());
			tmpFileDto.setFile_type(mRequest.getContentType("f"));
			
			TmpFileDao tmpFileDao = new TmpFileDao();
			tmpFileDao.insert(tmpFileDto);
			
//			출력 : 다른 페이지
			
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}






