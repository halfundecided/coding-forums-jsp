<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="question.QuestionDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="question" class="question.Question" scope="page" />
<jsp:setProperty name="question" property="questionTitle" />
<jsp:setProperty name="question" property="questionCategory" />
<jsp:setProperty name="question" property="questionContent" />

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
		} else {
			if (question.getQuestionTitle() == null || question.getQuestionCategory() == null || question.getQuestionContent() == null) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('Insert all informations')");
				script.println("history.back()");
				script.println("</script>");
			} else {
				QuestionDAO QuestionDAO = new QuestionDAO();
				int result = QuestionDAO.write(question.getUserID(), question.getQuestionTitle(), question.getQuestionCategory(), question.getQuestionContent());
				if (result == -1) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('question uploading failure')");
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