<template>
  <section class="py-5">
    <div class="container px-5">
      <!-- Contact form-->
      <div class="bg-light rounded-3 py-5 px-4 px-md-5 mb-5">
        <div class="text-center mb-5">
          <div class="feature bg-primary bg-gradient text-white rounded-3 mb-3">
            <b-icon class="bi bi-envelope" icon="envelope"></b-icon>
          </div>
          <h1 class="fw-bolder">로그인</h1>
          <p class="lead fw-normal text-muted mb-0">계정이 없다면 회원가입을 해주세요</p>
        </div>
        <div class="row gx-5 justify-content-center">
          <b-button
            class="col-md-6 btn btn-primary btn-lg loginButton"
            variant="success"
            id="submitButton"
            type="submit"
            @click="naverLogin()"
          >
            네이버 로그인
          </b-button>
          <!-- <div id="naver_id_login"></div> -->
        </div>
        <br />
        <div class="row gx-5 justify-content-center">
          <b-button
            class="col-md-6 btn btn-primary btn-lg loginButton"
            variant="warning"
            id="submitButton"
            type="submit"
            @click="kakaoLogin()"
          >
            카카오 로그인
          </b-button>
        </div>
      </div>
      <!-- Contact cards-->
    </div>
  </section>
</template>

<script>
// import http from "@/api/http"
export default {
  data() {
    return {
      code: '',
    };
  },
  methods: {
    naverLogin() {
      var url =
        'https://nid.naver.com/oauth2.0/authorize?response_type=code&client_id=z_fHCg4xhYNzxnKo0u34&redirect_uri=http://localhost:9000/login/naver&state=state';
      window.location.replace(url);
    },
    kakaoLogin() {
      var url =
        'https://kauth.kakao.com/oauth/authorize?client_id=d5c5c9a40ef133e3e46dbbbf20b4c560&redirect_uri=http://localhost:9000/login/kakao&response_type=code';
      window.location.replace(url);
    },
  },
};
</script>

<style></style>
