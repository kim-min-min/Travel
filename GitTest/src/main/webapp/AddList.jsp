<%@ page import="java.util.*"%>
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

	
	//세션에 ArrayList 등록
	if(arr == null){
		arr = new ArrayList<String>();
		session.setAttribute("locationList", arr);
	}
	if(latitude == null){
		latitude = new ArrayList<String>();
		session.setAttribute("latiList", latitude);
	}
	if(longitude == null){
		longitude = new ArrayList<String>();
		session.setAttribute("longList", longitude);
	}

		
	
	
	String locations= request.getParameter("place");
	String latiString= request.getParameter("lati");
	String longString= request.getParameter("long");
	arr.add(locations);
	latitude.add(latiString);
	longitude.add(longString);



%>

<script type="text/javascript">
	alert("<%=locations%>(이)가 장바구니에 추가 되었습니다.");
	history.go(-1);
</script>



</body>
</html>