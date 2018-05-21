<%@page import="java.io.FileWriter"%>
<%@page import="java.io.BufferedWriter"%>
<%@page import="java.io.FileReader"%>
<%@page import="java.io.BufferedReader"%>
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
		request.setCharacterEncoding("UTF-8");

		String level = request.getParameter("level");
		String pk = request.getParameter("pk");
		
		String filePath  = application.getRealPath("/WEB-INF/level" + level + ".txt");
		String str;

		BufferedReader reader = null;
		String writeText = "";
		String tmpArray[];

		//선택한 급수에 따라 알맞은 파일 읽어오기
		try {
			reader = new BufferedReader(new FileReader(filePath));
			while ((str = reader.readLine()) != null) {
				tmpArray = str.split("\\|");
				if (!(tmpArray[0].equals(pk))) {
				
					writeText += str + System.lineSeparator();
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		
		BufferedWriter writer = null;
		
		try {
			writer = new BufferedWriter(new FileWriter(filePath, false));
			writer.write(writeText);
		} catch (Exception e) {
			out.print("오류 발생");
		} finally {
			writer.close();
		}
		
		String isEnd = "yes";
		
		if(isEnd.equals("yes")){
			%>
			<script>
			  location.href = "removeCCProc.jsp?level=" + <%= level %>;
			</script>
			<% 
		}
	%>
	
</body>
</html>