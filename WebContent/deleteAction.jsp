<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="post.postDAO" %>
<%@ page import="post.post" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
<title>Coding Forums | halfundecided</title>
</head>
<body>
	<%
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		if (userID == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('Please login first')"); 
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
		} 
		int postID = 0;
		if (request.getParameter("postID") != null) {
			postID = Integer.parseInt(request.getParameter("postID"));		
		}
		if (postID == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('invalid post')");
			script.println("location.href = 'forum-main.jsp'");
			script.println("</script>");
		}
		post post = new postDAO().getPost(postID);
		if(!userID.equals(post.getUserID())) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('invalid access')");
			script.println("location.href = 'forum-main.jsp'");
			script.println("</script>");
		} else {
				postDAO postDAO = new postDAO();
				int result = postDAO.delete(postID);
				if (result == -1) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('deleting failure')");
					script.println("history.back()");
					script.println("</script>");
				} else {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("location.href = 'forum-main.jsp'");
					script.println("</script>");
				}
		}
	%>
</body>
</html> 