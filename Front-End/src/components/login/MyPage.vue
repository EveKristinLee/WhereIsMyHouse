<template>
  <section class="py-5">
    <div class="container px-5">
      <!-- Contact form-->
      <div class="bg-light rounded-3 py-5 px-4 px-md-5 mb-5">
        <div class="text-center mb-5">
          <div class="feature bg-primary bg-gradient text-white rounded-3 mb-3">
            <b-icon class="bi bi-envelope" icon="envelope"></b-icon>
          </div>
          <h1 class="fw-bolder">마이 페이지</h1>
          <p class="lead fw-normal text-muted mb-0">내 정보</p>
        </div>
        <div class="row gx-5 justify-content-center">
          <div class="col-lg-8 col-xl-6">
            <!-- Id input-->
            <div class="form-floating mb-3">
              <input
                type="type"
                class="form-control"
                id="id"
                name="id"
                disabled
                :value="userInfo.email"
              />
              <label for="id">아이디</label>
            </div>
            <!-- Password input-->
            <div class="form-floating mb-3">
              <input
                class="form-control"
                id="domain"
                name="domain"
                type="type"
                :value="userInfo.domain"
                disabled
              />
              <label for="password">로그인 플랫폼</label>
            </div>
            <!-- Name input-->
            <div class="form-floating mb-3">
              <input
                class="form-control"
                id="name"
                name="name"
                type="text"
                :value="userInfo.name"
                disabled
              />
              <label for="name">이름</label>
            </div>

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
            <!-- logout Button-->
            <div class="row">
              <b-button
                @click="onClickLogout"
                class="col-md-5 btn btn-primary btn-lg updateFormButton"
                id="submitButton"
                type="submit"
              >
                로그아웃
              </b-button>
              <div class="col-md-2"></div>
              <button
                class="col-md-5 btn btn-primary btn-lg removeButton"
                id="resignButton"
                type="button"
                @click="doWithdraw"
              >
                탈퇴
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>

<script>
import http from '@/api/http';
import { mapState, mapActions, mapGetters } from 'vuex';
const memberStore = 'memberStore';

export default {
  data() {
    return {
      email: '',
      user: {
        email: null,
        name: null,
        domain: null,
        level: null,
      },
    };
  },
  computed: {
    ...mapState(memberStore, ['isLogin', 'userInfo']),
    ...mapGetters(['checkUserInfo']),
  },
  methods: {
    ...mapActions(memberStore, ['userConfirm', 'getUserInfo', 'userLogout']),
    onClickLogout() {
      this.userLogout(this.userInfo.email);
      sessionStorage.removeItem('access-token'); //저장된 토큰 없애기
      sessionStorage.removeItem('refresh-token'); //저장된 토큰 없애기
      if (this.$route.path != '/') this.$router.push({ name: 'home' });
    },
    doWithdraw() {
      var withdrawUser = this.userInfo.email;
      console.log("탈퇴할 회원 : ", withdrawUser)
      this.userLogout(withdrawUser);
      sessionStorage.removeItem('access-token');
      sessionStorage.removeItem('refresh-token');
      http.delete(`/user/${withdrawUser}`)
        .then(({data}) => {
          console.log("탈퇴 결과 : ", data)
          if (this.$route.path != '/') this.$router.push({ name: 'home' });
        })
    },
  },
  created() {
    // this.email = this.$route.params.email;
    // http.get(`user/info/${this.email}`, {
    //   headers: {}
    // }).then(({ data }) => {
    //   console.log('response', data);
    //   this.user = data;
    // });
  },
};
</script>
