<template>
  <div class="home">
    <!-- <img alt="Vue logo" src="@/assets/logo.png" /> -->
    <main-content></main-content>
  </div>
</template>

<script>
// @ is an alias to /src
import MainContent from "@/components/MainContent.vue";
export default {
  name: "HomeView",
  components: {
    MainContent,
  },
  data() {
    return {
      // msg: "SSAFY에 오신것을 환경합니다.",
    };
  },
};
</script>
