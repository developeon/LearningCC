<%@page import="java.io.FileReader"%>
<%@page import="java.io.BufferedReader"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<link rel="stylesheet" href="css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="js/bootstrap.js"></script>
<style>
.table-fixed {
	width: 70%;
}

.table-fixed tbody {
	height: 70%;
	width: 100%;
}

.table-fixed thead, tbody, tr, td, th {
	text-align: center;
}

.table-fixed thead tr th {

	background-color: #5cb85c;
	border: none;
}
</style>
</head>
<body>

	<%
		request.setCharacterEncoding("UTF-8");
		String level = request.getParameter("level");
			
	%>
<center>
<table class="table table-fixed">
			
				<thead>
					<tr>
						<th class="col-xs-3">한자</th>
						<th class="col-xs-6">뜻</th>
						<th class="col-xs-3">비고</th>
					</tr>
				</thead>
				<tbody>

					<%
					BufferedReader reader = null;
					String filePath = application.getRealPath("/WEB-INF/level" + level + ".txt");
					String str;
					String tmpArray[];
					int cnt = 0;

					try {
						reader = new BufferedReader(new FileReader(filePath));
						while ((str = reader.readLine()) != null) {
							cnt++;
							tmpArray = str.split("\\|");
					%>
					<tr>
						<td class="col-xs-3"><%=tmpArray[1]%></td>
						<td class="col-xs-6"><%=tmpArray[2]%></td>
						<td class="col-xs-3"><button type="button" class="btn" onClick ="removeProcess('<%=level%>','<%=tmpArray[0]%>')">삭제하기</button></td>
						
					</tr>
					<%
						}
					} catch (Exception e) {
						e.printStackTrace();
					}
					
						if(cnt == 0){
							%>
							<tr>
						<td class="col-xs-12">등록된 데이터가 없습니다.</td>

					</tr>
							<% 
						}
						
					%>
				</tbody>
			</table>
			<button type="button" class="btn btn-primary" onClick = "location.href='removeCC.jsp';">돌아가기</button>
			</center>
<script>
function removeProcess(level, pk){
	location.href = "removeCCProc2.jsp?level=" +level + "&pk=" + pk;
	alert("삭제되었습니다.");
}</script>


</body>
</html>