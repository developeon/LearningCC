<%@page import="java.io.FileReader"%>
<%@page import="java.io.BufferedReader"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>내 정보</title>
<link rel="stylesheet" href="css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="js/bootstrap.js"></script>
<style>
.table-fixed {
	width: 70%;
	 
}

.table-fixed tbody {
	overflow-y: auto;
	height: 200px;
	width: 100%;
}

.table-fixed thead, tbody, tr, td, th {
	text-align: center;
	display: block;
}

.table-fixed tbody td {
	float: left;
}

.table-fixed thead tr th {
	float: left;
	background-color: #337ab7;
	border: none;
}
</style>
</head>
<body>
	<%
		String userID = (String) session.getAttribute("userID");
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
				<%
					if (userID == null) {
				%>
				<li><a href="login.jsp">로그인</a></li>
				<li><a href="join.jsp">회원가입</a></li>
				<%
					} else if (userID.equals("admin")) {
				%>
				<li><a href="#">한자 추가</a></li>
				<li><a href="logout.jsp">로그아웃</a></li>
				<%
					} else {
				%>
				<li class="active"><a href="myPage.jsp">내 정보</a></li>
				<li><a href="option.jsp">한자 학습</a></li>
				<li><a href="gameOption.jsp">한자 시험</a></li>
				<li><a href="logout.jsp">로그아웃</a></li>
				<%
					}
				%>
			</ul>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="ture"
					aria-expanded="false"> <%
 	if (userID == null) {
 %>접속하기<%
 	} else {
 		out.print(userID + "님");
 	}
 %><span class="caret"></span>
				</a>
					<ul class="dropdown-menu">
						<li><a href="index.jsp">메인</a></li>
						<%
							if (userID == null) {
						%>
						<li><a href="login.jsp">로그인</a></li>
						<li><a href="join.jsp">회원가입</a></li>
						<%
							} else if (userID.equals("admin")) {
						%>
						<li><a href="#">한자 추가</a></li>
						<li><a href="logout.jsp">로그아웃</a></li>

						<%
							} else {
						%>
						<li class="active"><a href="myPage.jsp">내 정보</a></li>
						<li><a href="option.jsp">한자 학습</a></li>
						<li><a href="gameOption.jsp">한자 시험</a></li>
						<li><a href="logout.jsp">로그아웃</a></li>
						<%
							}
						%>
					</ul></li>
			</ul>


		</div>
	</nav>
	
		<div class="container">
			
<center>
	<%
		BufferedReader reader = null;
		String filePath;
		String str;
		String tmpArray[];
		String level = "";
		
		 reader = null;
		 filePath = application.getRealPath("/WEB-INF/member.txt");
	
		
		try {
			reader = new BufferedReader(new FileReader(filePath));

			while ((str = reader.readLine()) != null) {
				tmpArray = str.split("\\|");
				if(tmpArray[0].equals(userID)){
					level = tmpArray[2];
					break;
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}
	

	if(level.equals("9")){
		out.print("<div class='alert alert-warning'> 당신은 아직 급수정보가 없습니다. <a href='gameOption.jsp' class='alert-link'> 8급 시험에 도전하세요!</a></div>");
	}
	else{
		out.print("<div class='alert alert-info'> 당신은 현재 <strong>"+ level +"급</strong>입니다.</div>");
	}
	%>
	<hr>
	<h3>시험정보</h3>
			<table class="table table-fixed">

				<thead>
					<tr style="color: white;">
						<th class="col-xs-3">급수</th>
						<th class="col-xs-6">시험일</th>
						<th class="col-xs-3">점수</th>
					</tr>
				</thead>
				<tbody>
<%
		
						 reader = null;
						 filePath = application.getRealPath("/WEB-INF/passlist.txt");
					
						int cnt = 0;
						try {
							reader = new BufferedReader(new FileReader(filePath));

							while ((str = reader.readLine()) != null) {
							
								tmpArray = str.split("\\|");
								if(tmpArray[0].equals(userID)){
									cnt++;
					%>
					<tr>
						<td class="col-xs-3"><%=tmpArray[2]%>급</td>
						<td class="col-xs-6"><%=tmpArray[1]%></td>
						<td class="col-xs-3"><%=tmpArray[3]%>점</td>
					</tr>
					<%}
						}
						} catch (Exception e) {
							e.printStackTrace();
						}
						if(cnt == 0){
							%>
							<tr>
						<td class="col-xs-12">시험 정보가 없습니다.</td>

					</tr>
							<% 
						}
					%>
				</tbody>



			</table>
			
			<hr>
			<h3>단어장</h3>
			<table class="table table-fixed">
			
				<thead>
					<tr style="color: white;">
						<th class="col-xs-2">급수</th>
						<th class="col-xs-3">한자</th>
						<th class="col-xs-4">뜻</th>
						<th class="col-xs-3">비고</th>
					</tr>
				</thead>
				<tbody>

					<%
						//id.txt파일 읽어오기
						 reader = null;
						 filePath = application.getRealPath("/WEB-INF/" + userID + ".txt");
					int cnt2 = 0;
						try {
							reader = new BufferedReader(new FileReader(filePath));

							while ((str = reader.readLine()) != null) {
								cnt2++;
								tmpArray = str.split("\\|");
					%>
					<tr>
						<td class="col-xs-2"><%=tmpArray[1]%></td>
						<td class="col-xs-3"><%=tmpArray[2]%></td>
						<td class="col-xs-4"><%=tmpArray[3]%></td>
						<td class="col-xs-3"><button type="button" class = "btn btn-info" onClick="removeWordBook(<%=tmpArray[0]%>)">삭제하기</button></td>
					</tr>
					<%
						}
						} catch (Exception e) {
							e.printStackTrace();
					
						}
					
						if(cnt2 == 0){
							%>
							<tr>
						<td class="col-xs-12">등록된 한자가 없습니다.</td>

					</tr>
							<% 
						}
						
					%>
				</tbody>
				<tfooter>
				<form name="form1" action="insertWordProc.jsp?mode=myPage" method="post">
				<tr>
					
						<td class="col-xs-2"><input type="number" min="1" max="8"
							class="form-control" name="level" placeholder="N"
							style="text-align: center;"></td>
						<td class="col-xs-3"><input type="text" class="form-control"
							name="cc" placeholder="한자" style="text-align: center;"></td>
						<td class="col-xs-4"><input type="text" class="form-control"
							name="meaning" placeholder="뜻" style="text-align: center;"></td>
							
			
				<td class="col-xs-3"><input type="button"
						class="btn btn-info" value="추가하기" onClick="notice()"></td>
						</tr>
				</form>
				</tfooter>

			</table>
</center>
	</div>
	<jsp:include page="footer.jsp"></jsp:include>
	<script>
		function notice() {
			alert("추가되었습니다");
			form1.submit();
			
		}
		

	     function removeWordBook(pk){
		    var URL = "removeWordProc.jsp?mode=myPage&pk=" + pk;
			 var popupX = (window.screen.width/2) - 150;
			  var popupY= (window.screen.height/2) - 100;
			  window.open(URL, '', 'status=no, height=200, width=300, left='+ popupX + ', top='+ popupY + ', screenX='+ popupX + ', screenY= '+ popupY);
			 location.href = "myPage.jsp";
		}
		</script>


</body>
</html>