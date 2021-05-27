<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="ISO-8859-1">
		<title>register page</title>
		<%@include file="components/common_css_js.jsp" %>
	</head>
	<body>
		<%@include file="components/navbar.jsp" %>
		
		<div class="container-fluid">
			<div class="row mt-5"> 
				<div class="col-md-6 offset-md-3">
					<div class="card">
						<%@include file="components/message.jsp" %>
						<div class="card-body px-5">
							<h1 class="text-center my-3">Sign up here</h1>
							<form action="RegisterServlet" method="post">
								<div class="form-group">
								    <label for="name">User name</label>
								    <input name="user_name" type="text" class="form-control" id="name" placeholder="Enter user name">
			  					</div>
			  					<div class="form-group">
								    <label for="email">User email</label>
								    <input name="user_email" type="email" class="form-control" id="email" placeholder="Enter user email">
			  					</div>
			  					<div class="form-group">
								    <label for="password">User password</label>
								    <input name="user_password" type="password" class="form-control" id="password" placeholder="Enter user password">
			  					</div>
			  					<div class="form-group">
								    <label for="phone">User phone</label>
								    <input name="user_phone" type="number" class="form-control" id="phone" placeholder="Enter user phone">
			  					</div>
			  					<div class="form-group">
								    <label for="address">User address</label>
								    <textarea name="user_address" style="height:200px" class="form-control" placeholder="enter user address"></textarea>
			  					</div>
			  					<div class="container text-center">
			  						<button class="btn btn-outline-success" type="submit">Register</button>
			  						<button class="btn btn-outline-warning" type="reset">Reset</button>
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