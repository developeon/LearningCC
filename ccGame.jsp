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
		//String questionText = ""; //나온 문제의 pk 저장
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

		int lineNum = 0; //몇개가 있는지 check
		int selectCnt = 0; //20개만 선택할때 사용
		int selectArray[] = new int[20];
		Random random = new Random();
		String tmpText = "";
		String tmpArray1[] = null;
		String tmpArray2[] = null;

		try {
			reader = new BufferedReader(new FileReader(filePath));
			while ((str = reader.readLine()) != null) {
				lineNum++;
			}
		} catch (Exception e) {
		} finally {
			reader.close();
		}

		for (int i = 0; i < selectArray.length; i++) {
			selectArray[i] = random.nextInt(lineNum);
			for (int j = 0; j < i; j++)
				if (selectArray[i] == selectArray[j])
					i--;
		}

		try {
			reader = new BufferedReader(new FileReader(filePath));
			while ((str = reader.readLine()) != null) {
				for (int k = 0; k < selectArray.length; k++) {
					if (selectArray[k] == selectCnt) {
						tmpText += str + System.lineSeparator();
					}
				}
				selectCnt++;
			}

			tmpArray1 = tmpText.trim().split(System.lineSeparator());
	%>
	<div id="container">
		<div id="next" alt="Next" title="Next">
			<img src="images/right-button.png">
			<!--  onClick = "nextQuestion(0)" -->
		</div>
		<div id="prev" alt="Prev" title="Prev">
			<img src="images/left-button.png">
		</div>

		<center>
			<div style="background: #E74C3C; width: 30%;">

				<%=level%>급
			</div>
		</center>

		<div id="slider">
			<%
				for (int i = 0; i < tmpArray1.length; i++) {
						tmpArray2 = tmpArray1[i].split("\\|");
						/* questionText += tmpArray2[0] + ","; */
			%>
			<div class="slide"
				<%if (i == 0)
						out.print("class = 'slide active' style='display: block;'");
					else
						out.print("class = 'slide' style='display: none;'");%>>
				<div class="firstBox">
					<div class="progress"
						style="position: absolute; top: 10px; left: 10px; width: 15%">

						<div class="progress-bar" role="progressbar" aria-valuenow="70"
							aria-valuemin="0" aria-valuemax="100"
							style="width: <%=(int) (((double) i + 1) / 20 * 100)%>%">
							<%=i + 1%>/20
						</div>
					</div>
					<%
						if (type.equals("word")) {
					%>
					<span style="line-height: 180px"><font size="24px"><%=tmpArray2[1]%></font></span>
					<%
						} else {
					%>
					<span style="line-height: 180px"><font size="24px"><%=tmpArray2[1]%></font></span>
					<%
						}
					%>
				</div>
				<hr color="#FBE1E1">
				<div class="SecondBox" style="z-index: 100; background: #8BC34A;"></div>
				<div width="100%" height="180px">

					<%
						ArrayList<String> answerList = new ArrayList<String>();

								int correctIndex = (int) random.nextInt(4);

								while (true) {
									if (type.equals("word")) {
										answerList.add(meaningPlateArray[random.nextInt(meaningPlateArray.length)]);
									} else {
										answerList.add(wordPlateArray[random.nextInt(wordPlateArray.length)]);
									}

									if (answerList.size() == 3)
										break;
								} //TODO:중복제거해주기

								int j;
								for (j = 0; j < answerList.size(); j++) {
									if (j == correctIndex) {

										if (type.equals("word")) {
					%>
					<button class="answerBtn<%=i%>"
						onclick="myFunction(<%=i%>, this.value, '<%=tmpArray2[2]%>')"
						value="<%=tmpArray2[2]%>"><%=tmpArray2[2]%></button>
					<%
						} else {
					%>
					<button class="answerBtn<%=i%>"
						onclick="myFunction(<%=i%>,this.value, '<%=tmpArray2[1]%>')"
						value="<%=tmpArray2[1]%>"><%=tmpArray2[1]%></button>
					<%
						}

										break;
									}
					%>
					<button class="answerBtn<%=i%>"
						onclick="myFunction(<%=i%>,this.value , '<%=tmpArray2[0]%>')"
						value="<%=answerList.get(j)%>"><%=answerList.get(j)%></button>
					<%
						}

								if (correctIndex == 3) {
									if (type.equals("word")) {
					%>
					<button class="answerBtn<%=i%>"
						onclick="myFunction(<%=i%>,this.value, '<%=tmpArray2[2]%>')"
						value="<%=tmpArray2[2]%>"><%=tmpArray2[2]%></button>
					<%
						} else {
					%>
					<button class="answerBtn<%=i%>"
						onclick="myFunction(<%=i%>,this.value, '<%=tmpArray2[1]%>')"
						value="<%=tmpArray2[1]%>"><%=tmpArray2[1]%></button>
					<%
						}

								} else {
									while (j < answerList.size()) {
					%>
					<button class="answerBtn<%=i%>"
						onclick="myFunction(<%=i%>,this.value, '<%=tmpArray2[0]%>')"
						value="<%=answerList.get(j)%>"><%=answerList.get(j)%></button>
					<%
						j += 1;
									}
								}
					%>
				</div>


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
	<form name="form1" method="post" action="result.jsp">
		<input type="hidden" name="wrong" value=" "> <input
			type="hidden" name="level" value="">
		<!-- <input type="hidden" name="type" value=""> -->
		<input type="hidden" name="score" value="0">
	</form>
	<script>
var solvedCnt = 0;
var score = 0;
var questionNum = 3; //문항수
<%-- document.form1.type.value = "<%= type %>"; --%>
document.form1.level.value = "<%=level%>";
function myFunction(itemIndex, boxValue, str) {
	solvedCnt++;
	if(boxValue == str){
		alert("정답");
		score += 5;
		document.form1.score.value = score;
	}
	else{
		alert("오답");
		document.form1.wrong.value +=  str + ",";
	}
	var className = "answerBtn" + itemIndex;
	  var elems = document.getElementsByClassName(className);
	    for(var i = 0; i < elems.length; i++) {
	    elems[i].disabled = true;
	     }
	    if(solvedCnt==questionNum){
	    	alert("끝");
	    	form1.submit();
	    	<%--  location.replace("result.jsp?type=<%=type%>" + "&score=" + score); --%>
	    	 
	    }
}

</script>
</body>
</html>