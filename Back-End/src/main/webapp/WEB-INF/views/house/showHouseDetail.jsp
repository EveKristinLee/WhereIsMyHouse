<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<%@ include file="../include/head.jsp" %>
</head>
<body class="d-flex flex-column">
	<script
    	type="text/javascript"
    	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=0afafdc14a9a6b14c24b0c7d8dddad1e"
  	></script>
	<main class="flex-shrink-0"> 
	<!-- Navigation-->
	<%@ include file="../include/nav.jsp" %>
	<!-- navigation end -->
	<div class="px-5 py-5 input-group" style="width:1000px; margin:0 auto;">
		<div class="input-group" style="display: flex; justify-content:center;">
			<h2 class="fw-bolder" style="display:inline">거래 정보 보기</h2>
		</div>
	</div>

	<section id="contents">

		<!--  form 설정하기 -->
		<!-- 
		<form id="searchByaddress" method="get" action="">
		 -->
		<div class="row">
		<div class="col-2"></div>
		<div class="container my-5 col-3" style="float: left">
			<table class="table table-hover" style="text-align:center; vertical-align : middle; height:400px">
				<thead>
					<tr>
						<th colspan="2"><h4>${house.aptName}</h4></th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td><b>동 이름</b></td>
						<td>${house.dongName}</td>
					</tr>
					<tr>
						<td><b>거래 금액</b></td>
						<td>${house.dealAmount}</td>
					</tr>
					<tr>
						<td><b>면적</b></td>
						<td>${house.area}</td>
					</tr>
					<tr>
						<td><b>층수</b></td>
						<td>${house.floor}</td>
					</tr>
					<tr>
						<td><b>지번</b></td>
						<td>${house.jibun}</td>
					</tr>
					<tr>
						<td><b>건축년도</b></td>
						<td>${house.buildYear}</td>
					</tr>
					<tr>
						<td><b>거래 일자</b></td>
						<td>${house.dealYear}/${house.dealMonth}/${house.dealDay}</td>
					</tr>
				</tbody>
			</table>
		</div>
		<div id="map" class="col-5">
			
		</div>
		<div class="col-2"></div>
		</div>
	</section>
	</main>

	<!-- Footer-->
	<footer class="bg-dark py-4 mt-auto">
		<div class="container px-5">
			<div
				class="row align-items-center justify-content-between flex-column flex-sm-row">
				<div class="col-auto">
					<div class="small m-0 text-white">Copyright &copy; SSAFY 2022</div>
				</div>
				<div class="col-auto">
					<a class="link-light small" href="#!">Privacy</a> <span
						class="text-white mx-1">&middot;</span> <a
						class="link-light small" href="#!">Terms</a> <span
						class="text-white mx-1">&middot;</span> <a
						class="link-light small" href="#!">Contact</a>
				</div>
			</div>
		</div>
	</footer>
	<!-- Bootstrap core JS-->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	<!-- Core theme JS-->
	<script src="../js/scripts.js"></script>


	<!-- proxy server -->
	<script>
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    	mapOption = { 
        	center: new kakao.maps.LatLng(${house.lat}, ${house.lng}), // 지도의 중심좌표
        	level: 2 // 지도의 확대 레벨
    	};

		// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
		var map = new kakao.maps.Map(mapContainer, mapOption); 
		
		// 마커가 표시될 위치입니다 
		var markerPosition  = new kakao.maps.LatLng(${house.lat}, ${house.lng}); 

		// 마커를 생성합니다
		var marker = new kakao.maps.Marker({
		    position: markerPosition
		});

		// 마커가 지도 위에 표시되도록 설정합니다
		marker.setMap(map);
		
		var iwContent = '<div style="padding:5px; text-align:center">거래 금액<br>${house.dealAmount}</div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
	    iwPosition = new kakao.maps.LatLng(${house.lat}, ${house.lng}); //인포윈도우 표시 위치입니다

		// 인포윈도우를 생성합니다
		var infowindow = new kakao.maps.InfoWindow({
	    	position : iwPosition, 
	    	content : '<span class="info-title" style="display: block;background: #50627F;color: #fff;text-align: center;height: 24px;line-height:22px;border-radius:4px;padding:0px 10px;">${house.dealAmount}</span>'
		});
	  
		// 마커 위에 인포윈도우를 표시합니다. 두번째 파라미터인 marker를 넣어주지 않으면 지도 위에 표시됩니다
		infowindow.open(map, marker); 
		
		var infoTitle = document.querySelectorAll('.info-title');
		infoTitle.forEach(function(e) {
		    var w = e.offsetWidth + 10;
		    var ml = w/2;
		    e.parentElement.style.top = "82px";
		    e.parentElement.style.left = "50%";
		    e.parentElement.style.marginLeft = -ml+"px";
		    e.parentElement.style.width = w+"px";
		    e.parentElement.previousSibling.style.display = "none";
		    e.parentElement.parentElement.style.border = "0px";
		    e.parentElement.parentElement.style.background = "unset";
		});
	</script>
</body>
</html>
