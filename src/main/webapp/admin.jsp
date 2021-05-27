<%@page import="java.util.Map"%>
<%@page import="com.ecommerce.helper.Helper"%>
<%@page import="com.ecommerce.entities.Category"%>
<%@page import="java.util.List"%>
<%@page import="com.ecommerce.helper.FactoryProvider"%>
<%@page import="com.ecommerce.dao.CategoryDao"%>
<%@page import="com.ecommerce.entities.User"%>
<%
	User user = (User)session.getAttribute("login");
	if(user == null){
		session.setAttribute("warning","you are not logged in");
		response.sendRedirect("login.jsp");
		return;
	}else{
		if(user.getUserType().equals("normal")){
			session.setAttribute("warning","you are not admin");
			response.sendRedirect("login.jsp");
			return;
		}
	}
%>

<%
	CategoryDao cDao = new CategoryDao(FactoryProvider.getFactory());
	List<Category> list = cDao.getCategories();
	
	Map<String,Long> m = Helper.getCounts(FactoryProvider.getFactory());
%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="ISO-8859-1">
		<title>Admin page</title>
		<%@include file="components/common_css_js.jsp" %>
	</head>
	<body>
		<%@include file="components/navbar.jsp" %>
		<style type="text/css">
		  <%@include file="css/style.css" %>
		</style>
		<div class="container admin">
			<%@include file="components/message.jsp" %>
			<div class="row mt-3">
				<div class="col-md-4">
					<div class="card">
						<div class="card-body text-center">
							<div class="container">
								<img style="max-width:100px" class="img-fluid rounded-circle" src="img/team.png" alt="user_icon"/>
							</div>
							<h1><%= m.get("userCount") %></h1>
							<h1 class="text-uppercase text-muted">users</h1>
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="card">
						<div class="card-body text-center">
							<div class="container">
								<img style="max-width:100px" class="img-fluid rounded-circle" src="img/list.png" alt="user_icon"/>
							</div>
							<h1><%= list.size() %></h1>
							<h1 class="text-uppercase text-muted">categories</h1>
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="card">
						<div class="card-body text-center">
							<div class="container">
								<img style="max-width:100px" class="img-fluid rounded-circle" src="img/product.png" alt="user_icon"/>
							</div>
							<h1><%= m.get("productCount") %></h1>
							<h1 class="text-uppercase text-muted">products</h1>
						</div>
					</div>
				</div>
			</div>
			
			<div class="row mt-3">
				<div class="col-md-6">
					<div class="card" data-toggle="modal" data-target="#categoryModal">
						<div class="card-body text-center">
							<div class="container">
								<img style="max-width:100px" class="img-fluid rounded-circle" src="img/keys.png" alt="user_icon"/>
							</div>
							<p class="mt-2">click here to add new category</p>
							<h1 class="text-uppercase text-muted">add category</h1>
						</div>
					</div>
				</div>
				<div class="col-md-6">
					<div class="card" data-toggle="modal" data-target="#productModal">
						<div class="card-body text-center">
							<div class="container">
								<img style="max-width:100px" class="img-fluid rounded-circle" src="img/plus.png" alt="user_icon"/>
							</div>
							<p class="mt-2">click here to add new product</p>
							<h1 class="text-uppercase text-muted">add product</h1>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<!--	category modal  -->
		
		<!-- Modal -->
		<div class="modal fade" id="categoryModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		  <div class="modal-dialog modal-lg" role="document">
		    <div class="modal-content">
		      <div class="modal-header bg-primary text-white">
		        <h5 class="modal-title" id="exampleModalLabel">Fill Category Details</h5>
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		          <span aria-hidden="true">&times;</span>
		        </button>
		      </div>
		      <div class="modal-body">
		        <form action="ProductServlet" method="post">
		        	<input type="hidden" name="operation" value="category">
		        	<div class="form-group">
					    <input name="cat_title" type="text" class="form-control" placeholder="Enter category title" required>
			  		</div>
			  		<div class="form-group">
						<textarea name="cat_desc" style="height:150px" class="form-control" placeholder="enter category description"></textarea>			  		
					</div>
					<div class="container text-center">
			  			<button class="btn btn-outline-success" type="submit">Add category</button>
			  		</div>
		        </form>
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
		      </div>
		    </div>
		  </div>
		</div>
		<!-- product modal -->
		<div class="modal fade" id="productModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		  <div class="modal-dialog modal-lg" role="document">
		    <div class="modal-content">
		      <div class="modal-header bg-primary text-white">
		        <h5 class="modal-title" id="exampleModalLabel">Fill Product Details</h5>
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		          <span aria-hidden="true">&times;</span>
		        </button>
		      </div>
		      <div class="modal-body">
		        <form action="ProductServlet" method="post" enctype="multipart/form-data">
		        	<input type="hidden" name="operation" value="product">
		        	<div class="form-group">
					    <input name="product_name" type="text" class="form-control" placeholder="Enter product name" required>
			  		</div>
			  		<div class="form-group">
						<textarea name="product_desc" style="height:150px" class="form-control" placeholder="enter product description"></textarea>			  		
					</div>
					<div class="form-group">
					    <input name="product_price" type="number" class="form-control" placeholder="Enter product price" required>
			  		</div>
			  		<div class="form-group">
					    <input name="product_discount" type="number" class="form-control" placeholder="Enter product discount">
			  		</div>
			  		<div class="form-group">
					    <input name="product_quantity" type="number" class="form-control" placeholder="Enter product quantity" required>
			  		</div>
			  		<!-- product category -->
			  		
			  		<div class="form-group">
			  			<select name="catId" class="form-control" id="">
			  				<%
			  					for(Category c:list){
			  				%>
			  				<option value="<%= c.getCategoryId() %>"><%= c.getCategoryName() %></option>
			  				<%
			  					}
			  				%>
			  			</select>
			  		</div>
			  		<div class="form-group">
					    <input name="product_pic" type="file" class="form-control" required>
			  		</div>
					<div class="container text-center">
			  			<button class="btn btn-outline-success" type="submit">Add product</button>
			  		</div>
		        </form>
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
		      </div>
		    </div>
		  </div>
		</div>
		<%@include file="components/cart_modal.jsp" %>
	</body>
</html>