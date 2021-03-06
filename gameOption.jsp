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
				<li ><a href="myPage.jsp">내 정보</a></li>
				<li><a href="option.jsp" >한자 학습</a></li>
				<li class="active"><a href="gameOption.jsp">한자 시험</a></li>
				<li><a href="logout.jsp">로그아웃</a></li>
				<%
					}
				%>
			</ul>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="ture"
					aria-expanded="false">
						<%
							if (userID == null) {
						%>접속하기<%
							} else {
								out.print(userID + "님");
							}
						%><span
						class="caret"></span>
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
						<li ><a href="myPage.jsp">내 정보</a></li>
						<li ><a href="option.jsp" >한자 학습</a></li>
							<li class="active"><a href="gameOption.jsp">한자 시험</a></li>
						<li><a href="logout.jsp">로그아웃</a></li>
						<%
							}
						%>
					</ul></li>
			</ul>


		</div>
	</nav>

				<div class="container">
		<div class="col-lg-4"></div>
		<div class="col-lg-4">
			<div class="jumbotron" style="padding-top: 20px;">
				<form name="form1" method="post" action="ccGame.jsp">
					<h3 stlye="text-align:center;">한자 시험</h3>
				
					<div class="form-group">						
							<input type="number" class="form-control"
									placeholder="급수" name="level" max="8" min = "1">
					</div>
				
					<div class="form-group" style="text-align: center;">
						<div class="btn-group" data-toggle="buttons">
							<label class="btn btn-primary active"> <input
								type="radio" name="type" value="word" checked>한자
							</label> <label class="btn btn-primary"> <input type="radio"
								name="type" value="meaning">음훈
							</label>
						</div>
					</div>
					<input type="button" class="btn btn-primary form-control"
						value="Start" onClick = "check()">
				
				</form>
			</div>
		</div>
	</div>
				
	<jsp:include page="footer.jsp"></jsp:include>

	<link rel="stylesheet" href="css/bootstrap.min.css">
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
<script>
function check(){

	if(form1.level.value == ""){
		alert("급수를 입력하세요");
		form1.level.focus();
		return 0;
	}
	if(form1.level.value > 8 || form1.level.value < 1){
		alert("1~8사이의 값을 입력하세요");
		form1.level.focus();
		return 0;
	}
	
	form1.submit();
}
</script>
</body>
</html>