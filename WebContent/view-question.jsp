<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="question.Question" %>
<%@ page import="question.QuestionDAO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
<title>Coding Forums | halfundecided</title>
</head>
<body>
	<%
		String userID = null;
		if(session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		int questionID = 0;
		if (request.getParameter("questionID") != null) {
			questionID = Integer.parseInt(request.getParameter("questionID"));		
		}
		if (questionID == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('invalid post')");
			script.println("location.href = 'forum-main.jsp'");
			script.println("</script>");
		}
		Question question = new QuestionDAO().getQuestion(questionID);
	%>
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<a class="navbar-brand" href="main.jsp">Coding Forums</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarNavDropdown" aria-controls="navbarNavDropdown"
			aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarNavDropdown">
			<ul class="navbar-nav">
				<li class="nav-item"><a class="nav-link" href="main.jsp">Main<span class="sr-only">(current)</span></a></li>
				<li class="nav-item active"><a class="nav-link" href="forum-main.jsp">Forums</a></li>
				<!-- Not logged in --> 
				<%
					if(userID == null) {
				%>
				
				<li class="nav-item dropdown"><a
					class="nav-link dropdown-toggle" href="#"
					id="navbarDropdownMenuLink" role="button" data-toggle="dropdown"
					aria-haspopup="true" aria-expanded="false"> Get In </a>
					<div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
						<a class="dropdown-item" href="login.jsp">Log In</a> 
						<a class="dropdown-item" href="join.jsp">Sign Up</a>
					</div>
				</li>
				<!-- When you are already logged in -->
				<%
					} else {
				%>
				<li class="nav-item dropdown"><a
					class="nav-link dropdown-toggle" href="#"
					id="navbarDropdownMenuLink" role="button" data-toggle="dropdown"
					aria-haspopup="true" aria-expanded="false">Account</a>
					<div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
						<a class="dropdown-item" href="logoutAction.jsp">Log Out</a> 
					</div>
				</li>
				<%
					}
				%>
				
			
			</ul>
		</div>
	</nav>
	
	<!-- dash board -->
	<div class="container">
		<div class="row">
			<table class="table table-hover style="">
				<thead>
					<tr>
						<th colspan="3" scope="col" style="">Problem</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="width: 20%;">Title</td>
						<td colspan="2"><%= question.getQuestionTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>
					</tr>
					<tr>
						<td>Category</td>
						<td colspan="2"><%= question.getQuestionCategory() %></td>
					</tr>
					<tr>
						<td>Content</td>
						<td colspan="2" style="min-height: 200px; text-align: left;"><%= question.getQuestionContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>
					</tr>
				</tbody>
			</table>
			<a href="forum-main.jsp" class="btn btn-secondary">list</a>
			<!-- if author -->
			<%
				if(userID != null && userID.equals(question.getUserID())) {
			%> 
					<a href="update-question.jsp?questionID=<%= questionID %>" class="btn btn=secondary">Edit</a>
					<a onclick="return confirm('really want to delete?')" href="deleteQuestionAction.jsp?questionID=<%= questionID %>" class="btn btn=secondary">Delete</a>
			<%
				}
			%>
			<input type="submit" class="btn btn-outline-secondary" value="Post">
		</div>
	</div>


	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
</body>
</html>