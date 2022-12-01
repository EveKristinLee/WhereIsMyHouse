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
    <script type="text/javascript"
        src="//dapi.kakao.com/v2/maps/sdk.js?appkey=0afafdc14a9a6b14c24b0c7d8dddad1e"></script>
    <main class="flex-shrink-0"> <!-- Navigation--> <%@ include
        file="../include/nav.jsp"%> <!-- navigation end -->
    <div class="px-5 py-5 input-group" style="width:1000px; margin:0 auto;">
    	<div class="input-group" style="display: flex; justify-content:center;">
			<h2 class="fw-bolder" style="display:inline">동으로 검색</h2>
		</div>
	</div>
    <div class="container">
        <div style="height: 70px"></div>
        <form id="form-findByDong" action="${root}/dongFind.housedo">
            <div class="row col-md-12 justify-content-center mb-2">
                <div class="form-group col-md-3">
                    <select class="form-select bg-secondary text-light" id="sido">
                        <option value="">시도선택</option>
                    </select>
                </div>
                <div class="form-group col-md-3">
                    <select class="form-select bg-secondary text-light" id="gugun">
                        <option value="">구군선택</option>
                    </select>
                </div>
                <div class="form-group col-md-3">
                    <select class="form-select bg-secondary text-light" name="dongCode"
                        id="dong">
                        <option value="">동선택</option>
                    </select>
                </div>
                <button type="submit" id="list-btn"
                    class="btn btn-outline-primary form-group col-md-3">검색하기</button>

            </div>
        </form>
        <hr>
        <!-- style="display: none" -->
        <section class="py-5" id="contents">
            <div class="container my-5">
            	<c:if test="${!empty dongCode}">
					<div style="display: flex; justify-content : center;">
						<span><h4 class="fw-bolder" style="display:inline; color:LightSlateGray">${addressName}</h4></span>
						&nbsp;&nbsp;
						<c:choose>
							<c:when test="${!empty isFav}">
								<form action="${root}/removeFavorite.userdo">
								<input type="hidden" name="dongCode" value="${dongCode}"/>
									<button type="submit" id="FavButton" class="btn btn-outline-primary form-group col-md-3" 
									style="vertical-align: middle; background: url('${root}/img/Fav.png') no-repeat; width: 25px; height: 25px; border: none;"></button>
								</form>
							</c:when>
							<c:otherwise>
								<form action="${root}/addFavorite.userdo">
									<input type="hidden" name="dongCode" value="${dongCode}"/>
									<button type="submit" id="FavButton" class="btn btn-outline-primary form-group col-md-3" 
									style="vertical-align: middle; background: url('${root}/img/notFav.png') no-repeat; width: 25px; height: 25px; border: none;"></button>
								</form>
							</c:otherwise>
						</c:choose>
					</div>
					<br><br>
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

							<c:forEach items='${houseList}' var='house'>
								<tr>
									<td><b><a href="${root}/showHouseDetail.housedo?no=${house.no}">${house.aptName}</a></b></td>
									<td>${house.dongName}</td>
									<td>${house.dealAmount}</td>
									<td>${house.area}</td>
									<td>${house.dealYear}</td>
									<td>${house.dealMonth}</td>
								</tr>
							</c:forEach>


						</tbody>
					</table></div>
            		<div>

			<ul class="pagination justify-content-center">
				<c:if test="${currentPage != 1}">
					<li class="page-item"><a class="page-link"
						href="${root}/dongFind.housedo?dongCode=${dongCode}&page=1">&lt;&lt;</a></li>
				</c:if>
				<c:if test="${currentPage != 1}">
					<li class="page-item"><a class="page-link"
						href="${root}/dongFind.housedo?dongCode=${dongCode}&page=${currentPage - 1}">&lt;</a></li>
				</c:if>
				<c:forEach begin="${((currentPage-1-((currentPage-1)%5))/5)*5+1}" end="${((currentPage-1-((currentPage-1)%5))/5)*5+5 < noOfPages ? ((currentPage-1-((currentPage-1)%5))/5)*5+5 : noOfPages}" var="i">
					<c:choose>
						<c:when test="${currentPage eq i}">
							<li class="page-item active"><a class="page-link"
								href="${root}/dongFind.housedo?dongCode=${dongCode}&page=${i}">${i}</a></li>
						</c:when>
						<c:otherwise>
							<li class="page-item"><a class="page-link"
								href="${root}/dongFind.housedo?dongCode=${dongCode}&page=${i}">${i}</a></li>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				<c:if test="${currentPage lt noOfPages}">
					<li class="page-item"><a class="page-link"
						href="${root}/dongFind.housedo?dongCode=${dongCode}&page=${currentPage+1}">&gt;</a></li>
				</c:if>
				<c:if test="${currentPage != noOfPages}">
					<li class="page-item"><a class="page-link"
						href="${root}/dongFind.housedo?dongCode=${dongCode}&page=${noOfPages}">&gt;&gt;</a></li>
				</c:if>
			</ul>
		</div>
            
            
            </form>
            </c:if>
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
    


    <!-- proxy server -->
    <script>
      ///////////////////////// select box 설정 (지역, 매매기간) /////////////////////////
      let date = new Date();
      var dongName = '';
      var map;
      // 드롭다운 메뉴 월 범위 설정하는거 (22년도는 지나간 8월까지만 체크해주는거)
      window.onload = function () {
        sendRequest("sido", "*00000000");
      };

      document.querySelector("#sido").addEventListener("change", function () {
        if (this[this.selectedIndex].value) {
          let regcode = this[this.selectedIndex].value.substr(0, 2) + "*00000";
          sendRequest("gugun", regcode);
        } else {
          initOption("gugun");
          initOption("dong");
        }
      });

      // 구군이 바뀌면 동정보 얻기.
      document.querySelector("#gugun").addEventListener("change", function () {
        if (this[this.selectedIndex].value) {
          let regcode = this[this.selectedIndex].value.substr(0, 5) + "*";
          sendRequest("dong", regcode);
        } else {
          initOption("dong");
        }
      });

      // 프록시서버로 지역별 선택지 받아올 수 있음
      function sendRequest(selid, regcode) {
        const url = "https://grpc-proxy-server-mkvo6j4wsq-du.a.run.app/v1/regcodes";
        let params = "regcode_pattern=" + regcode + "&is_ignore_zero=true";
        fetch(`\${url}?\${params}`)
          .then((response) => response.json())
          .then((data) => addOption(selid, data));
      }

      function addOption(selid, data) {
        let opt = ``;
        var dongName;
        initOption(selid);
        switch (selid) {
          case "sido":
            opt += `<option value="">시도선택</option>`;
            data.regcodes.forEach(function (regcode) {
              opt += `
              <option value="\${regcode.code}">\${regcode.name}</option>
              `;
              
            });
            break;
          case "gugun":
            opt += `<option value="">구군선택</option>`;
            for (let i = 0; i < data.regcodes.length; i++) {
              if (i != data.regcodes.length - 1) {
                if (
                  data.regcodes[i].name.split(" ")[1] == data.regcodes[i + 1].name.split(" ")[1] &&
                  data.regcodes[i].name.split(" ").length !=
                    data.regcodes[i + 1].name.split(" ").length
                ) {
                  data.regcodes.splice(i, 1);
                  i--;
                }
              }
            }
            let name = "";
            data.regcodes.forEach(function (regcode) {
              if (regcode.name.split(" ").length == 2) name = regcode.name.split(" ")[1];
              else name = regcode.name.split(" ")[1] + " " + regcode.name.split(" ")[2];
              opt += `
              <option value="\${regcode.code}">\${name}</option>
              `;
            });
            break;
          case "dong":
            opt += `<option value="">동선택</option>`;
            let idx = 2;
            data.regcodes.forEach(function (regcode) {
              if (regcode.name.split(" ").length != 3) idx = 3;
              opt += `
              <option value="\${regcode.code}">\${regcode.name.split(" ")[idx]}</option>
              `;
            });
        }
        document.querySelector(`#\${selid}`).innerHTML = opt;
        
      }

      function initOption(selid) {
        let options = document.querySelector(`#\${selid}`);
        options.length = 0;

      }

      ///////////////////////// 아파트 매매 정보 /////////////////////////

      function initTable() {
        let tbody = document.querySelector("#aptlist");
        let len = tbody.rows.length;
        for (let i = len - 1; i >= 0; i--) {
          tbody.deleteRow(i);
        }
      }


    </script>
</body>
</html>