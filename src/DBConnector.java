package board;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;


public class DBConnector {
	 
    private Connection conn;  				 //�����ͺ��̽��� �����ϱ� ���� ��ü
    private PreparedStatement pstmt;  
    private ResultSet rs;  						 //������ ���� �� �ִ� ������ ����
    
    public DBConnector() {       
    	try{
   	 	 	String dbURL="jdbc:mysql://192.168.0.71:3306/ProjectManagement?serverTimezone=UTC";   // ���� ����
            String dbID="hidata"; // �������� ���̵�
            String dbPassword="hidata2312357!"; // �������� ��й�ȣ
          	Class.forName("com.mysql.jdbc.Driver"); // �����ͺ��̽��� �����ϱ����� ����̹� �ε� 
          	System.out.println("����̹� �ε带 �Ϸ� �Ͽ����ϴ�.");
            conn=DriverManager.getConnection(dbURL, dbID, dbPassword); // �������� URL, ID, PW
            System.out.println("MySQL �����ͺ��̽� db�� ���������� �����߽��ϴ�. "); 	
   			} 
       catch(ClassNotFoundException ex) {
           	System.out.println("����̹� �ε忡 �����Ͽ����ϴ�.");
           	System.out.println(ex);
           }
       catch(SQLException ex) {
           	System.out.println("DB ���ӿ� ���� �Ͽ����ϴ�.");
           	System.out.println(ex.getMessage());
           	ex.printStackTrace();
           }
   	finally{}
    }
    
    
    public int join(BOARD ba) {
        String SQL= "INSERT INTO BOARD VALUES(?, ?, ?, ?, ?, ?) ";
        try {
            pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1,ba.getidx());
            pstmt.setString(2,ba.gettitle());
            pstmt.setString(3,ba.getwriter());
            pstmt.setInt(4,ba.getregdate());
            pstmt.setInt(5,ba.getcount());
            pstmt.setString(6, ba.getcontent());
            
            return pstmt.executeUpdate();
        }
        catch(Exception e) {
            e.printStackTrace();
        }
        return -1;
    }
    
//    public void ExitDB() {
//    	this.pstmt.close();
////        stmt.close();
//        conn.close();
//    }
    
}
