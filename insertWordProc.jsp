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
단어장에 추가되었습니다.
<input type ="button" value ="close" onClick = "closePopUp()">
	<%
	
		request.setCharacterEncoding("UTF-8");
	    String level = request.getParameter("level");
		String type = request.getParameter("type");
		String pk = request.getParameter("pk");
		String userID = (String)session.getAttribute("userID");
		
		System.out.println(level);
		System.out.println(type);
		System.out.println(pk);
		System.out.println(userID);
		/*
		BufferedWriter writer = null;
		try {
			String filePath = application.getRealPath("/WEB-INF/" + userID +".txt");
			/* System.out.println(filePath); 
			writer = new BufferedWriter(new FileWriter(filePath, true));
			writer.write(type + "|" + pk + "|" +  System.lineSeparator());
		} catch (Exception e) {
			out.print("오류 발생");
		} finally {
			writer.close();
		}*/
	%>
	<script>
	function closePopUp(){

		self.close();
	}
	</script>
</body>

</html>