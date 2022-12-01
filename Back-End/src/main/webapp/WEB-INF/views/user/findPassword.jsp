<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
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
              <h1 class="fw-bolder">비밀번호 찾기</h1>
              <p class="lead fw-normal text-muted mb-0">아이디, 이름, 이메일을 입력해주세요</p>
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
                <form id="findPassForm" data-sb-form-api-token="API_TOKEN">
				  <!-- Id input-->
                  <div class="form-floating mb-3">
                    <input
                      class="form-control"
                      id="id"
                      name="id"
                      type="text"
                      placeholder="아이디 입력"
                      data-sb-validations="required"
                    />
                    <label for="id">아이디</label>
                    <div class="invalid-feedback" data-sb-feedback="id:required">
                      	아이디 입력은 필수입니다!
                    </div>
                  </div>
                  <!-- Name input-->
                  <div class="form-floating mb-3">
                    <input
                      class="form-control"
                      id="name"
                      name="name"
                      type="text"
                      placeholder="이름 입력"
                      data-sb-validations="required"
                    />
                    <label for="name">이름</label>
                    <div class="invalid-feedback" data-sb-feedback="name:required">
                      	이름 입력은 필수입니다!
                    </div>
                  </div>
                  <!-- Email address input-->
                  <div class="form-floating mb-3">
                    <input
                      class="form-control"
                      id="email"
                      name="email"
                      type="email"
                      placeholder="name@example.com"
                      data-sb-validations="required,email"
                    />
                    <label for="email">이메일 주소</label>
                    <div class="invalid-feedback" data-sb-feedback="email:required">
                      	이메일 입력은 필수입니다! 
                    </div>
                    <div class="invalid-feedback" data-sb-feedback="email:email">
                     	 올바른 이메일 형식이 아닙니다!
                    </div>
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
                  <div class="d-grid">
                    <button
                      class="btn btn-primary btn-lg disabled findPassButton"
                      id="submitButton"
                      type="submit"
                    >
                      	비밀번호 찾기
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
    <script src="../js/scripts.js"></script>
    <!-- * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *-->
    <!-- * *                               SB Forms JS                               * *-->
    <!-- * * Activate your form at https://startbootstrap.com/solution/contact-forms * *-->
    <!-- * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *-->
    <script src="https://cdn.startbootstrap.com/sb-forms-latest.js"></script>
    <script>
      // signup click
      document.querySelector(".findPassButton").addEventListener("click", function () {
    	  let form = document.getElementById("findPassForm");
    	  form.action = "${root}/findPassword.userdo"
    	  form.submit();
      });
    </script>
  </body>
</html>
