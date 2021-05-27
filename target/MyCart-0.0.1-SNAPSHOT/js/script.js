function add_to_cart(pid,pname,price){
	let cart = localStorage.getItem("cart");
	if(cart == null){
		let products = [];
		let product = {productId:pid,productName:pname,productQuantity:1,productPrice:price};
		products.push(product);
		localStorage.setItem("cart",JSON.stringify(products));
	}else{
		let pcart = JSON.parse(cart);
		let oldProduct = pcart.find((item) => item.productId == pid);
		if(oldProduct){
			pcart.map((item) => {
				if(item.productId == oldProduct.productId){
					item.productQuantity = oldProduct.productQuantity+1;
				}
			})
			localStorage.setItem("cart",JSON.stringify(pcart));
			
		}else{
			let product = {productId:pid,productName:pname,productQuantity:1,productPrice:price};
			pcart.push(product);
			localStorage.setItem("cart",JSON.stringify(pcart));
		}
	}
	updateCart();
}

/*update cart*/

function updateCart(){
	let cartString = localStorage.getItem("cart");
	let cart = JSON.parse(cartString);
	if(cart == null || cart.length == 0){
		console.log("cart is empty");
		$(".cart-item-count").html("(0)");
		$(".cart-body").html("<h3>Cart is empty</h3>");
		$(".checkout").addClass("disabled");
	}else{
		console.log(cart);
		$(".cart-item-count").html(`(${cart.length})`);
		let table = `
		  <table class="table" style="overflow-x:scroll">
			<thead class="thead-light">
				<tr>
					<th>Item name</th>
					<th>Item price</th>
					<th>Item quentity</th>
					<th>Total Price</th>
					<th>Action</th>
				</tr>
			</thead>
		`;
		
		let totalPrice = 0;
		cart.map((item) => {
			table+=`
			<tr>
				<td>${item.productName}</td>
				<td>${item.productPrice}</td>
				<td>${item.productQuantity}</td>
				<td>${item.productQuantity*item.productPrice}</td>
				<td><button class="btn-danger btn-sm" onclick="deleteItemFromCart(${item.productId})">Remove</button></td>
			</tr>
			`
			totalPrice += item.productQuantity*item.productPrice;
		})
		
		table = table + `
			<tr><td colspan="5" class="text-right font-weight-bold">Total Price : ${totalPrice}</td></tr>
		</table>`;
		
		
		$(".cart-body").html(table);
	}
}

function deleteItemFromCart(pid){
	console.log("removing");
	let cart = JSON.parse(localStorage.getItem("cart"));
	
	let newCart = cart.filter((item) => item.productId!=pid);
	
	localStorage.setItem("cart",JSON.stringify(newCart));
	updateCart();
}


$(document).ready(function(){
	updateCart();
})
