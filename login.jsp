<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 폼</title>
<link rel="stylesheet" href="css/bootstrap.min.css">
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</head>
<script>
function check(){

	if(form1.userID.value == ""){
		alert("아이디를 입력하세요");
		form1.userID.focus();
		return 0;
	}
	if(form1.userPassword.value == ""){
		alert("비밀번호를 입력하세요");
		form1.userPassword.focus();
		return 0;
	}
	form1.submit();
}</script>
<body>
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
			id="bs-exapmple-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li class="active"><a href="login.jsp">로그인</a></li>
				<li><a href="join.jsp">회원가입</a></li>
			</ul>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="ture"
					aria-expanded="false">접속하기<span class="caret"></span></a>
					<ul class="dropdown-menu">
					<li ><a href="index.jsp">메인</a></li>
						<li class="active"><a href="login.jsp">로그인</a></li>
						<li><a href="join.jsp">회원가입</a></li>
					</ul></li>
			</ul>


		</div>
	</nav>
<div class="container">
		<div class="col-lg-4"></div>
		<div class="col-lg-4">
			<div class="jumbotron" style="padding-top: 20px;">
				<form name = "form1" method="post" action="loginProc.jsp">
					<h3 stlye="text-align:center;">로그인 화면</h3>
					<div class="form-group">
						<input type="text" class="form-control" placeholder="아이디"
							name="userID" maxlength="20">
					</div>
					<div class="form-group">
						<input type="password" class="form-control" placeholder="비밀번호"
							name="userPassword" maxlength="20">
					</div>
					
					<input type="button" class="btn btn-primary form-control"
						value="login" onClick="check()">
					<a class="btn btn-link" href="join.jsp">회원이 아니십니까?</a>
					
				</form>
				
			</div>
			
		</div>
		
	</div>
	
	<jsp:include page="footer.jsp"></jsp:include>	
</body>
</html>