<%@page import="java.util.Arrays"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.io.FileReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.util.Random"%>

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
	line-height: 180px;
}

.SecondBox {
	position: absolute;
	bottom: 0;
	left: 0;
	height: 180px;
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
		$("#slider").click(function() {
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
		BufferedReader reader = null;
		String filePath;
		String str;

		//meaningPlate.txt 잃기
		filePath = application.getRealPath("/WEB-INF/meaningPlate.txt");
		String meaningPlateText = "";
		String meaningPlateArray[];

		try {
			reader = new BufferedReader(new FileReader(filePath));
			while ((str = reader.readLine()) != null) {
				meaningPlateText += str;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		meaningPlateArray = meaningPlateText.split("\\|");
		//System.out.println(Arrays.toString(meaningPlateArray));

		//wordPlate.txt 읽기
		filePath = application.getRealPath("/WEB-INF/wordPlate.txt");
		String wordPlateText = "";
		String wordPlateArray[];

		try {
			reader = new BufferedReader(new FileReader(filePath));
			while ((str = reader.readLine()) != null) {
				wordPlateText += str;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		wordPlateArray = wordPlateText.split("\\|");
		//System.out.println(Arrays.toString(wordPlateArray));

		//선택한 급수에 따라 알맞은 level.txt 읽기
		String level = request.getParameter("level");
		String type = request.getParameter("type");

		filePath = application.getRealPath("/WEB-INF/level" + level + ".txt");

		String tmpText = "";
		String tmpArray1[];
		String tmpArray2[];

		try {
			reader = new BufferedReader(new FileReader(filePath));
			while ((str = reader.readLine()) != null) {
				tmpText += str + System.lineSeparator();
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
			<div id="progress" style="background: #E74C3C; width: 30%;">
				Level
				<%=level%></div>
		</center>
		<div id="slider">
			<%
				for (int i = 0; i < tmpArray1.length; i++) {
						tmpArray2 = tmpArray1[i].split("\\|");
			%>
			<div class="slide">
				<div class="firstBox">
					<%
						if (type.equals("word")) {
					%>
					<h1><%=tmpArray2[1]%></h1>
					<%
						} else {
					%>
					<h1><%=tmpArray2[2]%></h1>
					<%
						}
					%>
				</div>
				<hr color="#FBE1E1">
				<div class="SecondBox" style="z-index: 100; background: #8BC34A;"></div>
				<table id="myTable" border="1" width="100%" height="180px"
					style="text-align: left;">
			
					<%
					ArrayList<String> answerList = new ArrayList<String>();
					Random random = new Random();
					int correctIndex = (int)random.nextInt(4); 
					
					while(true){
					answerList.add(meaningPlateArray[random.nextInt(meaningPlateArray.length)]);
					if(answerList.size() == 3) break;
					}
					
					int j;
					for(j= 0; j < answerList.size(); j++){
						if(j==correctIndex){
							%>
							<tr><td>correct</td></tr>
							<% 
							break;
						}
						%>
						<tr><td><%= answerList.get(j) %> </td></tr>
						<% 
					}
					
					if(correctIndex==3){
						%>
						<tr><td>correct</td></tr>
						<%
					}
					else{
					while(j < answerList.size()){
						%>
						<tr><td><%= answerList.get(j) %> </td></tr>
						<% 
						j+=1;
					}
					}
					
					%>
				</table>


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
				onClick="location.href = 'gameOption.jsp'">옵션 바꾸기</button>
			<button class="button blueButton"
				onClick="location.href = 'index.jsp'">그만하기</button>
		</center>

	</div>

</body>
</html>