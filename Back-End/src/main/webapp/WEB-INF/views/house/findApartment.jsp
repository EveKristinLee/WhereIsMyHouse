<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<%@ include file="../include/head.jsp"%>
<style>
a {
  color: inherit;
  text-decoration: none;
}
</style>
</head>
<body class="d-flex flex-column">
	<main class="flex-shrink-0"> <!-- Navigation--> <%@ include
		file="../include/nav.jsp"%> <!-- navigation end -->
	<div class="px-5 py-5 input-group"
		style="width: 1000px; margin: 0 auto;">
		<div class="input-group"
			style="display: flex; justify-content: center;">
			<h2 class="fw-bolder" style="display: inline">아파트명으로 검색</h2>
		</div>
		<form id="aptFindForm" class="px-5 py-5 input-group"
			action="${root}/aptFind.housedo">
			<input type="search" class="form-control rounded" id="aptName"
				name="aptName" placeholder="아파트를 검색하세요" aria-label="Search"
				aria-describedby="search-addon" />
			<button type="submit" id="apt-btn" class="btn btn-outline-primary">검색하기</button>
		</form>
	</div>

	<section id="contents">

		<!--  form 설정하기 -->
		<!-- 
		<form id="searchByaddress" method="get" action="">
		 -->
		<div class="container my-5">
			<table class="table table-hover" style="text-align: center; vertical-align: middle;">
				<thead>
					<tr>
						<th>아파트이름</th>
						<th>동 이름</th>
						<th>거래 금액</th>
						<th>면적</th>
						<th>거래 년도</th>
						<th>거래 월</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items='${aptList}' var='apt'>
						<tr>
							<td><b><a href="${root}/showHouseDetail.housedo?no=${apt.no}">${apt.aptName}</a></b></td>
							<td>${apt.dongName}</td>
							<td>${apt.dealAmount}</td>
							<td>${apt.area}</td>
							<td>${apt.dealYear}</td>
							<td>${apt.dealMonth}</td>
						</tr>
					</c:forEach>

				</tbody>
			</table>
		</div>
		<!--  pagination 처리 -->
		<div>

			<ul class="pagination justify-content-center">
				<c:if test="${currentPage != 1}">
					<li class="page-item"><a class="page-link"
						href="${root}/aptFind.housedo?aptName=${aptName}&page=1">&lt;&lt;</a></li>
				</c:if>
				<c:if test="${currentPage != 1}">
					<li class="page-item"><a class="page-link"
						href="${root}/aptFind.housedo?aptName=${aptName}&page=${currentPage - 1}">&lt;</a></li>
				</c:if>
				<!--  <c:forEach begin="1" end="${noOfPages}" var="i">
					<c:choose>
						<c:when test="${currentPage eq i}">
							<li class="page-item active"><a class="page-link"
								href="${root}/aptFind.housedo?aptName=${aptName}&page=${i}">${i}</a></li>
						</c:when>
						<c:otherwise>
							<li class="page-item"><a class="page-link"
								href="${root}/aptFind.housedo?aptName=${aptName}&page=${i}">${i}</a></li>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				 -->
				<c:forEach begin="${((currentPage-1-((currentPage-1)%5))/5)*5+1}" end="${((currentPage-1-((currentPage-1)%5))/5)*5+5 < noOfPages ? ((currentPage-1-((currentPage-1)%5))/5)*5+5 : noOfPages}" var="i">
					<c:choose>
						<c:when test="${currentPage eq i}">
							<li class="page-item active"><a class="page-link"
								href="${root}/aptFind.housedo?aptName=${aptName}&page=${i}">${i}</a></li>
						</c:when>
						<c:otherwise>
							<li class="page-item"><a class="page-link"
								href="${root}/aptFind.housedo?aptName=${aptName}&page=${i}">${i}</a></li>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				<c:if test="${currentPage lt noOfPages}">
					<li class="page-item"><a class="page-link"
						href="${root}/aptFind.housedo?aptName=${aptName}&page=${currentPage+1}">&gt;</a></li>
				</c:if>
				<c:if test="${currentPage != noOfPages}">
					<li class="page-item"><a class="page-link"
						href="${root}/aptFind.housedo?aptName=${aptName}&page=${noOfPages}">&gt;&gt;</a></li>
				</c:if>
			</ul>
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
		///////////////////////// select box 설정 (지역, 매매기간) /////////////////////////
	</script>
</body>
</html>
