<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <%@ include file="../include/head.jsp" %>
  </head>
  <body class="d-flex flex-column">
    <main class="flex-shrink-0">
      <!-- Navigation-->
      <%@ include file="../include/nav.jsp" %>
      <!-- navigation end -->

      <!-- Page content-->
      <section class="py-5">
        <div class="container px-5">
          <!-- Contact form-->
          <div class="bg-light rounded-3 py-5 px-4 px-md-5 mb-5">
            <div class="text-center mb-5">
              <div class="feature bg-primary bg-gradient text-white rounded-3 mb-3">
                <i class="bi bi-envelope"></i>
              </div>
              <h1 class="fw-bolder">마이 페이지</h1>
              <p class="lead fw-normal text-muted mb-0">정보 수정</p>
            </div>
            <div class="row gx-5 justify-content-center">
              <div class="col-lg-8 col-xl-6">
                <!-- * * * * * * * * * * * * * * *-->
                <!-- * * SB Forms Contact Form * *-->
                <!-- * * * * * * * * * * * * * * *-->
                <!-- This form is pre-integrated with SB Forms.-->
                <!-- To make this form functional, sign up at-->
                <!-- https://startbootstrap.com/solution/contact-forms-->
                <!-- to get an API token!-->
                <form id="userUpdateForm" data-sb-form-api-token="API_TOKEN">
                  <!-- Id input-->
                  <div class="form-floating mb-3">
                    <input
                      class="form-control"
                      id="id"
                      name="id"
                      type="text"
                      value="${userInfo.id}"
                      readonly
                    />
                    <label for="id">아이디</label>
                  </div>
                  <!-- Password input-->
                  <div class="form-floating mb-3">
                    <input
                      class="form-control"
                      id="password"
                      name="password"
                      type="password"
                      value="${userInfo.password}"
                    />
                    <label for="password">비밀번호</label>
                  </div>
                  <!-- Name input-->
                  <div class="form-floating mb-3">
                    <input
                      class="form-control"
                      id="name"
                      name="name"
                      type="text"
                      value="${userInfo.name}"
                    />
                    <label for="name">이름</label>
                  </div>
                  <!-- Email address input-->
                  <div class="form-floating mb-3">
                    <input
                      class="form-control"
                      id="email"
                      name="email"
                      type="email"
                      value="${userInfo.email}"
                    />
                    <label for="email">이메일 주소</label>
                  </div>
                  <!-- Submit success message-->
                  <!---->
                  <!-- This is what your users will see when the form-->
                  <!-- has successfully submitted-->
                  <div class="d-none" id="submitSuccessMessage">
                    <div class="text-center mb-3">
                      <div class="fw-bolder">Form submission successful!</div>
                      To activate this form, sign up at
                      <br />
                      <a href="https://startbootstrap.com/solution/contact-forms"
                        >https://startbootstrap.com/solution/contact-forms</a
                      >
                    </div>
                  </div>
                  <!-- Submit error message-->
                  <!---->
                  <!-- This is what your users will see when there is-->
                  <!-- an error submitting the form-->
                  <div class="d-none" id="submitErrorMessage">
                    <div class="text-center text-danger mb-3">Error sending message!</div>
                  </div>
                  <!-- Submit Button-->
                  <div class="row">
                    <button class="col-md-6 btn btn-primary btn-lg updateButton" id="submitButton" type="submit">
                      	수정 완료
                    </button>

                    <button class="col-md-6 btn btn-primary btn-lg cancelButton" id="resignButton" type="button">
                     	 수정 취소
                    </button>
                  </div>
                </form>
              </div>
            </div>
          </div>
        </div>
      </section>
    </main>
    <!-- Footer-->
    <footer class="bg-dark py-4 mt-auto">
      <div class="container px-5">
        <div class="row align-items-center justify-content-between flex-column flex-sm-row">
          <div class="col-auto">
            <div class="small m-0 text-white">Copyright &copy; Your Website 2022</div>
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
    <script src="../js/scripts.js"></script>
    <!-- * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *-->
    <!-- * *                               SB Forms JS                               * *-->
    <!-- * * Activate your form at https://startbootstrap.com/solution/contact-forms * *-->
    <!-- * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *-->
    <script src="https://cdn.startbootstrap.com/sb-forms-latest.js"></script>
    <script>
    document.querySelector(".updateButton").addEventListener("click", function () {
    	  let form = document.getElementById("userUpdateForm");
    	  form.action = "${root}/userUpdate.userdo?id=${userInfo.id}";
    	  form.submit();
      });
    document.querySelector(".cancelButton").addEventListener("click", function () {
  	  let form = document.getElementById("userUpdateForm");
  	  form.action = "${root}/userCancel.userdo";
  	  form.submit();
    });
    </script>
  </body>
</html>
