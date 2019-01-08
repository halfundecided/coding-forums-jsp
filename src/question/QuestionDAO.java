package question;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class QuestionDAO {
	private Connection conn;
	private ResultSet rs;
	
	// Get into Database
	public QuestionDAO() {
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
		String SQL = "SELECT questionID FROM questions ORDER BY questionID DESC";
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
	
	public int write(String questionTitle, String questionContent, String questionCategory) {
		String SQL = "INSERT INTO posts VALUES (?, ?, ?, ?, ?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, questionTitle);
			pstmt.setString(3, getDate());
			pstmt.setString(4, questionCategory);
			pstmt.setString(5, questionContent);
			pstmt.setInt(6, 1);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // database error		
	}
	
	public ArrayList<Question> getList(int pageNumber) {
		String SQL = "SELECT * FROM questions WHERE questionID < ? AND questionAvailable = 1 ORDER BY questionID DESC LIMIT 10";
		ArrayList<Question> list = new ArrayList<Question>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Question question = new Question();
				question.setQuestionID(rs.getInt(1));
				question.setQuestionTitle(rs.getString(2));
				question.setQuestionDate(rs.getString(3));
				question.setQuestionCategory(rs.getString(4));
				question.setQuestionContent(rs.getString(5));
				question.setQuestionAvailable(rs.getInt(6));
				list.add(question);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public boolean nextPage(int pageNumber) {
		String SQL = "SELECT * FROM questions WHERE questionID < ? AND questionAvailable = 1";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;		
	}
	
	public question getQuestion(int questionID) {
		String SQL = "SELECT * FROM questions WHERE postID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, postID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				post post = new post();
				post.setPostID(rs.getInt(1));
				post.setPostTitle(rs.getString(2));
				post.setUserID(rs.getString(3));
				post.setPostDate(rs.getString(4));
				post.setPostContent(rs.getString(5));
				post.setPostAvailable(rs.getInt(6));
				return question;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;	
	}
	
	public int update(int postID, String postTitle, String postContent) {
		String SQL = "UPDATE post SET postTitle = ?, postContent = ? WHERE postID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, postTitle);
			pstmt.setString(2, postContent);
			pstmt.setInt(3, postID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // database error
	}
	
	public int delete(int postID) {
		String SQL = "UPDATE post SET postAvailable = 0 WHERE postID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, postID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // database error
	}
}
