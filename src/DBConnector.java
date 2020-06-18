package board;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;


public class DBConnector {
	 
    private Connection conn;  				 //데이터베이스에 접근하기 위한 객체
    private PreparedStatement pstmt;  
    private ResultSet rs;  						 //정보를 담을 수 있는 변수를 생성
    
    public DBConnector() {       
    	try{
   	 	 	String dbURL="jdbc:mysql://192.168.0.71:3306/ProjectManagement?serverTimezone=UTC";   // 서버 정보
            String dbID="hidata"; // 서버접속 아이디
            String dbPassword="hidata2312357!"; // 서버접속 비밀번호
          	Class.forName("com.mysql.jdbc.Driver"); // 데이터베이스에 접속하기위한 드라이버 로드 
          	System.out.println("드라이버 로드를 완료 하였습니다.");
            conn=DriverManager.getConnection(dbURL, dbID, dbPassword); // 계정정보 URL, ID, PW
            System.out.println("MySQL 데이터베이스 db에 성공적으로 접속했습니다. "); 	
   			} 
       catch(ClassNotFoundException ex) {
           	System.out.println("드라이버 로드에 실패하였습니다.");
           	System.out.println(ex);
           }
       catch(SQLException ex) {
           	System.out.println("DB 접속에 실패 하였습니다.");
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
