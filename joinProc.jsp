<%@page import="java.io.FileWriter"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.io.BufferedWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="refresh" content="3; url=index.jsp">
<title>회원가입 처리</title>

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
	%>
	<%
		request.setCharacterEncoding("UTF-8");
		String userID = request.getParameter("userID");
		String userPassword = request.getParameter("userPassword");

		BufferedWriter writer = null;
		try {
			String filePath = application.getRealPath("/WEB-INF/member.txt");
			/* System.out.println(filePath); */
			writer = new BufferedWriter(new FileWriter(filePath, true));
			writer.write(userID + "|" + userPassword + "|9" +  System.lineSeparator());
		} catch (Exception e) {
			out.print("오류 발생");
		} finally {
			writer.close();
		}
		out.println("<script>alert('가입을 환영합니다.');</script>");
	%>
	<jsp:forward page="login.jsp"></jsp:forward>
</body>
</html>