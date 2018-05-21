<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>단어 삭제</title>
<link rel="stylesheet" href="css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="js/bootstrap.js"></script>
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
				<li class="active"><a href="insertCC.jsp">단어 추가</a></li>
				<li><a href="removeCC.jsp">단어 삭제</a></li>
				<li><a href="logout.jsp">로그아웃</a></li>
				<%
					} else {
				%>
				<li><a href="myPage.jsp">내 정보</a></li>
				<li><a href="option.jsp">단어 학습</a></li>
				<li><a href="gameOption.jsp">단어 게임</a></li>
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
						<li class="active"><a href="insertCC.jsp">단어 추가</a></li>
						<li><a href="removeCC.jsp">단어 삭제</a></li>
						<li><a href="logout.jsp">로그아웃</a></li>

						<%
							} else {
						%>
						<li><a href="myPage.jsp">내 정보</a></li>
						<li><a href="option.jsp">단어 학습</a></li>
						<li><a href="gameOption.jsp">단어 게임</a></li>
						<li><a href="logout.jsp">로그아웃</a></li>
						<%
							}
						%>
					</ul></li>
			</ul>


		</div>
	</nav>
	<div class="container">

		<form name="form1" action="insertCCProc.jsp" method="post">
			<div class="col-lg-4"></div>
			<div class="col-lg-4">
				<h2>한자 추가하기</h2>
				<div class="form-group">
					<label for="level">급수 선택</label> 
					<select class="form-control" id="level" name = "level">
						<option>1</option>
						<option>2</option>
						<option>3</option>
						<option>4</option>
						<option>5</option>
						<option>6</option>
						<option>7</option>
						<option>8</option>
					</select>

				</div>
				<div class="form-group">
					<label for="cc">한자</label> <input type="text" class="form-control"
						id="cc" placeholder="ex) 字" name="cc">
				</div>
				<div class="form-group">
					<label for="meaning">뜻</label> <input type="text"
						class="form-control" id="meaning" placeholder="ex) 글자 자"
						name="meaning">
				</div>

				<button type="button" class="btn btn-primary" onClick="check()">추가하기</button>
			</div>
		</form>
	</div>
	<jsp:include page="footer.jsp"></jsp:include>
	<script>
	function check(){
		//유효성 체크
		alert("추가되었습니다.");
		form1.submit();
	}</script>
</body>
</html>