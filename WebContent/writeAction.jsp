<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="post.postDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="post" class="post.post" scope="page" />
<jsp:setProperty name="post" property="postTitle" />
<jsp:setProperty name="post" property="postContent" />

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
		if (userID != null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('Please login first')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
		} else {
			if (post.getPostTitle() == null || post.getPostContent() == null) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('Insert all informations')");
				script.println("history.back()");
				script.println("</script>");
			} else {
				postDAO postDAO = new postDAO();
				int result = postDAO.write(post.getPostTitle(), userID, post.getPostContent());
				if (result == -1) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('posting failure')");
					script.println("history.back()");
					script.println("</script>");
				} else {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("location.href = 'forum-main.jsp'");
					script.println("</script>");
				}
			}
			
		}
	%>
</body>
</html> 