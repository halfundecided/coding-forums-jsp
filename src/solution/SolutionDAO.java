package solution;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class SolutionDAO {
	private Connection conn;
	private ResultSet rs;
	
	// Get into Database
	public SolutionDAO() {
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
	
	// get current time
	public String getDate() {
		String SQL = "SELECT NOW()";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}
	
	public int getNext() {
		String SQL = "SELECT solutionID FROM solutions ORDER BY solutionID DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1; // first post
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // database error
	}
	
	public int write(String userID, String solutionLanguage, String solutionContent) {
		String SQL = "INSERT INTO solutions VALUES (?, ?, ?, ?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, userID);
			pstmt.setString(3, getDate());
			pstmt.setString(4, solutionLanguage);
			pstmt.setString(5, solutionContent);
			pstmt.setInt(6, 1);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // database error		
	}
	
	public ArrayList<Solution> getList(int pageNumber) {
		String SQL = "SELECT * FROM solutions WHERE solutionID < ? AND solutionAvailable = 1 ORDER BY solutionID DESC LIMIT 10";
		ArrayList<Solution> list = new ArrayList<Solution>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Solution solution = new Solution();
				solution.setSolutionID(rs.getInt(1));
				solution.setUserID(rs.getString(2));
				solution.setSolutionDate(rs.getString(3));
				solution.setSolutionLanguage(rs.getString(4));
				solution.setSolutionContent(rs.getString(5));
				solution.setSolutionAvailable(rs.getInt(6));			
				list.add(solution);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
//	public boolean nextPage(int pageNumber) {
//		String SQL = "SELECT * FROM questions WHERE questionID < ? AND questionAvailable = 1";
//		try {
//			PreparedStatement pstmt = conn.prepareStatement(SQL);
//			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
//			rs = pstmt.executeQuery();
//			if (rs.next()) {
//				return true;
//			}
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		return false;		
//	}
	
	public Solution getSolution(int solutionID) {
		String SQL = "SELECT * FROM solutions WHERE solutionID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, solutionID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				Solution solution = new Solution();
				solution.setSolutionID(rs.getInt(1));
				solution.setUserID(rs.getString(2));
				solution.setSolutionDate(rs.getString(3));
				solution.setSolutionLanguage(rs.getString(4));
				solution.setSolutionContent(rs.getString(5));
				solution.setSolutionAvailable(rs.getInt(6));
				return solution;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;	
	}
	
	public int update(String solutionID, String solutionLanguage, String solutionContent) {
		String SQL = "UPDATE solutions SET solutionLanguage = ?, solutionContent = ? WHERE solutionID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, solutionLanguage);
			pstmt.setString(2, solutionContent);
			pstmt.setString(3, solutionID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // database error
	}
	
	public int delete(int solutionID) {
		String SQL = "UPDATE solutions SET solutionAvailable = 0 WHERE solutionID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, solutionID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // database error
	}

}
