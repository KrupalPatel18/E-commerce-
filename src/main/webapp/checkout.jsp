<%
	User user = (User)session.getAttribute("login");
	if(user == null){
		session.setAttribute("warning","you are not logged in");
		response.sendRedirect("login.jsp");
		return;
	}
%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="ISO-8859-1">
		<title>Checkout-page</title>
		<%@include file="components/common_css_js.jsp" %>
		<style type="text/css">
		  <%@include file="css/style.css" %>
		</style>
	</head>
	<body>
		<%@include file="components/navbar.jsp" %>
		
		<div class="container">
			<div class="row mt-3">
				<div class="col-md-6">
					<div class="card">
						<h3 class="text-center my-3">Your Items</h3>
						<div class="cart-body"></div>
					</div>
				</div>
				<div class="col-md-6 mt-3">
					<div class="card">
						<div class="card-body">
							<h3 class="text-center my-3">Your Details</h3>
							<form action="">
								<div class="form-group">
								    <label for="email">Email address</label>
								    <input value=<%= user.getUserEmail() %> type="email" class="form-control" id="email" aria-describedby="emailHelp" placeholder="Enter email">								  
								</div>
								<div class="form-group">
								    <label for="name">Your name</label>
								    <input value=<%= user.getUserName() %> type="text" class="form-control" id="name" aria-describedby="emailHelp" placeholder="Enter name">								  
								</div>
								<div class="form-group">
								    <label for="address">Your Shipping Address</label>
								    <textarea class="form-control" id="address"><%= user.getUserAddress() %></textarea>
								</div>
								<div class="container text-center">
									<button class="btn btn-success" type="submit">Order now</button>
									<a href="index.jsp"><button class="btn btn-primary" type="button">Continue Shopping</button></a>
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