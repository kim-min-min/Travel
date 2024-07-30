
<%@page import="com.aischool.model.FirstScreenVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.aischool.model.FirstScreenDAO"%>
<%@page import="com.aischool.model.WebMember"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%

WebMember member = (WebMember) session.getAttribute("logindata");
String errorMsg = (String) request.getAttribute("errorMsg");

FirstScreenDAO dao = new FirstScreenDAO();
ArrayList<FirstScreenVO> list = dao.list(member,0);
int Schedule_number = dao.count(member);

%>



<meta name="viewport" content="initial-scale=1, width=device-width">

<link rel="stylesheet" href="design/mypage.css" />
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css2?family=Inter:wght@500;700&display=swap" />
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css2?family=Raleway:wght@400&display=swap" />
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css2?family=Font Awesome 5 Free:wght@400&display=swap" />
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css2?family=Arial:wght@400&display=swap" />
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css2?family=Noto Sans KR:wght@400&display=swap" />

<link rel="stylesheet" href="design/modalpopup.css" />

<script>
	function showDeletePopup() {
		document.getElementById('deleteModal').style.display = 'block';
	}

	function closePopup() {
		document.getElementById('deleteModal').style.display = 'none';
	}

	function deleteAccount(event) {
		event.preventDefault();
		const form = document.getElementById('deleteForm');			//모달팝업(deleteform)을 가져와서 변수선언한다
		form.submit();												//폼에 데이터를 전송한다.
	}		

	window.onclick = function(event) {								//window객체의 클릭했을때 이벤트를 설정하는 변수
		const modal = document.getElementById('deleteModal');		//deletemodel을 가져와서 변수 modal에 저장
		if (event.target == modal) {								//클릭된 요소가 modal요소와 동일 한지 확인
			modal.style.display = "none";							//if조건이 참일 경우 modal의 속성을 none으로 설정하여 안보이게함
		}															//정리하자면 모달팝업에서 확인/취소 누르면 모달팝업 사라지게하는 함수
	}
</script>

</head>
<body>
	<div class="frame5">
		<div class="header">
			<div class="nav">
				<div class="div7">
					<a href="main.jsp#plan" style="color: #20303c">여행 일정 만들기</a>
				</div>
				<div class="link">
					<div class="wrapper">
						<div class="div8">
							<a href="main.jsp">로그아웃</a>
						</div>
					</div>
				</div>
			</div>
			<div>
				<a href="main.jsp"><img class="logo" alt="로고"
					src="image/KakaoTalk_20240722_104503600.jpg"></a>
			</div>
		</div>
		<div class="frame5-child"></div>
		<div class="plan-content">
			<div class="div">
				<b class="b">나의 일정</b>
			</div>
			<div class="content-box">
				<% for(int j=1 ;j<=Schedule_number; j++){ 
				
					list = dao.list(member, j);
				%>
				
				<div class="item" id="item<%=j%>">
					<b class="plan-title"><%=j %>번째 여행 일정</b>
					<img class="jpg-icon" alt="" src="image/해운대.jfif"> 		
					<img class="image-icon" alt="" src="image/marker.svg.svg">
					<div class="button">
					<% for(int i=0 ;i<list.size(); i++){ %>
						<span style="padding:10px;"><%=list.get(i).getDateIndex()%>일차: <%=list.get(i).getTravelList()%></span>
					<% } %> 	
					</div>
					<button class="delete" onclick="">일정삭제</button>
				</div>
				
				<% } %> 	

			</div>
		</div>

		<div class="sidebar">
			<div class="side-title">
				<div class="div3">마이페이지</div>
			</div>
			<div class="sidemenu">
				<div class="div4">
					<button class="menu bucket"
						onclick="window.location.href='Mypage.jsp'">나의 여행 일정</button>
				</div>

				<div class="div4">
					<button class="menu correct"
						onclick="window.location.href='modify.jsp'">개인정보수정</button>
				</div>

				<div class="div4">
					<button class="out menu" onclick="showDeletePopup()">회원탈퇴</button>
				</div>

			</div>
		</div>

		<img class="main-img1-icon" alt="" src="image/main_img1.jpg"> 
		<b class="nickname"><%=member.getId()%>님의 여행 기록</b> <img
			class="shoe-print-icon" alt="" src="image/shoe-print.png">
	</div>


	<div id="deleteModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closePopup()">&times;</span>
        <form id="deleteForm" action="deleteService" method="post" onsubmit="return deleteAccount(event)">
            <p>정말 탈퇴하시겠습니까?  (현재 아이디: <span id="userId"><%=member.getEmail()%>)</span></p>
            <p>비밀번호 확인 : <input type="password" id="password" name="pw" placeholder="비밀번호를 입력해주세요"></p>
            <p class="error" style="display: none;" align="center"><%= errorMsg != null ? errorMsg : "" %></p>
            <button type="submit">확인</button>
            <button type="button" onclick="closePopup()">취소</button>
        </form>
   		 </div>
	</div>

</body>
</html>
