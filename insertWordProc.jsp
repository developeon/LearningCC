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
		BufferedReader reader = null;
		String str;

		if(mode == null){
		String pk = request.getParameter("pk");
		//알맞은 데이터 읽어오기
		
		String tmpArray[];
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
		}finally{
			reader.close();
		}
		}//학습 중 추가, result
		
		else{
			cc = request.getParameter("cc");
			meaning = request.getParameter("meaning");
		}
		
		filePath = application.getRealPath("/WEB-INF/" + userID + ".txt");

		String lastLine = "";
		String lastLineSplitArray[];
		int cntForCount = 0;
		try{
			reader = new BufferedReader(new FileReader(filePath));
		
		while ((str = reader.readLine()) != null) {
			cntForCount++;
			lastLine = str;
		}}catch(Exception e){
			e.printStackTrace();
		}
		
		//get last pk
		int pk = 1; // write할때 쓸 pk 
		if(cntForCount > 0){
			lastLineSplitArray = lastLine.split("\\|");
			System.out.print(lastLineSplitArray[0] );
			pk = Integer.parseInt(lastLineSplitArray[0]) + 1;
		}
		    
		
		//단어장에 쓰기
		BufferedWriter writer = null;
		try {
			filePath = application.getRealPath("/WEB-INF/" + userID + ".txt");
			writer = new BufferedWriter(new FileWriter(filePath, true));
			writer.write(pk + "|" + level + "급|" +  cc + "|" + meaning + System.lineSeparator());
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

	
	response.sendRedirect("myPage.jsp");

	} %>
	<script>
		function closePopUp() {
			self.close();
		}
	</script>
</body>

</html>