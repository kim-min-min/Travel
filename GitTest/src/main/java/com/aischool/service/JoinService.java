package com.aischool.service;

import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.aischool.model.WebMember;
import com.aischool.model.WebMemberDAO;

@WebServlet("/JoinService")
public class JoinService extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        String email = request.getParameter("email");
        String pw = request.getParameter("pw");
        String name = request.getParameter("name");
        String id = request.getParameter("id");
        
        // 모든 필드가 채워져 있는지 확인
        if (name == null || id == null || email == null || pw == null ||
            name.trim().isEmpty() || id.trim().isEmpty() || email.trim().isEmpty() || pw.trim().isEmpty()) {
            request.setAttribute("errorMsg", "모든 항목을 입력해주세요.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
        
        WebMemberDAO dao = new WebMemberDAO();
        
        // 이메일 중복 재확인
        if (dao.checkEmailExists(email)) {
            request.setAttribute("errorMsg", "이미 존재하는 이메일입니다.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
        
        WebMember member = new WebMember(name, id, email, pw, 0);
        member.setName(name);
        member.setId(id);
        member.setEmail(email);
        member.setPw(pw);
        member.setScheduleCount(0);   //  <-- default 0으로 

        int result = dao.memberJoin(member);  
        
        if (result > 0) {  
            response.sendRedirect("main.jsp?message=" + URLEncoder.encode("회원가입이 완료되었습니다.", "UTF-8"));
        } else {  
            request.setAttribute("errorMsg", "회원가입에 실패했습니다.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }

}