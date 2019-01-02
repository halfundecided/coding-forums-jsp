<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="post.postDAO" %>
<%@ page import="post.post" %>
<%@ page import="java.util.ArrayList" %>
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
		// page number
		int pageNumber = 1;
		if (request.getParameter("pageNumber") != null) {
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}
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
					aria-haspopup="true" aria-expanded="false"> Get-In </a>
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
						<th scope="col" style="">#</th>
						<th scope="col" style="">Title</th>
						<th scope="col" style="">Author</th>
						<th scope="col" style="">Date</th>
					</tr>
				</thead>
				<tbody>
					<%
						postDAO postDAO = new postDAO();
						ArrayList<post> list = postDAO.getList(pageNumber);
						for(int i = 0; i < list.size(); i++) {
					%>
					<tr>
						<td><%= list.get(i).getPostID() %></td>
						<td><a href = "view.jsp?postID=<%= list.get(i).getPostID() %>"><%= list.get(i).getPostTitle() %></a></td>
						<td><%= list.get(i).getUserID() %></td>
						<td><%= list.get(i).getPostDate().substring(0, 11) + list.get(i).getPostDate().substring(11, 13) + ":" + list.get(i).getPostDate().substring(14, 16) %></td>
					</tr>

					<% 
						}
					%>
				
				</tbody>
			</table>
			<%
				if(pageNumber != 1) {	
			%>
				<a href="forum-main.jsp?pageNumber=<%=pageNumber -1%>" class="btn btn-success btn-arrow-left">Previous</a>
			<%
				} if (postDAO.nextPage(pageNumber + 1)) {
			%>
				<a href="forum-main.jsp?pageNumber=<%=pageNumber -1%>" class="btn btn-success btn-arrow-left">Next</a>
			<% 
				}
			%>
			<a href="write-post.jsp" class="btn btn-outline-secondary">Write</a>
			
		</div>
	</div>
	
	

	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
</body>
</html>
