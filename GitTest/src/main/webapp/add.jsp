<%@page import="com.aischool.model.FirstScreenVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.aischool.model.FirstScreenDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  	<meta charset="utf-8">
  	<meta name="viewport" content="initial-scale=1, width=device-width">
  	
  	<link rel="stylesheet"  href="design/add.css" />
  	<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Noto Sans KR:wght@400;700&display=swap" />
  	<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Inter:wght@400&display=swap" />
  	<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Arial:wght@400&display=swap" />
  	
  	
  	
</head>
<body>
<%! 	int pageNum=1; %>

<script type="text/javascript">
	function func2()
	{
		<%pageNum++;%>
		location.replace('add.jsp');
	}

</script> 

<%

	FirstScreenDAO dao = new FirstScreenDAO();
	
	ArrayList<FirstScreenVO> list = dao.list2(pageNum);
	double[] latitude= new double[list.size()];
	double[] longitude= new double[list.size()];
	
	for(int i=0; i<list.size(); i++)
	{	
		latitude[i]= Double.parseDouble(list.get(i).getLatitude());
		longitude[i]= Double.parseDouble(list.get(i).getLongitude());		
	}
		
	
%>

    <div class="header">
        <div class="link-wrapper">

        </div>
        <div class="header-inner">
              <div class="group-parent">
                  
                    <div class="group-item" onclick="window.location.href='Basket.jsp'">
                      <img class="group-child2" alt="" src="image/bucket2.png">
                     <img class="group-child" alt="" src="image/bucket1.png">
                    </div>
                    <div class="link1">
                          <span class="count">7</span>
                    </div>
              </div>
        </div>
        <a class="b14" href="Basket.jsp">내가 담은 여행지</a>
        <a href="main.jsp"><img class="logo-icon" alt="" src="image/KakaoTalk_20240722_104503600.jpg"></a>
        <a class="b15" href="Schedule.jsp">장소 확정하기</a>
        <div class="header-line"></div>
        
        
  </div>

  	<div class="body-parent">
    		<div class="body">
      			<div class="background">
        				<div class="title">
          					<b class="b">부산</b>							<!-- 해당 지역 이름 (부산,여수,양양) 출력 -->
          					<b class="date">2024.08.07~2024.08.08</b>   <!-- 달력에서 선택한 날짜 출력 -->
        				</div>

        				<div class="parent">
          					<b class="b5">거리순 </b>
          					<img class="icon-menu" alt="" src="image/menu.png">
          					
        				</div>
        				<b class="b6">해운대 해수욕장 근처</b>
        				<img class="vector-icon" alt="" src="image/mark.png">
        				
        				<b class="b7">예상시간: 총 시간 분</b>

        				
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
              							<input type="submit" value="<%=list.get(i).getLocationName()%>" name="place"> 
              							<input type="button" onclick="func(<%=latitude[i]%>,<%=longitude[i]%>)" value="위치보기">
              							<div class="div"><%=list.get(i).getTag()%>: <%=list.get(i).getAddress()%></div>

            						</div>
          						</form>
          					</div>
          					
							<% } %> 
        				</div>

        				
      			</div>
                  
      			<div class="map" id="map" style="width:50%;height:400px;">
        				
      			</div>
                
    		</div>
    		<div class="vector-parent">
      			
      			<button onclick="func2()">더 보기</button>
    		</div>
    		<div class="frame-parent">
    			
      			<div class="wrapper1">
        				
      			</div>
      			
      			
    		</div>
    		
    		
    		
  	</div>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=4f01ec291f2bda3241e8f86688fef41c"></script>
<script>
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	mapOption = { 
	    center: new kakao.maps.LatLng(<%=latitude[0]%>, <%=longitude[0]%>), // 지도의 중심좌표
	    level: 9 // 지도의 확대 레벨
	};
	
	var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
	
	
	function func(a,b){
		
		//마커가 표시될 위치입니다 
		var markerPosition  = new kakao.maps.LatLng(a, b); 
		
		//마커를 생성합니다
		var marker = new kakao.maps.Marker({
		position: markerPosition
		});
		
		//마커가 지도 위에 표시되도록 설정합니다
		marker.setMap(map);
	}

	
</script>

 	
  	
  	
  	<script>
    		var text = document.getElementById("text");
    		if(text) {
      			text.addEventListener("click", function (e) {
        				// Add your code here
      			});
    		}</script></body>
</html>