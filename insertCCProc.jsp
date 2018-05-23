<%@page import="java.io.FileWriter"%>
<%@page import="java.io.FileReader"%>
<%@page import="java.io.BufferedReader"%>
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

		String level = request.getParameter("level");
		String cc = request.getParameter("cc");
		String meaning = request.getParameter("meaning");

		String filePath;//읽고 쓸때 모두 사용

		//마지막 pk읽어서 그다음 pk로 등록
		BufferedReader reader = null;
		int pk = 1; // write할때 쓸 pk 
		
		filePath = application.getRealPath("/WEB-INF/level" + level + ".txt");
		reader = new BufferedReader(new FileReader(filePath));
		
        String s;
        int cntForCount = 0;
        String lastLine = "";
        String[] lastLineSplitArray;
	
		try {
			 while ((s = reader.readLine()) != null) {
				cntForCount++;
				lastLine = s;
		     }
			 
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			reader.close();
		}
		if(cntForCount > 0){
			lastLineSplitArray = lastLine.split("\\|");
			pk = Integer.parseInt(lastLineSplitArray[0]) + 1;
		}
		
		BufferedWriter writer = null;
		try {
			filePath = application.getRealPath("/WEB-INF/level" + level + ".txt");
			writer = new BufferedWriter(new FileWriter(filePath, true));
			writer.write(pk + "|" + cc + "|" + meaning + System.lineSeparator());
		} catch (Exception e) {
			out.print("오류 발생");
		} finally {
			writer.close();
		}
	%>
	 <jsp:forward page="insertCC.jsp"></jsp:forward>
</body>
</html>