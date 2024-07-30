<%@page import="java.util.ArrayList"%>
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

	request.setCharacterEncoding("UTF-8");
	ArrayList<String> arr = (ArrayList)session.getAttribute("locationList");
	ArrayList<String> latitude = (ArrayList)session.getAttribute("latiList");
	ArrayList<String> longitude = (ArrayList)session.getAttribute("longList");
	
	request.setCharacterEncoding("UTF-8");
	String a = request.getParameter("text");
	String b = request.getParameter("lati");
	String c = request.getParameter("long");

 	arr.remove(String.valueOf(a));
	latitude.remove(String.valueOf(b));
	longitude.remove(String.valueOf(c));
	
%>

<script type="text/javascript">
	alert("삭제 되었습니다.");
	location.href = 'Basket.jsp';
</script>
</body>
</html>