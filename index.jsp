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
<title>한자학습</title>
<link rel="stylesheet" href="css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="js/bootstrap.js"></script>

<style>
.jumbotron {
	background-image: url(images/learning.png);
	background-size: cover;
	text-shadow: gray 0.2em 0.2em 0.2em;
}

</style>
</head>
<body>
<% 	String userID = (String)session.getAttribute("userID"); %>
<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">

				<span class="icon-bar"></span> 
				<span class="icon-bar"></span> 
				<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="index.jsp">한자학습</a>
		</div>

		<div class="collapse navbar-collapse"
			id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
		<% if(userID==null){%>
				<li><a href="login.jsp">로그인</a></li>
				<li ><a href="join.jsp">회원가입</a></li>
				<%} 
		else if(userID.equals("admin")){
					%>
					<li><a href = "insertCC.jsp">한자 추가</a></li>
					<li><a href = "removeCC.jsp">한자 삭제</a></li>
					<li><a href="logout.jsp">로그아웃</a></li>
					<%} else{ %>
					<li ><a href="myPage.jsp">내 정보</a></li>
					<li ><a href="option.jsp">한자 학습</a></li>
					<li><a href="gameOption.jsp">한자 시험</a></li>
					<li><a href="logout.jsp">로그아웃</a></li>
					<% 
				}%>
			</ul>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="ture"
					aria-expanded="false"><% if(userID==null){%>접속하기<%} else { out.print(userID + "님"); }%><span class="caret"></span></a>
					<ul class="dropdown-menu">
					<li class="active"><a href="index.jsp">메인</a></li>
					<% if(userID==null){%>
						<li ><a href="login.jsp">로그인</a></li>
						<li ><a href="join.jsp">회원가입</a></li>
							<%} 
		else if(userID.equals("admin")){
					%>
						<li><a href = "insertCC.jsp">한자 추가</a></li>
						<li><a href = "removeCC.jsp">한자 삭제</a></li>
						<li ><a href="logout.jsp">로그아웃</a></li>
						
						<%} 
		else{
						%>
						<li ><a href="myPage.jsp">내 정보</a></li>
						<li><a href="option.jsp">한자 학습</a></li>
						<li><a href="gameOption.jsp">한자 시험</a></li>
						<li ><a href="logout.jsp">로그아웃</a></li>
						<%} %>
					</ul></li>
			</ul>


		</div>
	</nav>

	<div class="container">
		<div class="jumbotron">
			<h1 class="text-center">Class Card</h1>
			<p class="text-center">
				학생들이 좋아하는 한자학습 사이트
			</p>
			<p class="text-center">
			<%if(userID==null){ %>
				<a class="btn btn-primary btn-lg" href="login.jsp" role="button">로그인 하기</a>
					<% } else{%>
					<a class="btn btn-primary btn-lg" href="logout.jsp" role="button">로그아웃 하기</a>
					<%} %>
			</p>
		</div>
		

		<table width = "80%" align="center">
		<tr>
		<td width="50%">
		<h2>나만의 단어장</h2>
		<h3>공부중에도, 시험을 친 후에도 언제든지 추가할 수 있습니다!</h3>
		</td>
		<td width="50%"><img src = "images/index1.PNG" width="520px"></td>
		</tr>
		
			<tr>
		<td width="50%">
		<h1> </h1>
		<h3> </h3>
		</td>
		<td > </td>
		</tr>
		
		<tr>
		<td width="50%">
		<h1>한자 학습</h1>
		<h3>급수별로 과학적인 한자학습을 할 수 있습니다!</h3>
		</td>
		<td ><img src = "images/index2.gif" width="520px"></td>
		</tr>
		
		<tr>
		<td width="50%">
		<h1> </h1>
		<h3> </h3>
		</td>
		<td > </td>
		</tr>
		
		<tr>
		<td width="50%">
		<h1>급수 시험</h1>
		<h3>학습한 한자를 테스트 할 수 있습니다!</h3>
		</td>
		<td ><img src = "images/index3.jpeg" width="520px"></td>
		</tr>
	
		</table>

			
	
		
</div>
<jsp:include page="footer.jsp"></jsp:include>


	
		
</body>
</html>