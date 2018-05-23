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
		String level = request.getParameter("level");
		String pk = request.getParameter("pk");
		
		/* System.out.println(level);
		System.out.println(pk); */
		String filePath = "";
		BufferedReader reader = null;
		String str;
		
		filePath = application.getRealPath("/WEB-INF/level" + level + ".txt");
		String tmpArray[];
		String removeCC = "";

		try {
			reader = new BufferedReader(new FileReader(filePath));
			while ((str = reader.readLine()) != null) {
				tmpArray = str.split("\\|");
				if (tmpArray[0].equals(pk)) {
					removeCC = tmpArray[1];
					break;
				}
				
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		//회원.txt에서 removeCC뺴고 tmpText에 저장해놓고 다시쓰기 
		filePath = application.getRealPath("/WEB-INF/" + userID + ".txt");	
		String tmpText = "";
		try {
			reader = new BufferedReader(new FileReader(filePath));
			while ((str = reader.readLine()) != null) {
				tmpArray = str.split("\\|");
				if (!removeCC.equals(tmpArray[1])) {
					tmpText += str + System.lineSeparator();
				}
				
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		BufferedWriter writer = null;
		try {
			filePath = application.getRealPath("/WEB-INF/" + userID + ".txt");
			writer = new BufferedWriter(new FileWriter(filePath, false));
			writer.write(tmpText);
		} catch (Exception e) {
			out.print("오류 발생");
		} finally {
			writer.close();
		}
		
		
	%>
	
	단어장에서 삭제되었습니다..
	<input type="button" value="close" onClick="closePopUp()">
	
	<script>
		function closePopUp() {
			self.close();
		}
	</script>
</body>
</html>