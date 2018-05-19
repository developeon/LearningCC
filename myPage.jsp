<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title> 내 정보 </title>
<link rel="stylesheet" href="css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="js/bootstrap.js"></script>
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
					<li  class="active"><a href="myPage.jsp">내 정보</a></li>
					<li ><a href="option.jsp">단어 학습</a></li>
					<li><a href="gameOption.jsp">단어 게임</a></li>
					<li><a href="logout.jsp">로그아웃</a></li>
					<% 
				}%>
			</ul>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="ture"
					aria-expanded="false"><% if(userID==null){%>접속하기<%} else { out.print(userID + "님"); }%><span class="caret"></span></a>
					<ul class="dropdown-menu">
					<li><a href="index.jsp">메인</a></li>
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
						<li  class="active"><a href="myPage.jsp">내 정보</a></li>
						<li><a href="option.jsp">단어 학습</a></li>
						<li><a href="gameOption.jsp">단어 게임</a></li>
						<li ><a href="logout.jsp">로그아웃</a></li>
						<%} %>
					</ul></li>
			</ul>


		</div>
	</nav>
		<div class="container">
		  너의 급수와 단어장을 보여주마
		</div>
	<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>