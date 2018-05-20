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
<title>단어학습</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<style>
* {
	margin: 0;
	padding: 0;
}

body {
	font-size: 14px;
	color: #fff;
	background: #424242;
	line-height: 1.6em;
}

#container {
	width: 50%;
	margin: 40px auto;
}

p {
	margin: 0;
	padding: 0 35px 0 0;
}

#slider {
	width: 100%;
	height: 360px;
	position: relative;
	overflow: hidden;
	float: left;
	padding: 0;
	border: #666 solid 2px;
	border-radius: 15px;
	text-align: center;
	/* line-height: 180px; */
}

#slider h1 {
	line-height: 180px;
	margin: 0px;
	padding: 0px;
}

.slide {
	position: absolute;
	width: 100%;
	height: 100%;
	background: white;
	color: black;
}

.firstBox {
	height: 180px;
	background: white;
	width: 100%;
}

.SecondBox {
	position: absolute;
	bottom: 0;
	left: 0;
	height: 180px;
	background: #8BC34A;
	width: 100%;
}

#prev, #next {
	cursor: pointer;
	z-index: 100;
	display: inline-block;
	position: relative;
	top: 197px;
	margin: 0;
	padding: 0;
	opacity: 0.7;
	filter: alpha(opacity = 70);
}

#next {
	float: right;
	right: -70px;
}

#prev {
	float: left;
	left: -70px;
}

.arrow-right {
	width: 0;
	height: 0;
	position: relative;
	top: 20%;
	right: -40%;
}

.arrow-left {
	width: 0;
	height: 0;
	position: relative;
	top: 20%;
	left: 30%;
}

.button {
	background-color: #4CAF50;
	width: 30%;
	border: none;
	color: white;
	padding: 15px 32px;
	text-align: center;
	text-decoration: none;
	display: inline-block;
	font-size: 16px;
	margin: 15px 2px;
	cursor: pointer;
	border-radius: 15px;
}

.blueButton {
	background-color: #008CBA;
}

.redButton {
	background-color: #E74C3C;
}
</style>

<script>

	$(document).ready(function() {
		// options
		var speed = 0; //transition speed - fade
		// add first initial active class
		$(".slide").first().addClass("active");
		// hide all slides
		$(".slide").hide;
		// show only active class slide
		$(".active").show();
		// Next Event Handler
		$('#next').on('click', nextSlide);// call function nextSlide
		// Prev Event Handler
		$('#prev').on('click', prevSlide);// call function prevSlide
		// Switch to next slide
		function nextSlide() {
			$('.active').removeClass('active').addClass('oldActive');
			if ($('.oldActive').is(':last-child')) {
				$('.slide').first().addClass('active');
			} else {
				$('.oldActive').next().addClass('active');
			}
			$('.oldActive').removeClass('oldActive');
			$('.slide').fadeOut(speed);
			$('.active').fadeIn(speed);
		}
		// Switch to prev slide
		function prevSlide() {
			$('.active').removeClass('active').addClass('oldActive');
			if ($('.oldActive').is(':first-child')) {
				$('.slide').last().addClass('active');
			} else {
				$('.oldActive').prev().addClass('active');
			}
			$('.oldActive').removeClass('oldActive');
			$('.slide').fadeOut(speed);
			$('.active').fadeIn(speed);
		}
		$(".SecondBox").click(function() {
			$(".SecondBox").animate({
				height : "0px"
			}, "slow");
		});
		$("#prev").click(function() {
			$(".SecondBox").animate({
				height : "180px"
			}, 0);
		});
		$("#next").click(function() {
			$(".SecondBox").animate({
				height : "180px"
			}, 0);
		});
	});
	
	
</script>
</head>
<body>
	<%
		String level = request.getParameter("level");
		String type = request.getParameter("type");
		BufferedReader reader = null;
		String filePath = application.getRealPath("/WEB-INF/level" + level + ".txt");
		String str;
		String tmpText = "";
		String tmpArray1[];
		String tmpArray2[];
		int cnt = 0;
		//선택한 급수에 따라 알맞은 파일 읽어오기
		try {
			reader = new BufferedReader(new FileReader(filePath));
			while ((str = reader.readLine()) != null) {
				tmpText += str + System.lineSeparator();
				cnt++;
			}
			tmpArray1 = tmpText.trim().split(System.lineSeparator());
	%>
	<div id="container">

		<div id="next" alt="Next" title="Next">
			<img src="images/right-button.png"">
		</div>
		<div id="prev" alt="Prev" title="Prev">
			<img src="images/left-button.png">
		</div>
		<center>
			<div style="background: #E74C3C; width: 30%;"><%=level%>급
			</div>
		</center>
		<div id="slider">
			<%
				for (int i = 0; i < tmpArray1.length; i++) {
						tmpArray2 = tmpArray1[i].split("\\|");
			%>
			<div class="slide"
				<%if (i == 0)
						out.print("class = 'slide active' style='display: block;'");
					else
						out.print("class = 'slide' style='display: none;'");%>>

				<div class="firstBox">
					<div class="progress"
						style="position: absolute; top: 10px; left: 10px; width: 15%;">

						<div class="progress-bar" role="progressbar" aria-valuenow="70"
							aria-valuemin="0" aria-valuemax="100"
							style="width: <%=(int) (((double) i + 1) / cnt * 100)%>%">
							<%=i + 1%>/<%=cnt%>
						</div>
					</div>
					<div style="position: absolute; top: 10px; left: 40%; width: 15%;">
						<img id="starImg<%=tmpArray2[0]%>" src="images/star1.png"
							style="cursor: pointer;" onClick="addWordBook(<%=tmpArray2[0]%>,'<%=type%>','<%=level%>')">
							
					</div>
					<%
						if (type.equals("word")) {
					%>
					<span style="line-height: 180px"><font size="24px"><%=tmpArray2[1]%></font></span>
					<%
						} else {
					%>
					<span style="line-height: 180px"><font size="24px"><%=tmpArray2[2]%></font></span>
					<%
						}
					%>
				</div>
				<hr color="#FBE1E1" style="margin: 0px;">
				<div class="SecondBox"></div>
				<%
					if (type.equals("word")) {
				%>
				<h1><%=tmpArray2[2]%></h1>
				<%
					} else {
				%>
				<h1><%=tmpArray2[1]%></h1>
				<%
					}
				%>
			</div>
			<%
				}
				} catch (Exception e) {
					e.printStackTrace();
				}
			%>
		</div>
		<center>

			<button class="button redButton"
				onClick="location.href = 'option.jsp'">옵션 바꾸기</button>
			<button class="button blueButton"
				onClick="location.href = 'index.jsp'">그만하기</button>
		</center>

	</div>
	 <script>
	var status = "false";
	
	function addWordBook(itemIndex, type,level){
		var starImg = document.getElementById("starImg" + itemIndex);
		if(status == "false"){
		  starImg.src = "images/star2.png";
		  status= "true";
		  var URL = "insertWordProc.jsp?level=" + level + "&type=" + type + "&pk=" + itemIndex;
		  var popupX = (window.screen.width/2) - 150;
		// 만들 팝업창 좌우 크기의 1/2 만큼 보정값으로 빼주었음

		var popupY= (window.screen.height/2) - 100;
		// 만들 팝업창 상하 크기의 1/2 만큼 보정값으로 빼주었음

		window.open(URL, '', 'status=no, height=200, width=300, left='+ popupX + ', top='+ popupY + ', screenX='+ popupX + ', screenY= '+ popupY);

		}
		else{
			starImg.src = "images/star1.png";
			status = "false";
			
			}
		
	}
	</script>



</body>
</html>