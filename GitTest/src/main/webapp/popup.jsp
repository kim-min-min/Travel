
<%@page import="com.select.place_info"%>
<%@page import="com.select.placeDAO"%>
<%@ page import="java.util.ArrayList" %>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%

String placeName = request.getParameter("placeName");
String region = request.getParameter("region");


// 디버깅을 위해 파라미터 값을 로그로 출력
System.out.println("Received placeName: " + placeName);
System.out.println("Received region: " + region);

placeDAO dao = new placeDAO();
ArrayList<place_info> pl_info = dao.Popup_Info(region);
place_info selectedPlace = null;
if (pl_info != null) {
    for (place_info place : pl_info) {
        if (place.getPlace_Name().equals(placeName)) {
            selectedPlace = place;
            break;
        }
    }
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="initial-scale=1, width=device-width">
<title>장소 정보</title>
<link rel="stylesheet" href="design/popup.css" />
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500&display=swap" />
<script type="text/javascript">
    function selectPlace() {   	
    	<%
    		session.setAttribute("region", region);
    		session.setAttribute("placeName", placeName);  
    	%>

        if (window.opener) {
            window.opener.location.href = 'add.jsp';
            window.close();
        }
    }
</script>
</head>
<body>
    <div class="popup-container">
        <% if (selectedPlace != null) { %>
            <h2><%=selectedPlace.getPlace_Name()%></h2>
            <img src="<%=selectedPlace.getPlace_Img()%>" alt="<%=selectedPlace.getPlace_Name()%>" class="popup-img">
            <div class="info-section">
                <h3>장소 상세</h3>
                <table class="info-table">
                    <tr>
                        <th>주소</th>
                        <td><%=selectedPlace.getPlace_Address()%></td>
                    </tr>
                    <tr>
                        <th>장소 소개</th>
                        <td><%=selectedPlace.getPlace_Comment()%></td>
                    </tr>
                    <tr>
                        <th>연락처</th>
                        <td><%=selectedPlace.getPlace_Contact()%></td>
                    </tr>
                </table>
            </div>
        <% } else { %>
            <p>장소 정보를 불러올 수 없습니다.</p>
        <% } %>
        <div class="buttons-container">
            <button class="button" onclick="window.close()">더둘러보기</button>
            <button class="button" onclick="selectPlace()">선택하기</button>
        </div>
    </div>
</body>
</html>
