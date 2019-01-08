<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="solution.SolutionDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="solution" class="solution.Solution" scope="page" />
<jsp:setProperty name="solution" property="solutionLanguage" />
<jsp:setProperty name="solution" property="solutionContent" />

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
			if (solution.getSolutionLanguage() == null || solution.getSolutionContent() == null) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('Insert all informations')");
				script.println("history.back()");
				script.println("</script>");
			} else {
				SolutionDAO SolutionDAO = new SolutionDAO();
				int result = SolutionDAO.write(solution.getUserID(), solution.getSolutionLanguage(), solution.getSolutionContent());
				if (result == -1) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('solution uploading failure')");
					script.println("history.back()");
					script.println("</script>");
				} else {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("location.href = 'view-question.jsp'");
					script.println("</script>");
				}
			}
			
		}
	%>
</body>
</html> 