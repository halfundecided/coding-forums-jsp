<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.User" scope="page" />
<jsp:setProperty name="user" property="userPassword" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
<title>Coding Forums | halfundecided</title>
</head>
<body>
	<%
		UserDAO userDAO = new UserDAO() ;
		int result = userDAO.login(user.getUserID(), user.getUserPassword());
		
		// when user successfully logined
		if (result == 1) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
		// no successful 
		} else if (result == -1) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('This ID does not exist')");
			script.println("history.back()");
			script.println("</script>");			
		} else if (result == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('Wrong password!')");
			script.println("history.back()");
			script.println("</script>");			
		} else if (result == -2) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('Database error')");
			script.println("history.back()");
			script.println("</script>");
		}
	%>
</body>
</html> 