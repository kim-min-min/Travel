package com.aischool.service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class saveDate
 */
@WebServlet("/saveDate")
public class saveDate extends HttpServlet {
	private static final long serialVersionUID = 1L;


	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	       String start = request.getParameter("start");
	        String end = request.getParameter("end");

	        HttpSession session = request.getSession();
	        session.setAttribute("start", start);
	        session.setAttribute("end", end);

	        // 다른 페이지로 리다이렉트 할 수 있습니다.
	        response.sendRedirect("add.jsp");
	}

}
