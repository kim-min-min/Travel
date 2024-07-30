<%@page import="com.aischool.model.WebMember"%>
<%@page import="com.aischool.model.FirstScreenDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%	
		WebMember member =  (WebMember) session.getAttribute("logindata");
		FirstScreenDAO dao = new FirstScreenDAO();
		int cnt = dao.updateCount(member);		
%>
<script>
		location.replace('Schedule.jsp');
</script>
</body>
</html>