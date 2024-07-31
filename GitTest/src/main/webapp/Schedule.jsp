<%@ page import="com.aischool.model.FirstScreenDAO" %>
<%@ page import="com.aischool.model.WebMember" %>
<%@ page import="java.util.ArrayList" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>일정 짜기</title>
    <link rel="stylesheet" href="design/Schedule.css" />
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" />
 
</head>
<body>
    <div class="header">
        <div class="header-inner">
            <a href="main.jsp"><img class="logo-icon" alt="Logo" src="image/KakaoTalk_20240722_104503600.jpg"></a>
        </div>
        <div class="link-wrapper">
            <div class="trip-planner">
          <span class="navTxt"><a href="Mypage.jsp" style="color:#20303c"><u>마이페이지</u></a></span>
          </div>
        <div class="log">
          <a class="a1" href="logoutService">로그아웃</a>
        </div>
        </div>
        <div class="header-line"></div>
    </div>

    <div class="container">
    	<div class="schedule-container">
            <h1 style="color: #0f5577; margin-bottom:2px;" >일정별 장소 확정하기</h1>
            <h3 style="color: #0f5577">내가 담은 여행지 목록</h3>
            

            <div class="location-list">
                <%
                    WebMember member = (WebMember) session.getAttribute("logindata");
                    FirstScreenDAO dao = new FirstScreenDAO();
                    int Schedule_number = dao.count(member);

                    request.setCharacterEncoding("UTF-8");
                    ArrayList<String> arr = (ArrayList<String>) session.getAttribute("locationList");
                    ArrayList<String> latitude = (ArrayList<String>) session.getAttribute("latiList");
                    ArrayList<String> longitude = (ArrayList<String>) session.getAttribute("longList");
                    ArrayList<String> array = (ArrayList<String>) session.getAttribute("day1List");

                    // 세션에 ArrayList 등록
                    if (arr == null) {
                        arr = new ArrayList<String>();
                        session.setAttribute("locationList", arr);
                    }
                    if (latitude == null) {
                        latitude = new ArrayList<String>();
                        session.setAttribute("latiList", latitude);
                    }
                    if (longitude == null) {
                        longitude = new ArrayList<String>();
                        session.setAttribute("longList", longitude);
                    }
                    if (array == null) {
                        array = new ArrayList<String>();
                        session.setAttribute("day1List", array);
                    }

                    double[] lati1 = new double[arr.size()];
                    double[] long1 = new double[arr.size()];

                    for (int i = 0; i < arr.size(); i++) {
                        lati1[i] = Double.parseDouble(latitude.get(i));
                        long1[i] = Double.parseDouble(longitude.get(i));
                    }

                    for (int i = 0; i < arr.size(); i++) {
                %>
                    <div class="location-item">
                        <span><%= arr.get(i) %></span>
                        <div>
                        	<button id="mapbutton" class="view-location" onclick="func(<%= lati1[i] %>, <%= long1[i] %>, '<%=arr.get(i)%>')">위치보기</button>
                            <form action="Day1.jsp" method="get" style="display: inline;">
                                <button type="submit" class="add-schedule" name="day1" value="<%= arr.get(i) %>">일정 추가</button>
                            </form>
                        </div>
                    </div>
                <% } %>
            </div>

            <div class="current-schedule">
                <h3 style="margin-bottom:3px;">  현재 일정 코스보기</h3>
                <%
                    String day1 = "";
                    for (int i = 0; i < array.size(); i++) {
                    	if (i==array.size()-1){
                    		day1 += array.get(i);
                    	}else{
                    		day1 += array.get(i) + " ➡ ";
                    	}                   
                    }
                %>
                <p id="day"><% if (day1==""){
                	out.print("일정을 추가해주세요.");
                	}else out.print(day1);%>
                </p>
            </div>

            <div class="schedule-form">
                       
                <form action="AddSchedule.jsp" method="get">
                     <select name="date">
                        <option value="1">1일차</option>
                        <option value="2">2일차</option>
                        <option value="3">3일차</option>
                    </select>
                    <input type="hidden" name="scheduleNumber" value="<%= Schedule_number %>">
                    <input type="hidden" name="scheduleList" value="<%= day1 %>">
                    <button type="submit" class="save-schedule">일정 저장하기</button>
                    <button class="save-schedule" onclick="clearRoute()">초기화</button>

                </form>
                
            </div>
        </div>
        
        <div class="map-container">
        	<div id="mapinfo" style="display:none;">Hello World!</div> <!-- 숨겨진 div로 텍스트를 설정 -->
            <div id="map"></div>
             <div id="distance-info" style="diplay:block">거리 정보가 여기에 표시됩니다.</div> <!-- 직선 거리와 예상 시간 표시 -->
              
        </div>

        
    </div>

    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=4f01ec291f2bda3241e8f86688fef41c"></script>
    <script>
    
    	
        var mapContainer = document.getElementById('map'),
            mapOption = {
                center: new kakao.maps.LatLng(<%= lati1[0] %>, <%= long1[0] %>),
                level: 5
            };

        var map = new kakao.maps.Map(mapContainer, mapOption);

        var positions = []; // 마커 위치 정보를 저장할 배열
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
              var iwContent = '<div style="padding:3px; font-size:14px;">'+locationName+'</div>'; // 인포윈도우에 표시될 내용
              
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
              
              positions.push({lat:a, lng:b});
              
              // 경로를 업데이트
              drawRoute();

          }
        
        function drawRoute() {
            if (positions.length < 2) return; // 두 개 이상의 점이 있어야 경로를 그릴 수 있습니다

            // 경로를 그리기 위한 Polyline 생성
            var path = positions.map(pos => new kakao.maps.LatLng(pos.lat, pos.lng));
            var polyline = new kakao.maps.Polyline({
                path: path,
                strokeWeight: 4, // 선 두께
                strokeColor: '#ff680899', // 선 색깔
                strokeOpacity: 1, // 선 투명도
                strokeStyle: 'solid' // 선 스타일
            });

            // 지도에 Polyline을 추가합니다
            polyline.setMap(map);

            // 지도 중심을 경로에 맞춰 조정합니다
            var bounds = new kakao.maps.LatLngBounds();
            for (var i = 0; i < path.length; i++) {
                bounds.extend(path[i]);
            }
            map.setBounds(bounds);
           
            // 거리와 예상 시간 계산
            var distance = polyline.getLength();
    	    var distance1 = Math.round(distance)/1000
       	    var averageSpeed = 4; // 평균 보행 속도 (단위: km/h)
            var travelTimeHours = distance1 / averageSpeed;
            var travelTimeMinutes = Math.round(travelTimeHours * 60);
    	    
    	    var message = "총 거리: "+ distance1 + "km <br> 예상 총 도보 시간: " + (travelTimeMinutes % 60) + ' 분';
;


    		var distanceInfo = document.getElementById('distance-info');
    	    distanceInfo.innerHTML = message;


        }
 
        function clearRoute() {
            positions = [];
            drawRoute();
            document.getElementById('day').innerText = "일정을 추가해주세요";
            return false;
        }
    </script>
</body>
</html>