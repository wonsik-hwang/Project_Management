package ProjectManagement;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Arrays;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ProjectMember extends HttpServlet {
	public void doGet (HttpServletRequest request, HttpServletResponse response)
	throws ServletException, IOException
	{
		System.out.println("doPost()-------------------------------------------");
		
		// Ŭ���̾�Ʈ���� �ѱ� ������ �ޱ�
		String[] aStr = request.getParameterValues("SelectMember[]");
		
		// �迭�� �� ��� 1
		System.out.println("�迭�� ����ִ� �� : " + Arrays.toString(aStr));
		
		// �迭�� �� ��� 2
		for ( String str : aStr)
		{
			System.out.println(aStr);
		}
		
		// Ŭ���̾�Ʈ�� �� ����
		// ��û�� ���� ����. json ���� �� �پ��� �������� ���� ����
		if (aStr != null)
		{
			PrintWriter out = response.getWriter();
			out.write("[\"" + aStr[0] + "\", \"" + aStr[1] + "\"]");
			out.close();
		}
	}
	public void doPost (HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException
			{
				System.out.println("doPost()-------------------------------------------");
			}
}
