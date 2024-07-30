<%@ page import="com.aischool.model.FirstScreenDAO" %>
<%@ page import="com.aischool.model.WebMember" %>
<%@ page import="java.util.ArrayList" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>일정 저장</title>
</head>
<body>

<%
    request.setCharacterEncoding("UTF-8");
    
    ArrayList<String> arr = (ArrayList)session.getAttribute("day1List");
    int date = Integer.parseInt(request.getParameter("date"));
    int scheduleNumber = Integer.parseInt(request.getParameter("scheduleNumber"));
    String list = request.getParameter("scheduleList");
    
    WebMember member = (WebMember) session.getAttribute("logindata");
    FirstScreenDAO dao = new FirstScreenDAO();

    boolean isDuplicate = dao.duplicateSchedule(member, list);
    if (isDuplicate) {
%>
        <script type="text/javascript">
            alert("중복된 일정입니다.");
            location.replace('Schedule.jsp');
        </script>
<%
    } else {
        int cnt = dao.update(member, list, date, scheduleNumber);
        arr.clear();
%>
        <script type="text/javascript">
            alert("<%=date%>일차 저장 완료");
            location.replace('Schedule.jsp');
        </script>
<%
    }
%>

</body>
</html>
