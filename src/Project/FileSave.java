package Project;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;

import javax.servlet.http.HttpServletRequest;

import com.mysql.jdbc.Statement;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class FileSave {
	// 파일이 저장될 서버의 경로. 되도록이면 getRealPath를 이용하자.
	// String savePath = "D:/Projects/workspace/projectName/WebContent/folderName";
	String savePath = request.getServletContext().getRealPath("Document");
	 
	// 파일 크기 8MB로 제한
	int sizeLimit = 1024*1024*8;
	 
	//  ↓ request 객체,               ↓ 저장될 서버 경로,       ↓ 파일 최대 크기,    ↓ 인코딩 방식,       ↓ 같은 이름의 파일명 방지 처리
	// (HttpServletRequest request, String saveDirectory, int maxPostSize, String encoding, FileRenamePolicy policy)
	// 아래와 같이 MultipartRequest를 생성만 해주면 파일이 업로드 된다.(파일 자체의 업로드 완료)
	MultipartRequest multi = new MultipartRequest(request, savePath, sizeLimit, "utf-8", new DefaultFileRenamePolicy());
	 
	 
	// --------------------------아래는 전송 받은 데이터들을 DB테이블에 저장시키기 위한 작업들이다.--------------------------
	// 테이블 설계, 쿼리문, DTO, DAO, Service.. 등은 만들어져 있다고 가정한다.
	 
	 
	 
	// MultipartRequest로 전송받은 데이터를 불러온다.
	// enctype을 "multipart/form-data"로 선언하고 submit한 데이터들은 request객체가 아닌 MultipartRequest객체로 불러와야 한다.
	String m_name = multi.getParameter("m_name");
	String m_nickname = multi.getParameter("m_nickname");
	 
	// 전송받은 데이터가 파일일 경우 getFilesystemName()으로 파일 이름을 받아올 수 있다.
	String fileName = multi.getFilesystemName("m_file");
	 
	// 업로드한 파일의 전체 경로를 DB에 저장하기 위함
	String m_fileFullPath = savePath + "/" + fileName;
	 
	 
	// 데이터들을 담을 그릇인 DTO(혹은 Bean) 객체를 생성 후, 데이터들을 set해준다.
	MemberDTO memberDTO = new MemberDTO();
	 
	memberDTO.setM_name(m_name);
	memberDTO.setM_nickname(m_nickname);
	memberDTO.setM_fileFullPath(m_fileFullPath);
	memberDTO.setM_fileName(fileName);
	 
	// Service 객체 생성.(서비스가 없고 DAO에서 직접 처리한다면 DAO 객체 생성)
	MemberService service = MemberService.getInstance();
	 
	// 서비스에서 만들어놓은 insert 수행 메서드 사용. set으로 담아줬던 DTO를 넘겨서 insert 수행.
	service.insertMember(memberDTO);
	 
	// 검증 처리는 생략했다.
	// 검증은 Controller 혹은 Action에서 해도 되고, 입력 폼이 있는 jsp에서 해도 된다. 둘다 해도 되고..
	// 그런 건 각자 알아서.
	 
	// 만약 return할 페이지에 방금 전송한 데이터들을 출력하고 싶다면 DTO를 속성에 담아준다.
	request.setAttribute("memberDTO", memberDTO);
	 
	// ↓ 모든 것이 성공적으로 수행되었을 경우 return 될 page
	return "blabla/blabla.jsp";

}
