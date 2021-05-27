<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="ISO-8859-1">
		<title>login page</title>
		<%@include file="components/common_css_js.jsp" %>
	</head>
	<body>
		<%@include file="components/navbar.jsp" %>
		<div class="container-fluid">
			<div class="row"> 
				<div class="col-md-6 offset-md-3">
					<div class="card mt-3">
						<%@include file="components/message.jsp" %>
						<div class="card-header custom-bg text-dark">
							<h3 class="text-center">Login here</h3>
						</div>
						<div class="card-body">
							<form action="LoginServlet" method="post">
								<div class="form-group">
								    <label for="email">User email</label>
								    <input name="user_email" type="email" class="form-control" id="email" placeholder="Enter user email">
			  					</div>
			  					<div class="form-group">
								    <label for="password">User password</label>
								    <input name="user_password" type="password" class="form-control" id="password" placeholder="Enter user password">
			  					</div>
			  					<a href="register.jsp">new user</a>
			  					<div class="container text-center">
			  						<button class="btn btn-outline-success" type="submit">Login</button>
			  					</div>
			  				</form>
						</div>
					</div>
				</div>
			</div>
		</div>
		<%@include file="components/cart_modal.jsp" %>
	</body>
</html>