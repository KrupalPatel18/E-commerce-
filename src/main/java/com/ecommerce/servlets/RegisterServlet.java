package com.ecommerce.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.exception.ConstraintViolationException;

import com.ecommerce.entities.User;
import com.ecommerce.helper.FactoryProvider;

public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		try {
			String userName = request.getParameter("user_name");
			String userEmail = request.getParameter("user_email");
			String userPassword = request.getParameter("user_password");
			String userPhone = request.getParameter("user_phone");
			String userAddress = request.getParameter("user_address");
			
			User user = new User(userName, userEmail, userPassword, userPhone, "abc.jpg", userAddress, "normal");
			
			Session session = FactoryProvider.getFactory().openSession();
			Transaction tx = session.beginTransaction();
			int userId = (int)session.save(user);
			tx.commit();
			session.close();
			
			HttpSession httpSession = request.getSession();
			httpSession.setAttribute("message", "registeration successful !! "+userId);
			response.sendRedirect("register.jsp");
			return;
			
		}catch(ConstraintViolationException e) {
			e.printStackTrace();
			HttpSession httpSession = request.getSession();
			httpSession.setAttribute("warning", "Email id already exits");
			response.sendRedirect("register.jsp");
		}
		catch(Exception e) {
			e.printStackTrace();
			HttpSession httpSession = request.getSession();
			httpSession.setAttribute("warning", "registeration unsuccessful");
			response.sendRedirect("register.jsp");
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
