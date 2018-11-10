// 데이터 베이스 객체. 데이터베이스에 접근.
package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {
	
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	// Get into Database
	public UserDAO() {
		try {
			String DB_URL = "jdbc:mysql://localhost/coding_forums_jsp?serverTimezone=UTC";
			String USER = "root";
			String PASS = "";
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(DB_URL, USER, PASS);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public int login(String userID, String userPassword ) {
		String SQL = "SELECT userPassword FROM USER WHERE userID = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			// ID exists
			if(rs.next()) {
				if(rs.getString(1).equals(userPassword)) {
					return 1; // Good login
				} else {
					return 0; // no match password
				}
			}
			return -1; // no id exists
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -2;
	}
	
}
