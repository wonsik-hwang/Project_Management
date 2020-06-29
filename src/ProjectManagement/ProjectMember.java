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
		
		// 클라이언트에서 넘긴 데이터 받기
		String[] aStr = request.getParameterValues("SelectMember[]");
		
		// 배열의 값 출력 1
		System.out.println("배열에 들어있는 값 : " + Arrays.toString(aStr));
		
		// 배열의 값 출력 2
		for ( String str : aStr)
		{
			System.out.println(aStr);
		}
		
		// 클라이언트에 값 전달
		// 요청한 곳에 응답. json 형식 및 다양한 형식으로 전달 가능
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
