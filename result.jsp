<%@page import="java.io.FileWriter"%>
<%@page import="java.io.BufferedWriter"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.io.FileReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="sun.security.util.Length"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>

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
body{
	width:100%;
	height:100%;
	
}
.contain{
	position:absolute;
	top:0;
	left:0;
	width:100%;
	height:100%;
	background: linear-gradient(90deg,#189086,#2f8198);
background-image: linear-gradient(to bottom right,#02b3e4,#02ccba);	
}

.done{
	width:100px;
	height:100px;
	position:relative;
	left: 0;
	right: 0;
	top:-20px;
	margin:auto;
}
.contain h1{
	font-family: 'Julius Sans One', sans-serif;
	font-size:1.4em;
	color: #02b3e4;/* congrats 색 */
}

.congrats{
	position:relative;
	left:50%;
	top:50%;
	max-width:800px;	transform:translate(-50%,-50%);
	width:80%;
	min-height:300px;
	max-height:900px;
	border:2px solid white;
	border-radius:5px;
	    box-shadow: 12px 15px 20px 0 rgba(46,61,73,.3);
    background-image: linear-gradient(to bottom right,#02b3e4,#02ccba);
	background:#fff;
	text-align:center;
	font-size:2em;
	color: #189086; /* InfoText 색 */
}

.text{
	position:relative;
	font-weight:normal;
	left:0;
	right:0;
	margin:auto;
	width:80%;
	max-width:800px;

	font-family: 'Lato', sans-serif;
	font-size:0.6em;

}


.circ{
    opacity: 0;
    stroke-dasharray: 130;
    stroke-dashoffset: 130;
    -webkit-transition: all 1s;
    -moz-transition: all 1s;
    -ms-transition: all 1s;
    -o-transition: all 1s;
    transition: all 1s;
}
.tick{
    stroke-dasharray: 50;
    stroke-dashoffset: 50;
    -webkit-transition: stroke-dashoffset 1s 0.5s ease-out;
    -moz-transition: stroke-dashoffset 1s 0.5s ease-out;
    -ms-transition: stroke-dashoffset 1s 0.5s ease-out;
    -o-transition: stroke-dashoffset 1s 0.5s ease-out;
    transition: stroke-dashoffset 1s 0.5s ease-out;
}
.drawn svg .path{
    opacity: 1;
    stroke-dashoffset: 0;
}

.regards{
	font-size:.7em;
}


@media (max-width:600px){
	.congrats h1{
		font-size:1.2em;
	}
	
	.done{
		top:-10px;
		width:80px;
		height:80px;
	}
	.text{
		font-size:0.5em;
	}
	.regards{
		font-size:0.6em;
	}
}

@media (max-width:500px){
	.congrats h1{
		font-size:1em;
	}
	
	.done{
		top:-10px;
		width:70px;
		height:70px;
	}
	
}

@media (max-width:410px){
	.congrats h1{
		font-size:1em;
	}
	
	.congrats{
		width:100%;
	}
	
	.done{
		top:-10px;
		width:50px;
		height:50px;
	}
	.regards{
		font-size:0.55em;
	}
	
}

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
<script>

$(window).on("load",function(){
	
	setTimeout(function(){$('.done').addClass("drawn");},500)
	
});

</script>
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
	    String isPass = "no";
	    String isChange = "no";
	    String isPerfect = "no";
	    String wrongCC = "";
	    int passScore = 5; //통과하는 점수
	    
	    Date today = new Date();	        
	    SimpleDateFormat date = new SimpleDateFormat("yyyy/MM/dd");
	    //System.out.println("Date: "+date.format(today));

	   
	    
		request.setCharacterEncoding("UTF-8");
		String wrong = request.getParameter("wrong");
		String level = request.getParameter("level");
		String type = request.getParameter("type");
		String score = request.getParameter("score");
		String writeText = "";
		String userInfo = "";
		String userInfoArray[];
		
		BufferedReader reader = null;
		BufferedWriter writer = null;
		String filePath;
		String str;
		
		//이 회원의 현재 급수 읽어오기
		String userID = (String)session.getAttribute("userID");
		String tmpMemberArray[];
		String userLevel = "";

		try {
			 filePath = application.getRealPath("/WEB-INF/member.txt");
			reader = new BufferedReader(new FileReader(filePath));
			while ((str = reader.readLine()) != null) {
				tmpMemberArray = str.split("\\|");
				if(tmpMemberArray[0].equals(userID)){
					userLevel = tmpMemberArray[2];
					userInfo += str;
				}else{
					writeText+= str + System.lineSeparator();
				}
			}
		
		} catch (Exception e) {
			out.println("지정된 파일을 읽을 수 없습니다.");
		} finally {
			reader.close();
		}
		
		int iscore = Integer.parseInt(score);
		int ilevel = Integer.parseInt(level);
		int iuserLevel = Integer.parseInt(userLevel);
		iuserLevel -= 1;
		userInfoArray = userInfo.split("\\|");
		
		//결과창 띄우기
		if (iscore >= passScore && ilevel == iuserLevel) { // 회원의 현재 급수가 level보다 한단계 낮으면. (8급인데 1급보면 1급되는거 x 차례차례 올라오기)
			isPass = "yes";
		    isChange = "yes";
			//BufferedWriter writer = null;
			try {
				filePath = application.getRealPath("/WEB-INF/member.txt");
				writer = new BufferedWriter(new FileWriter(filePath, false));
				writer.write(writeText);
				writer.write(userInfoArray[0] + "|" + userInfoArray[1] + "|" + level + System.lineSeparator()); 
			} catch (Exception e) {
				out.print("오류 발생");
			} finally {
				writer.close();
			}
		}
		else if(iscore >= passScore){
			isPass = "yes";
		}
		
		
		if(wrong.equals(" ")){ //틀린 문제가 없으면
			isPerfect = "yes";
		}
		else{
			wrong = wrong.trim().substring(0, wrong.length() - 1);
			String wrongArray[] = wrong.split(",");

			
			String tmpArray[];
			ArrayList<String> tmpList = new ArrayList<>();
			String splitTextArray[];

			try {
				filePath = application.getRealPath("/WEB-INF/level" + level + ".txt");
				reader = new BufferedReader(new FileReader(filePath));
				while ((str = reader.readLine()) != null) {
					tmpArray = str.split("\\|");
					for (int i = 0; i < wrongArray.length; i++) {

						if (tmpArray[0].equals(wrongArray[i])) {
							tmpList.add(str);
						}
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}

			for (int i = 0; i < tmpList.size(); i++) {
						splitTextArray = tmpList.get(i).split("\\|");
						wrongCC += splitTextArray[0] + "|" +  splitTextArray[1] + "|" + splitTextArray[2] + System.lineSeparator();
			}
		}
		
		if(isPass.equals("yes") && isChange.equals("yes")){
			try {
				filePath = application.getRealPath("/WEB-INF/passlist.txt");
				writer = new BufferedWriter(new FileWriter(filePath, true));
				writer.write(userID + "|" + date.format(today) +  "|"+ level + "|"  + score + System.lineSeparator()); 
			} catch (Exception e) {
				out.print("오류 발생");
			} finally {
				writer.close();
			}
		}
		%>
	
	<%
	if(isPass.equals("yes")){
		%>
		<div class="contain">
	<div class="congrats">
			<h1>Congratulations !</h1><br>
		<div class="done">
			<svg version="1.1" id="tick" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
	 viewBox="0 0 37 37" style="enable-background:new 0 0 37 37;" xml:space="preserve">
<path class="circ path" style="fill:#0cdcc7;stroke:#07a796;stroke-width:3;stroke-linejoin:round;stroke-miterlimit:10;" d="
	M30.5,6.5L30.5,6.5c6.6,6.6,6.6,17.4,0,24l0,0c-6.6,6.6-17.4,6.6-24,0l0,0c-6.6-6.6-6.6-17.4,0-24l0,0C13.1-0.2,23.9-0.2,30.5,6.5z"
	/>
<polyline class="tick path" style="fill:none;stroke:#fff;stroke-width:3;stroke-linejoin:round;stroke-miterlimit:10;" points="
	11.6,20 15.9,24.2 26.4,13.8 "/>
</svg>
			</div>
		<div class="text">
		<p>축하합니다.  <br><%=score%>점으로 시험에 통과하셨습니다.<br>
		ID: <%= userID %>
			 <br>Date: <%=date.format(today)%>
		</p>
			<p>
			<%if(isChange.equals("yes")){
				out.print("이제 당신의 급수는" + level + "급입니다.");
			}
			else{
				out.print("급수 변동은 없습니다. 알맞은 급수의 시험에 도전하세요!");
			}
			%>
			
			</p>
			</div>
		<p class="regards">틀린 문제
		<% if(isPerfect.equals("yes")){
			%>
			는 없습니다.
			<% 
		}//perfect
		else{
			%>
			<br>
			<%
			String passWrongArray[] = wrongCC.split(System.lineSeparator());
			for(int i = 0; i< passWrongArray.length; i++){
				%>
				<%=passWrongArray[i]%><br>
				<%
			}
			
		 
		} //not perfect
		%>
		</p>
		<p>
		<button type="button" class="btn" onClick = "location.href = 'index.jsp'">돌아가기</button>
		</p>
	</div>
</div>
		<% 
	}//pass
	else{
		%>
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
	
					<li ><a href="myPage.jsp">내 정보</a></li>
					<li ><a href="option.jsp">단어 학습</a></li>
					<li><a href="gameOption.jsp">단어 게임</a></li>
					<li><a href="logout.jsp">로그아웃</a></li>
				
			</ul>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="ture"
					aria-expanded="false"><%out.print(userID + "님");%><span class="caret"></span></a>
					<ul class="dropdown-menu">
					<li class="active"><a href="index.jsp">메인</a></li>
						<li ><a href="myPage.jsp">내 정보</a></li>
						<li><a href="option.jsp">단어 학습</a></li>
						<li><a href="gameOption.jsp">단어 게임</a></li>
						<li ><a href="logout.jsp">로그아웃</a></li>
						
					</ul></li>
			</ul>


		</div>
	</nav>
	<div class = "container">
	  시험에 통과하지 못했습니다.(<%=score%>점)<br>
	  ID: <%= userID %><br>
	  Date: <%=date.format(today)%><br>
	  틀린문제
	  <table class="table table-fixed">
			
				<thead>
					<tr>
						<th class="col-xs-3">한자</th>
						<th class="col-xs-6">뜻</th>
						<th class="col-xs-3">비고</th>
					</tr>
				</thead>
				<tbody>
					  <%String wrongTmpArray[] = wrongCC.split(System.lineSeparator());
					  String wrongtmpArray2[];
					  for(int i = 0; i < wrongTmpArray.length; i++){
						  wrongtmpArray2 = wrongTmpArray[i].split("\\|");
						  
						  %>

						  <tr>
						  <th class="col-xs-3"><%=wrongtmpArray2[1]%></th>
						<th class="col-xs-6"><%=wrongtmpArray2[2]%></th>
						<th class="col-xs-3"><button type="button" id = "wordBtn<%=wrongtmpArray2[0]%>" class="btn" onClick = "addWordBook(<%=wrongtmpArray2[0]%>, '<%=level%>')" value = "no"><span id = "btnText<%=wrongtmpArray2[0]%>">단어장에 추가하기</span></button></th>
						  </tr>
						  <% 
					  }%>
				</tbody>
		</table>
	</div>
		<% 
	}//fail
	%>
	<script>
     function addWordBook(itemIndex, level){
		var wordBtn = document.getElementById("wordBtn" + itemIndex);
		var btnText = document.getElementById("btnText" + itemIndex);
		
		if(wordBtn.value == "no"){
			 wordBtn.value = "yes";
			 btnText.innerText = "단어장에서 삭제하기";
			  var URL = "insertWordProc.jsp?level=" + level + "&pk=" + itemIndex;
			 
		}
		
		else{
			wordBtn.value = "no";
			btnText.innerText = "단어장에 추가하기";
			var URL = "removeWordProc.jsp?level=" + level + "&pk=" + itemIndex;
			
		}
		 var popupX = (window.screen.width/2) - 150;
		  var popupY= (window.screen.height/2) - 100;
		  window.open(URL, '', 'status=no, height=200, width=300, left='+ popupX + ', top='+ popupY + ', screenX='+ popupX + ', screenY= '+ popupY);
	
	}
	</script>
	
</body>
</html>