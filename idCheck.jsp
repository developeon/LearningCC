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
		String id = request.getParameter("id");

		String filePath = application.getRealPath("/WEB-INF/member.txt");
		BufferedReader reader = null;
		String str;
		String tmpArray[];
		String isOverlap = "no";

		try {
			reader = new BufferedReader(new FileReader(filePath));
			while ((str = reader.readLine()) != null) {
				tmpArray = str.split("\\|");
				if (tmpArray[0].equals(id)) {
					isOverlap = "yes";
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		if (isOverlap.equals("yes")) {
	%>
	이미 존재하는 아이디입니다.
	<button type="button" class="btn" onClick="isOverlapTrue()">Close</button>
	<%
		} else {
	%>
	사용 가능한 아이디입니다.
	<button type="button" class="btn" onClick="isOverlapFalse()">Close</button>

	<%
		}
	%>



	<script>
		function isOverlapTrue() {
			opener.document.getElementById("userID").value = "";
			opener.document.getElementById("isOverlap").value = "";
			self.close();
		}

		function isOverlapFalse() {
			opener.document.getElementById("isOverlap").value = "pass";
			self.close();
		}
	</script>
</body>
</html>