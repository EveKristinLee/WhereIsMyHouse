<template>
  <div class="login">
    <!-- <img alt="Vue logo" src="@/assets/logo.png" /> -->
    <login-content></login-content>
  </div>
</template>

<script>
// @ is an alias to /src
import LoginContent from '@/components/login/LoginContent.vue';
export default {
  name: 'LoginView',
  components: {
    LoginContent,
  },
  data() {
    return {
      // msg: "SSAFY에 오신것을 환경합니다.",
    };
  },
};
</script>
