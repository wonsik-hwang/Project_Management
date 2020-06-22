package Project;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;

import javax.servlet.http.HttpServletRequest;

import com.mysql.jdbc.Statement;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class FileSave {
	// ������ ����� ������ ���. �ǵ����̸� getRealPath�� �̿�����.
	// String savePath = "D:/Projects/workspace/projectName/WebContent/folderName";
	String savePath = request.getServletContext().getRealPath("Document");
	 
	// ���� ũ�� 8MB�� ����
	int sizeLimit = 1024*1024*8;
	 
	//  �� request ��ü,               �� ����� ���� ���,       �� ���� �ִ� ũ��,    �� ���ڵ� ���,       �� ���� �̸��� ���ϸ� ���� ó��
	// (HttpServletRequest request, String saveDirectory, int maxPostSize, String encoding, FileRenamePolicy policy)
	// �Ʒ��� ���� MultipartRequest�� ������ ���ָ� ������ ���ε� �ȴ�.(���� ��ü�� ���ε� �Ϸ�)
	MultipartRequest multi = new MultipartRequest(request, savePath, sizeLimit, "utf-8", new DefaultFileRenamePolicy());
	 
	 
	// --------------------------�Ʒ��� ���� ���� �����͵��� DB���̺� �����Ű�� ���� �۾����̴�.--------------------------
	// ���̺� ����, ������, DTO, DAO, Service.. ���� ������� �ִٰ� �����Ѵ�.
	 
	 
	 
	// MultipartRequest�� ���۹��� �����͸� �ҷ��´�.
	// enctype�� "multipart/form-data"�� �����ϰ� submit�� �����͵��� request��ü�� �ƴ� MultipartRequest��ü�� �ҷ��;� �Ѵ�.
	String m_name = multi.getParameter("m_name");
	String m_nickname = multi.getParameter("m_nickname");
	 
	// ���۹��� �����Ͱ� ������ ��� getFilesystemName()���� ���� �̸��� �޾ƿ� �� �ִ�.
	String fileName = multi.getFilesystemName("m_file");
	 
	// ���ε��� ������ ��ü ��θ� DB�� �����ϱ� ����
	String m_fileFullPath = savePath + "/" + fileName;
	 
	 
	// �����͵��� ���� �׸��� DTO(Ȥ�� Bean) ��ü�� ���� ��, �����͵��� set���ش�.
	MemberDTO memberDTO = new MemberDTO();
	 
	memberDTO.setM_name(m_name);
	memberDTO.setM_nickname(m_nickname);
	memberDTO.setM_fileFullPath(m_fileFullPath);
	memberDTO.setM_fileName(fileName);
	 
	// Service ��ü ����.(���񽺰� ���� DAO���� ���� ó���Ѵٸ� DAO ��ü ����)
	MemberService service = MemberService.getInstance();
	 
	// ���񽺿��� �������� insert ���� �޼��� ���. set���� ������ DTO�� �Ѱܼ� insert ����.
	service.insertMember(memberDTO);
	 
	// ���� ó���� �����ߴ�.
	// ������ Controller Ȥ�� Action���� �ص� �ǰ�, �Է� ���� �ִ� jsp���� �ص� �ȴ�. �Ѵ� �ص� �ǰ�..
	// �׷� �� ���� �˾Ƽ�.
	 
	// ���� return�� �������� ��� ������ �����͵��� ����ϰ� �ʹٸ� DTO�� �Ӽ��� ����ش�.
	request.setAttribute("memberDTO", memberDTO);
	 
	// �� ��� ���� ���������� ����Ǿ��� ��� return �� page
	return "blabla/blabla.jsp";

}
