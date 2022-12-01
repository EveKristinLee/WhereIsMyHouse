<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <%@ include file="/WEB-INF/views/include/head.jsp" %>
  </head>
  <body class="d-flex flex-column h-100">
    <main class="flex-shrink-0">
      <!-- Navigation-->
      <%@ include file="/WEB-INF/views/include/nav.jsp" %>
      <!-- navigation end -->

      <!-- Header-->
      <header class="bg-dark py-5">
        <div class="container px-5">
          <div class="row gx-5 align-items-center justify-content-center">
            <div class="col-lg-8 col-xl-7 col-xxl-6">
              <div class="my-5 text-center text-xl-start">
                <h1 class="display-5 fw-bolder text-white mb-2">100세 인생 내 집 마련하기</h1>
                <p class="lead fw-normal text-white-50 mb-4">
                  이번생에 서울에서 내 집 마련 가능할까요?
                </p>
                <div
                  class="d-grid gap-3 d-sm-flex justify-content-sm-center justify-content-xl-start"
                >
                  <a class="btn btn-primary btn-lg px-4 me-sm-3" href="#features">공지사항 보기</a>
                </div>
              </div>
            </div>
            <div class="col-xl-5 col-xxl-6 d-none d-xl-block text-center">
              <img class="img-fluid rounded-3 my-5" src="img/img3.jpg" alt="..." />
            </div>
          </div>
        </div>
      </header>
      <!-- Features section-->
      <section class="py-5" id="features">
        <div class="container px-5 my-5">
          <div class="row gx-5">
            <div class="col-lg-4 mb-5 mb-lg-0">
              <h2 class="fw-bolder mb-0">공지사항</h2>
            </div>
            <div class="col-lg-8">
              <div class="row gx-5 row-cols-1 row-cols-md-2">
                <div class="col mb-5 h-100">
                  <div class="feature bg-primary bg-gradient text-white rounded-3 mb-3">
                    <i class="bi bi-collection"></i>
                  </div>
                  <h2 class="h5">2022-09-07 리뉴얼 기념</h2>
                  <p class="mb-0">지금 가입하시면 혜택이 빵빵!</p>
                </div>
                <div class="col mb-5 h-100">
                  <div class="feature bg-primary bg-gradient text-white rounded-3 mb-3">
                    <i class="bi bi-building"></i>
                  </div>
                  <h2 class="h5">2022-09-06 기능 추가</h2>
                  <p class="mb-0">관심지역 기능 업데이트.</p>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>
      <!-- Testimonial section-->

      <!-- Blog preview section-->
    </main>
    <!-- Footer-->
    <footer class="bg-dark py-4 mt-auto">
      <div class="container px-5">
        <div class="row align-items-center justify-content-between flex-column flex-sm-row">
          <div class="col-auto">
            <div class="small m-0 text-white">Copyright &copy; SSAFY 2022</div>
          </div>
          <div class="col-auto">
            <a class="link-light small" href="#!">Privacy</a>
            <span class="text-white mx-1">&middot;</span>
            <a class="link-light small" href="#!">Terms</a>
            <span class="text-white mx-1">&middot;</span>
            <a class="link-light small" href="#!">Contact</a>
          </div>
        </div>
      </div>
    </footer>
    <!-- Bootstrap core JS-->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <!-- Core theme JS-->
    <script src="/WEB-INF/views/js/scripts.js"></script>
  </body>
</html>
