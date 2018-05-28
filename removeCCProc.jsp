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

	background-color: #337ab7;
	border: none;
}
</style>
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
			
	%>
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">

				<span class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="index.jsp">한자학습</a>
		</div>

		<div class="collapse navbar-collapse"
			id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
			
				<li><a href="insertCC.jsp">한자 추가</a></li>
				<li class="active"><a href="removeCC.jsp">한자 삭제</a></li>
				<li><a href="logout.jsp">로그아웃</a></li>
				
			</ul>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="ture"
					aria-expanded="false">
						admin님
					<span
						class="caret"></span>
				</a>
					<ul class="dropdown-menu">
						<li><a href="index.jsp">메인</a></li>
						
						<li><a href="insertCC.jsp">한자 추가</a></li>
						<li class="active"><a href="removeCC.jsp">한자 삭제</a></li>
						<li><a href="logout.jsp">로그아웃</a></li>

					</ul></li>
			</ul>


		</div>
	</nav>
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
						<td class="col-xs-3"></td>
						<td class="col-xs-6">등록된 데이터가 없습니다.</td>
						<td class="col-xs-3"></td>

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