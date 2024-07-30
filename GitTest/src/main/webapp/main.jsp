<%@page import="com.aischool.model.WebMember"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
WebMember member = (WebMember) session.getAttribute("logindata");
String errorMsg = (String) request.getAttribute("errorMsg");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport" content="initial-scale=1, width=device-width" />

<link rel="stylesheet" href="design/main-global.css" />
<link rel="stylesheet" href="design/main.css" />
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css2?family=Abel:wght@400&display=swap" />
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css2?family=Inter:wght@400;700&display=swap" />
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css2?family=Times New Roman:ital,wght@1,400&display=swap" />
<title>Main page</title>
<script>
	function goToSelect() {
		let selectedRegion = 'BUSAN'; // 기본값
		  if (document.getElementById("item1").style.border.includes("solid")) {
		    selectedRegion = 'YangYang';
		  } else if (document.getElementById("item2").style.border.includes("solid")) {
		    selectedRegion = 'BUSAN';
		  } else if (document.getElementById("item3").style.border.includes("solid")) {
		    selectedRegion = 'YEOSU';
		  }
		  window.location.href = 'select.jsp?region=' + selectedRegion;
		}
	
	  var startDate = document.getElementById("start").value;
      var endDate = document.getElementById("end").value;
      if (startDate && endDate) {
          document.getElementById("dateForm").submit();
      }
</script>
</head>



<body>
	<script>
		function select1() {
			let item1 = document.getElementById("item1");
			item1.style.border = "3.5px var(--color-cadetblue-100) solid";
			console.log("Yanyang");
			item2.style.border = "white"
			item3.style.border = "white"
		}

		function select2() {
			let item2 = document.getElementById("item2");
			item2.style.border = "3.5px var(--color-cadetblue-100) solid";
			console.log("Busan");
			item1.style.border = "white"
			item3.style.border = "white"
		}

		function select3() {
			let item3 = document.getElementById("item3");
			item3.style.border = "3.5px var(--color-cadetblue-100) solid";
			console.log("Yeosu");
			item1.style.border = "white"
			item2.style.border = "white"
		}
	</script>
	<div class="root">
		<header class="header">
			<div class="trip-planner">
				<span class="navTxt"><a href="#plan" style="color: #20303c"><u>여행
							일정 만들기</u></a></span>
			</div>
			<div class="div"></div>
			<%
			if (member == null) {
			%>
			<div class="link">
				<a class="a1" href="login.jsp">로그인</a>
			</div>
			<%
			} else {
			%>
			<div class="trip-planner">
				<span class="navTxt"><a href="Mypage.jsp"
					style="color: #20303c"><u>마이 페이지</u></a></span>
			</div>
			<div class="link">
				<a class="a1" href="logoutService">로그아웃</a>
			</div>

			<%
			}
			%>
			<a href="main.jsp"><img
				class="kakaotalk-20240722-104503600-2-icon" loading="lazy" alt="로고"
				src="image/KakaoTalk_20240722_104503600.jpg" /></a>
		</header>

		<section class="left-sidebar">
			<div class="main-img1-parent">
				<img class="main-img1-icon" loading="lazy" alt=""
					src="image/main_img1.jpg" />


				<div class="sea-image-caption">
					<h1 class="travel-on-foot-container">
						<p class="travel-on-foot">Travel on foot</p>
						<p class="p">걸어서 바다 속으로</p>
					</h1>
					<div class="image-sub-caption">
						<b class="b">쉽고 편하게 펼쳐보는 국내 바다 여행</b>
					</div>
				</div>
			</div>
		</section>
		<section class="main-content-parent">
			<div class="main-content">
				<div id="plan" class="travel-plan-parent">
					<h1 class="travel-plan">Travel Plan</h1>
					<div class="div1">떠나고 싶은 여행 날짜와 지역을 선택하세요</div>
				</div>
			</div>
			<div class="main">
				<img class="main-img2-icon" alt="" src="image/main_img2.jpg" />

				<div class="search-input">
					<div class="shadow"></div>

					<div class="date-inputs">
						<div class="date-labels">
							<i class="travel-date">Travel Date</i>
						</div>
						<div class="date-bar">
							<div class="date-buttons">
								<i class="startdate">Travel Start Date</i>
								<form id="dateForm" action="saveDate">
								<div class="date-box">
									<img class="button-date-icon" alt="달력" src="image/Vector.png" />
									<input
										type="date" class="date-input" name="start">
								</div>
								</form>
							</div>
							<div class="date-buttons1">
								<i class="enddate">Travel End Date</i>
								<form id="dateForm" action="saveDate">
								<div class="date-box">
									<img class="button-date-icon" alt="달력" src="image/Vector.png" />
									<input
										type="date" class="date-input" name="end">	
								</div>
								</form>
								
							</div>
						</div>
					</div>
					
					<div class="destination-selection">
						<div class="destination-label">
							<i class="destination">Travel Destination</i>
						</div>
						<div class="items">
							<button onclick="select1()">
								<div id=item1 class="item1">
									<div class="yangyang">
										<b class="yangyang1">YangYang</b> <img
											class="icon yangyang-icon" loading="lazy" alt="양양바다"
											src="image/yangyang.png" />
									</div>
								</div>
							</button>
							<button onclick="select2()">
								<div id="item2" class="item2">
									<div class="busan">
										<b class="busan1">Busan</b> <img class="icon busan-icon"
											loading="lazy" alt="부산바다" src="image/busan.png" />
									</div>
								</div>
							</button>
							<button onclick="select3()">
								<div id="item3" class="item3">
									<div class="yeosu">
										<b class="yeosu1">Yeosu</b> <img class="icon yeosu-icon"
											loading="lazy" alt="여수바다" src="image/yeosu.png" />
									</div>
								</div>
							</button>
						</div>
					</div>
				</div>
				<button class="button-generate" onclick="goToSelect()">
					<i class="generate">Generate</i>
				</button>
			</div>
		</section>
		<section class="footer2"></section>
	</div>


<script>


</script>
</body>
</html>