package com.ecommerce.servlets;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.ecommerce.dao.CategoryDao;
import com.ecommerce.dao.ProductDao;
import com.ecommerce.entities.Category;
import com.ecommerce.entities.Product;
import com.ecommerce.helper.FactoryProvider;

@MultipartConfig
public class ProductServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public ProductServlet() {
        super();
        // TODO Auto-generated constructor stub
    }
    
    private String getFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        System.out.println("content-disposition header= "+contentDisp);
        String[] tokens = contentDisp.split(";");
        for (String token : tokens) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf("=") + 2, token.length()-1);
            }
        }
        return "";
    }
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		try {
			String op = request.getParameter("operation");
			
			if(op.trim().equals("category")) {
				String title = request.getParameter("cat_title");
				String description = request.getParameter("cat_desc");
				
				Category category = new Category();
				category.setCategoryName(title);
				category.setCategoryDescription(description);
				
				CategoryDao categoryDao = new CategoryDao(FactoryProvider.getFactory());
				
				int catId = categoryDao.saveCategory(category);
				
				HttpSession session = request.getSession();
				session.setAttribute("message", "category added successfully!!");
				
				response.sendRedirect("admin.jsp");
				return;
			}else if(op.trim().equals("product")){
				String name = request.getParameter("product_name");
				String description = request.getParameter("product_desc");
				int price = Integer.parseInt(request.getParameter("product_price"));
				int discount = Integer.parseInt(request.getParameter("product_discount"));
				int quantity = Integer.parseInt(request.getParameter("product_quantity"));
				int catId = Integer.parseInt(request.getParameter("catId"));
				Part part = request.getPart("product_pic");
				
				Product p = new Product();
				p.setpName(name);
				p.setpDesc(description);
				p.setpPrice(price);
				p.setpDiscount(discount);
				p.setpQuantity(quantity);
				p.setpPic(getFileName(part));
				
				CategoryDao cdao = new CategoryDao(FactoryProvider.getFactory());
				Category category = cdao.getCategoryById(catId);
				
				p.setCategory(category);
				ProductDao pdao = new ProductDao(FactoryProvider.getFactory());
				boolean f = pdao.saveProduct(p);
				
				String path = request.getRealPath("img") + File.separator + "products" + File.separator + getFileName(part);
				System.out.println(path);
				
				FileOutputStream fos = new FileOutputStream(path);
				InputStream is = part.getInputStream();
				
				byte []data = new byte[is.available()];
				is.read(data);
				
				fos.write(data);
				
				fos.close();
				
				if(f == true) {
					HttpSession session = request.getSession();
					session.setAttribute("message", "product added successfully!!");
					response.sendRedirect("admin.jsp");
					return;
				}
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		processRequest(request,response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		processRequest(request,response);
	}

}
