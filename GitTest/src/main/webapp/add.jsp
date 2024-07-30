<%@page import="java.util.List"%>
<%@page import="com.aischool.model.WebMember"%>
<%@page import="com.aischool.model.FirstScreenVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.aischool.model.FirstScreenDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% WebMember member =  (WebMember) session.getAttribute("logindata");
%>
<!DOCTYPE html>
<html>
<head>
     <meta charset="utf-8">
     <meta name="viewport" content="initial-scale=1, width=device-width">
     
     <link rel="stylesheet"  href="design/add.css" />
     <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Noto Sans KR:wght@400;700&display=swap" />
     <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Inter:wght@400&display=swap" />
     <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Arial:wght@400&display=swap" />
     
     <title>일정만들기</title>
     
</head>
<body>
<%!    int pageNum=1; %>

<script type="text/javascript">
   function func2()
   {
      <%pageNum++;%>
      location.replace('add.jsp?pageNum=<%= pageNum %>');
   }

</script> 

<%
   String region = (String)session.getAttribute("region");
   String placeName = (String)session.getAttribute("placeName");

   FirstScreenDAO dao = new FirstScreenDAO();
   
   ArrayList<FirstScreenVO> list = dao.list3(pageNum, region);
   double[] latitude= new double[list.size()];
   double[] longitude= new double[list.size()];
   
   for(int i=0; i<list.size(); i++)
   {   
      latitude[i]= Double.parseDouble(list.get(i).getLatitude());
      longitude[i]= Double.parseDouble(list.get(i).getLongitude());      
   }
   
   ArrayList<FirstScreenVO> list2=dao.place(region, placeName);
   List<String> recommendedPlaces = (List<String>) request.getAttribute("recommendedPlaces");
%>

    <div class="header">
        <div class="link-wrapper">

        </div>
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

	
     <div class="body-parent">
          <div class="body">
               <div class="background">
                    <div class="title">
                         <b id="b" class="b"><%=region%></b>      
                         <b class="date"></b>                              
                    </div>   
                    
                    <div class="parent">
                     <b class="b5">거리순 </b>
                         <img class="icon-menu" alt="" src="image/menu.png">
                    
			  		<%-- 	<form action="placeRecommender" method="get">
				        <input type="hidden" name="latitude" value="<%=Double.parseDouble(list2.get(0).getLatitude())%>"><br>
					    <input type="hidden" name="longitude" value="<%=Double.parseDouble(list2.get(0).getLongitude())%>"><br>
					    <input class="reco" type="submit" value="추천받기" >
					  	</form>
						<%if (recommendedPlaces != null && !recommendedPlaces.isEmpty()) {
							for (String place : recommendedPlaces) {%>
							    <span class=result><%=place %></span>
							    <%}}%> --%>
                    </div>
                     <img class="vector-icon" alt="" src="image/mark.png">
                    <b class="b6"><%=placeName%> 근처 추천 여행지</b>    
							    
         <div class="vector-parent">
               
               <button class="more" onclick="func2()">
               <img src="image/moreBtn.png.png" alt="" style="height:12px;"> 추천 더보기</button>
          </div>
                    
                    <div class="contentbox">
                       <% for(int i=0 ;i< list.size(); i++){ %>
                       <div class="content<%=i+1%>">
                        <form action="AddList.jsp" >
                           <div class="img">
                                 <img src="<%=list.get(i).getImg()%>" width="133" height="85">
                              </div>
                              <div class="place-info">
                                 <input type="hidden" value="<%=list.get(i).getLatitude()%>" name="lati">
                              <input type="hidden" value="<%=list.get(i).getLongitude()%>" name="long">
                                   <b id="mapinfo<%=i%>">[<%=list.get(i).getTag()%>] <%=list.get(i).getLocationName()%> 
                                    
                                    <input id="location" type="button" onclick="func(<%=latitude[i]%>,<%=longitude[i]%>,'<%=list.get(i).getLocationName() %>')" value="위치보기"></b>
                                   <span>주소: <%=list.get(i).getAddress()%></span>
                                   <div class="div"><div class="tag"><input id="plus" type="submit" value="<%=list.get(i).getLocationName()%>" name="place">담기 +</div></div>

                              </div>
                            </form>
                         </div>
                         
                     <% } %> 
                    </div>

                    
               </div>
                  
               <div class="map" id="map" style="width:50%;height:600px;"></div>
               <div id="mapinfo" style="display:none;">Hello World!</div> <!-- 숨겨진 div로 텍스트를 설정 -->
                
          </div>

               <button class="wrapper1">
                 <a class="b15" href="Basket.jsp"> 내가 담은 여행지 확인하기 </a>
               </button>   
     </div>

    
    
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=4f01ec291f2bda3241e8f86688fef41c"></script>
<script>

   var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
   mapOption = { 
       center: new kakao.maps.LatLng(<%=latitude[0]%>, <%=longitude[0]%>), // 지도의 중심좌표
       level: 9 // 지도의 확대 레벨
   };
   
   var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
   
   
   function func(a,b, locationName){
      
      //마커가 표시될 위치입니다 
      var markerPosition  = new kakao.maps.LatLng(a, b); 
      
      //마커를 생성합니다
      var marker = new kakao.maps.Marker({
      position: markerPosition
      });
      
      //마커가 지도 위에 표시되도록 설정합니다
      marker.setMap(map);

        // HTML 요소에서 텍스트를 가져옵니다
        var iwContent = '<div style="padding:3px;">' + locationName + '</div>'; // 인포윈도우에 표시될 내용
        
        // 인포윈도우의 위치를 마커의 위치와 동일하게 설정
        var iwPosition = markerPosition;
        var iwRemoveable = true; // removeable 속성을 true로 설정하면 인포윈도우를 닫을 수 있는 x버튼이 표시됩니다

        // 인포윈도우를 생성하고 지도에 표시합니다
        var infowindow = new kakao.maps.InfoWindow({
            position: iwPosition, 
            content: iwContent,
            removable: iwRemoveable
        });

        // 인포윈도우를 마커에 연결
        infowindow.open(map, marker);
    }
</script>
</body>
</html>