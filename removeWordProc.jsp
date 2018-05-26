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
		String mode = request.getParameter("mode");
		String level = request.getParameter("level");
		String pk = request.getParameter("pk");

		String filePath;
		BufferedReader reader = null;
		String str;

		String tmpArray[];
		String tmpText = "";

		if (mode == null) { //result와 learngCC에서 추가
			System.out.println("들어옴");
			String cc = "";
			String meaning = "";
			try {
				filePath = application.getRealPath("/WEB-INF/level" + level + ".txt");
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
			} finally {
				reader.close();
			}
			filePath = application.getRealPath("/WEB-INF/" + userID + ".txt");
			try {
				reader = new BufferedReader(new FileReader(filePath));
				while ((str = reader.readLine()) != null) {
					tmpArray = str.split("\\|");
					if (tmpArray[1].equals(level+"급") &&tmpArray[2].equals(cc) && tmpArray[3].equals(meaning)) {
						continue;
					}
					tmpText += tmpArray[0] + "|" + tmpArray[1] + "|" + tmpArray[2] + "|" + tmpArray[3]
							+ System.lineSeparator();

				}

			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				reader.close();
			}
		} else { //myPage에서 삭제

			filePath = application.getRealPath("/WEB-INF/" + userID + ".txt");
			try {
				reader = new BufferedReader(new FileReader(filePath));
				while ((str = reader.readLine()) != null) {
					tmpArray = str.split("\\|");
					if (tmpArray[0].equals(pk)) {
						continue;
					}
					tmpText += tmpArray[0] + "|" + tmpArray[1] + "|" + tmpArray[2] + "|" + tmpArray[3]
							+ System.lineSeparator();

				}

			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				reader.close();
			}

			
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