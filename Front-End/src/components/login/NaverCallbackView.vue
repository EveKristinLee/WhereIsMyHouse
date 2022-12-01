<template>
  <div>
    <h2>네이버 로그인 진행중입니다.</h2>
    <div id="naver_id_login"></div>
  </div>
</template>

<script>
import http from '@/api/http';
import { mapState, mapActions } from 'vuex';
const memberStore = 'memberStore';
export default {
  name: 'UserLogin',
  data() {
    return {
      user: {
        email: null,
        name: null,
        domain: null,
        level: null,
      },
    };
  },
  computed: {
    ...mapState(memberStore, ['isLogin', 'isLoginError', 'userInfo']),
  },
  methods: {
    ...mapActions(memberStore, ['userConfirm', 'getUserInfo']),
  },
  mounted() {
    // let url = "https://nid.naver.com/oauth2.0/token?grant_type=authorization_code"+
    //           "&client_id=z_fHCg4xhYNzxnKo0u34&client_secret=5se1vSl5A7"+
    //           "&code="+ this.$route.query.code +
    //           "&state=" + this.$route.query.state;
    // window.location.replace(url);
    console.log('code=============>', this.$route.query.code);
    http
      .get('/login/naver', {
        params: { code: this.$route.query.code },
      })
      .then((data) => {
        console.log('user=============>', data.data);
        console.log('useremail==========>', data.data.email);
        this.user.email = data.data.email;
        this.user.name = data.data.name;
        this.user.domain = data.data.domain;
        this.user = data.data;
        const a = async () => {
          await this.userConfirm(this.user);
          let token = sessionStorage.getItem('access-token');
          console.log('1. confirm() token >> ' + token);
          if (this.isLogin) {
            await this.getUserInfo(token);
            console.log('4. confirm() userInfo :: ', this.userInfo);
            this.$router.push({ name: 'home' });
          }
        };
        a();
      });
  },
};
</script>

<style></style>
