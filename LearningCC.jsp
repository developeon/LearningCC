<%@page import="java.util.Arrays"%>
<%@page import="java.io.FileReader"%>
<%@page import="java.io.BufferedReader"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
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
	width: 60%;
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
	line-height: 180px;
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
		String level = request.getParameter("level");
		String type = request.getParameter("type");

		BufferedReader reader = null;
		String filePath = application.getRealPath("/WEB-INF/level" + level + ".txt");
		String str;
		String tmpText = "";

		String tmpArray1[];
		String tmpArray2[];

		//선택한 급수에 따라 알맞은 파일 읽어오기
		try {
			reader = new BufferedReader(new FileReader(filePath));
			while ((str = reader.readLine()) != null) {
			
				tmpText += str + System.lineSeparator();
			}
			tmpArray1 = tmpText.trim().split(System.lineSeparator());
	%>
	<div id="container">
		<h5 = "white"> </h5> 
		<div id="next" alt="Next" title="Next">
		<img src="images/right-button.png"">
		</div>
		<div id="prev" alt="Prev" title="Prev">
			<img src="images/left-button.png">
		</div>
		<center>
			<div id="progress" style="background: #E74C3C; width: 30%;">Level <%= level %></div>
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
	</div>



</body>
</html>