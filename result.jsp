<%@page import="java.util.Arrays"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.io.FileReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="sun.security.util.Length"%>
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
		String wrong = request.getParameter("wrong");
		String level = request.getParameter("level");
		String type = request.getParameter("type");
		String score = request.getParameter("score");

		if (wrong.equals(" ")) {
			out.print("축하합니다. " + score + "점 입니다.");
		} else {
			wrong = wrong.trim().substring(0, wrong.length() - 1);
			String wrongArray[] = wrong.split(",");

			BufferedReader reader = null;
			String filePath;
			String str;
			String tmpArray[];
			ArrayList<String> tmpList = new ArrayList<>();
			String splitTextArray[];

			try {
				filePath = application.getRealPath("/WEB-INF/level" + level + ".txt");
				reader = new BufferedReader(new FileReader(filePath));
				while ((str = reader.readLine()) != null) {
					tmpArray = str.split("\\|");
					for (int i = 0; i < wrongArray.length; i++) {

						if (tmpArray[0].equals(wrongArray[i])) {
							tmpList.add(str);
						}
					}
				}
	%>
	<div>
		점수 :
		<%=score%><br>틀린 문제
	</div>
	<ul>
		<%
			for (int i = 0; i < tmpList.size(); i++) {
						splitTextArray = tmpList.get(i).split("\\|");
		%>
		<li><%=splitTextArray[1]%> | <%=splitTextArray[2]%></li>
		<%
			}
		%>

	</ul>
	<%
		} catch (Exception e) {
				e.printStackTrace();
			}
		}
		//level에 맞는 text읽어서 틀린거 뿌려주기 equls는 타입에 따라!
	%>
	수고했다.
</body>
</html>