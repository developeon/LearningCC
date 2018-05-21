<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 폼</title>
<link rel="stylesheet" href="css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</head>
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
				<li><a href="login.jsp">로그인</a></li>
				<li class="active"><a href="join.jsp">회원가입</a></li>
			</ul>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="ture"
					aria-expanded="false">접속하기<span class="caret"></span></a>
					<ul class="dropdown-menu">
					<li ><a href="index.jsp">메인</a></li>
						<li ><a href="login.jsp">로그인</a></li>
						<li class="active"><a href="join.jsp">회원가입</a></li>
					</ul></li>
			</ul>


		</div>
	</nav>
<div class="container">
		<div class="col-lg-4"></div>
		<div class="col-lg-4">
			<div class="jumbotron" style="padding-top: 20px;">
				<form name = "form1" method="post" action="joinProc.jsp">
					<h3 stlye="text-align:center;">회원가입 화면</h3>
					<div class="form-group">
					
						<input type="text" class="form-control" placeholder="아이디"
							id = "userID" name="userID" maxlength="20" onchange = "idChange()">
							
					</div>
					<div class="form-group">
					
					<button type="button" class="btn btn-primary" onClick = "idCheck()">중복체크</button>
							
					</div>
					<div class="form-group">
						<input type="password" class="form-control" placeholder="비밀번호"
							name="userPassword" maxlength="20">
					</div>
					<div class="form-group">
						<input type="password" class="form-control" placeholder="비밀번호 확인"
							name="userPassword2" maxlength="20">
					</div>
					<input type="button" class="btn btn-primary form-control"
						value="회원가입" onClick = "check()">
						<input type = "hidden" id = "isOverlap">
				</form>
			</div>
		</div>
	</div>
	<jsp:include page="footer.jsp"></jsp:include>
	<script>
     function idCheck(){ 
    	 var URL = "idCheck.jsp?id=" + form1.userID.value;
		 var popupX = (window.screen.width/2) - 150;
		 var popupY= (window.screen.height/2) - 100;
		 window.open(URL, '', 'status=no, height=200, width=300, left='+ popupX + ', top='+ popupY + ', screenX='+ popupX + ', screenY= '+ popupY);
		
	}
     
     function check(){

    		if(form1.userID.value == ""){
    			alert("아이디를 입력하세요");
    			form1.userID.focus();
    			return 0;
    		}
    		
    		var str = document.getElementById("userID").value;
    		if ( str.match(/[^a-zA-Z0-9]/) != null ) {
    		  alert("아이디는 숫자와 영문만 사용가능합니다");
    		  return;
    		}

    
    		if(form1.userPassword.value == ""){
    			alert("비밀번호를 입력하세요");
    			form1.userPassword.focus();
    			return 0;
    		}
    		
    		if(form1.userPassword2.value == ""){
    			alert("비밀번호 확인을 입력하세요.");
    			form1.userPassword2.focus();
    			return 0;
    		}
    		
    		
    		if(form1.userPassword.value != form1.userPassword2.value){
    			alert("비밀번호가 일치하지 않습니다.");
    			form1.userPassword.focus();
    			return;
    		}
    		
    		if(form1.isOverlap.value != "pass"){
    			alert("아이디 중복체크를 해주세요");
    			return 0;
    		}
    		form1.submit();
    	}
     function idChange(){
    	 document.getElementById("isOverlap").value = "";
     }
	</script>
</body>
</html>