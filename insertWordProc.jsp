<%@page import="java.io.FileReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.FileWriter"%>
<%@page import="java.io.BufferedWriter"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
		<%
		String strReferer = request.getHeader("referer");

		if (strReferer == null) {
	%>
	<script language="javascript">
		alert("URL 주소창에 주소를 직접 입력해서 접근하셨습니다.\n\n정상적인 경로를 통해 다시 접근해 주십시오.");
		document.location.href = "index.jsp";
	</script>
	<%
		return;
		}
		
		request.setCharacterEncoding("UTF-8");

		String userID = (String) session.getAttribute("userID");
		String mode = request.getParameter("mode");
		String level = request.getParameter("level");
		String cc = "";
		String meaning = "";
		String filePath;
		if(mode == null){
		String pk = request.getParameter("pk");
		//알맞은 데이터 읽어오기
		BufferedReader reader = null;
		filePath = application.getRealPath("/WEB-INF/level" + level + ".txt");
		String str;
		String tmpArray[];

		try {
			reader = new BufferedReader(new FileReader(filePath));
			while ((str = reader.readLine()) != null) {
				tmpArray = str.split("\\|");
				if (tmpArray[0].equals(pk)) {
					cc = tmpArray[1];
					meaning = tmpArray[2];
					break;
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		}//학습 중 추가
		
		else{
			cc = request.getParameter("cc");
			meaning = request.getParameter("meaning");
		}

		//단어장에 쓰기
		BufferedWriter writer = null;
		try {
			filePath = application.getRealPath("/WEB-INF/" + userID + ".txt");
			writer = new BufferedWriter(new FileWriter(filePath, true));
			writer.write(level + "급|" +  cc + "|" + meaning + System.lineSeparator());
		} catch (Exception e) {
			out.print("오류 발생");
		} finally {
			writer.close();
		}

	if(mode==null){ 	%>
	단어장에 추가되었습니다.
	<input type="button" value="close" onClick="closePopUp()">
	<%}
	else{
	%>
	<!-- 추가되었다는 popup 띄우기 -->
	 
	<jsp:forward page="myPage.jsp"></jsp:forward>
	<%} %>
	<script>
		function closePopUp() {
			self.close();
		}
	</script>
</body>

</html>