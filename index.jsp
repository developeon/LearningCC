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
<title>설문조사</title>
<link rel="stylesheet" href="css/bootstrap.min.css">

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
					<li><a href = "#">단어 추가</a></li>
			
					<li><a href="logout.jsp">로그아웃</a></li>
					<%} else{ %>
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
						<li><a href = "#">단어 추가</a></li>
						<li ><a href="logout.jsp">로그아웃</a></li>
						
						<%} 
		else{
						%>
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
				학생들이 좋아하는 우리반 단어장, 클래스카드
			</p>
			<p class="text-center">
			<%if(userID==null){ %>
				<a class="btn btn-primary btn-lg" href="login.jsp" role="button">로그인 하기</a>
					<% } else{%>
					<a class="btn btn-primary btn-lg" href="logout.jsp" role="button">로그아웃 하기</a>
					<%} %>
			</p>
		</div>
		
		<section>
		<form action="LearningCC.jsp" method="get">
		급수입력 : <input type="number" name="level" min="1" max="8"> <br>
		<label><input type="radio" name="type" value="word">단어
			제시</label> <label><input type="radio" name="type" value="meaning">의미
			제시</label> <input type="submit" value="시작">
	</form>
			</section>
			
	
		
</div>

	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
		
		
</body>
</html>