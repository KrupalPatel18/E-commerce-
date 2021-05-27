<%@page import="java.io.File"%>
<%@page import="com.ecommerce.helper.Helper"%>
<%@page import="com.ecommerce.entities.Category"%>
<%@page import="com.ecommerce.dao.CategoryDao"%>
<%@page import="com.ecommerce.entities.Product"%>
<%@page import="java.util.List"%>
<%@page import="com.ecommerce.dao.ProductDao"%>
<%@page import="com.ecommerce.helper.FactoryProvider"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="ISO-8859-1">
		<title>MyCart</title>
		<%@include file="components/common_css_js.jsp" %>
		<style type="text/css">
		  <%@include file="css/style.css" %>
		</style>
	</head>
	<body>
		<%@include file="components/navbar.jsp" %>
		<div class="container-fluid">
			<div class="row mt-3">
			<%
				String cat = request.getParameter("category");
				ProductDao pdao = new ProductDao(FactoryProvider.getFactory());
				List<Product> list = null;
				int cid=0;
				if(cat == null){
					list = pdao.getProducts();
				}else{
					cid = Integer.parseInt(cat.trim());
					list = pdao.getProductsByCatId(cid);
				}
				CategoryDao cdao = new CategoryDao(FactoryProvider.getFactory());
				List<Category> clist = cdao.getCategories();
			%>
			<div class="col-md-2">
				
				<div class="list-group">
				  <a href="index.jsp" class="list-group-item list-group-item-action <%= cat!=null?"":"active" %>">
				    All Products
				  </a>
				
					<%
						for(Category category : clist){		
							%>
								<a href="index.jsp?category=<%= category.getCategoryId() %>" class="list-group-item list-group-item-action <%= cid==category.getCategoryId()?"active":"" %>"><%= category.getCategoryName() %></a>	
							<%
						}
					%>
				</div>
			</div>
			<div class="col-md-10"> 
				<div class="row">
					<div class="col-md-12">
						<div class="card-columns">
							<%
								for(Product product : list){
									%>
										<div class="card product-card">
											<div class="container p-2">
												<img class="card-img-top" style="object-fit:contain;max-height:250px" alt="" src="img/products/<%= product.getpPic() %>">	
											</div>
											<div class="card-body">
												<h5 class="card-title text-center"><%= product.getpName() %></h5>
												<p class="card-text">
													<%= Helper.get10Words(product.getpDesc()) %>
												</p>
											</div>
											<div class="card-footer text-center">
												<button class="btn btn-primary" onclick="add_to_cart(<%= product.getpId() %>,'<%= product.getpName() %>',<%= product.getSalingPrice() %>)">Add to Cart</button>
												<button class="btn btn-outline-success">&#8377; <%= product.getSalingPrice() %> <span class="text-secondary discount-label"><%= product.getpDiscount() %>% off</span></button>
											</div>
										</div>
									<%
								}
							%>
						</div>
					</div>
				</div>
			</div>
		</div>
		</div>
		
		<%@include file="components/cart_modal.jsp" %>
	</body>
</html>