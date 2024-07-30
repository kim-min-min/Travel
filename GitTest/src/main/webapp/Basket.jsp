<%@page import="com.aischool.model.FirstScreenDAO"%>
<%@page import="com.aischool.model.WebMember"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<% WebMember member =  (WebMember) session.getAttribute("logindata");

%>
<!DOCTYPE html>
<html>
<head>
<title>장바구니</title>
<meta charset="UTF-8">
<meta name="viewport" content="initial-scale=1, width=device-width">
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" />
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Inter:wght@400&display=swap" />
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Arial:wght@400&display=swap" />
<link rel="stylesheet" href="design/Basket.css" />
</head>
<body>
<%
	String region = (String)session.getAttribute("region");
	String placeName = (String)session.getAttribute("placeName");
%>
<script type="text/javascript">
	function func()
	{
		<%
		    FirstScreenDAO dao = new FirstScreenDAO();
			int cnt = dao.updateCount(member);
		%>
		location.replace('Schedule.jsp');
	}

</script>
<div class="header">

    <a href="main.jsp"><img class="logo-icon" alt="" src="image/KakaoTalk_20240722_104503600.jpg"></a>
    
    <%if(member == null){%>
        	<div class="log">
          <a class="a1" href="login.jsp">로그인</a>
        </div>
        <%}else{%>
        <div class="trip-planner">
          <span class="navTxt"><a href="Mypage.jsp" style="color:#20303c"><u>마이페이지</u></a></span>
          </div>
        <div class="log">
          <a class="a1" href="logoutService">로그아웃</a>
        </div>
        
        <%} %>
    <div class="header-line"></div>
</div>

<h1>  내가 선택한 여행지</h1>

<div class="body-parent">
    <div class="body">
        <div class="contentbox">
            <div class="title">
                
                <b class="b"><%=region %>, <%=placeName %> 중심</b>
                <img class="vector-icon" alt="" src="image/mark.png"><br>
                <b class="date"></b>
            </div>
            <br>
            <b class="list-title">내가 담은 여행지 목록</b>



            <% 
                request.setCharacterEncoding("UTF-8");
                ArrayList<String> arr = (ArrayList)session.getAttribute("locationList");
                ArrayList<String> latitude = (ArrayList)session.getAttribute("latiList");
                ArrayList<String> longitude = (ArrayList)session.getAttribute("longList");

                // 세션에 ArrayList 등록
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
            %>

            <% for(int i=0 ;i< arr.size(); i++){ %>
                <div class="content">
                    <form action="DeleteList.jsp" method="post">
                        <div class="place-info">
                            <input type="hidden" value="<%=arr.get(i)%>" name="text">
                            
                            <input type="hidden" value="<%=latitude.get(i)%>" name="lati">
                            <input type="hidden" value="<%=longitude.get(i)%>" name="long">
                            <span style="padding-right:10px"><%=arr.get(i)%></span>
                            <input type="submit" value="삭제하기" class="remove-button">
                        </div>
                    </form>
                </div>
            <% } %>
        </div>
        <button class="wrapper1" onclick="func()">일정별 장소 확정하기</button>
        <button onclick="location.href='add.jsp'" class="back-button">장소 더 추가하기</button>
    </div>
</div>





</body>
</html>
