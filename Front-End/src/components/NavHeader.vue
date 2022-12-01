<template>
  <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container px-5">
      <router-link class="navbar-brand" to="/">Where Is My House</router-link>
      <b-navbar toggleable type="dark" variant="dark">
        <b-navbar-toggle target="navbar-toggle-collapse">
          <template #default="{ expanded }">
            <b-icon v-if="expanded" icon="chevron-bar-up"></b-icon>
            <b-icon v-else icon="chevron-bar-down"></b-icon>
          </template>
        </b-navbar-toggle>

        <b-collapse id="navbar-toggle-collapse" is-nav>
          <!-- after login -->
          <b-navbar-nav class="ml-auto" v-if="userInfo">
            <b-nav-item class="align-self-center link" v-if="userInfo.level != 'admin'">
              <router-link class="nav-link" to="/mypage">
                <b-avatar
                  variant="primary"
                  v-text="userInfo.email.charAt(0).toUpperCase()"
                ></b-avatar>
                {{ userInfo.name }}({{ userInfo.email }})님 환영합니다.
              </router-link>
            </b-nav-item>
            <b-nav-item class="align-self-center link" v-else>
              <router-link class="nav-link" to="/mypage">
                <b-avatar
                  variant="primary"
                  v-text="userInfo.email.charAt(0).toUpperCase()"
                ></b-avatar>
                {{ userInfo.name }}({{ userInfo.email }})(관리자)님 환영합니다.
              </router-link>
            </b-nav-item>
            <b-nav-item class="align-self-center link"
              ><router-link class="nav-link" to="/favorite">관심지역</router-link></b-nav-item
            >
            <b-nav-item class="align-self-center link" @click.prevent="onClickLogout"
              >로그아웃</b-nav-item
            >
            <b-nav-item class="align-self-center link"
              ><router-link class="nav-link" to="/question">Q&A</router-link></b-nav-item
            >
            <b-nav-item-dropdown class="align-self-center link" text="실거래가 조회" right>
              <b-dropdown-item href="/dong">동별 조회</b-dropdown-item>
              <b-dropdown-item href="/apartment">아파트별 조회</b-dropdown-item>
            </b-nav-item-dropdown>
          </b-navbar-nav>
          <!-- after login -->
          <!-- before login -->
          <b-navbar-nav class="ml-auto" v-else>
            <b-nav-item><router-link class="nav-link" to="/login">로그인</router-link></b-nav-item>
          </b-navbar-nav>
          <!-- before login -->
        </b-collapse>
      </b-navbar>

      <!--
			<button
        class="navbar-toggler"
        type="button"
        data-bs-toggle="collapse"
        data-bs-target="#navbarSupportedContent"
        aria-controls="navbarSupportedContent"
        aria-expanded="false"
        aria-label="Toggle navigation"
      >
        <span class="navbar-toggler-icon"></span>
      </button>
			
      <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
          <li class="nav-item"><router-link class="nav-link" to="/">Home</router-link></li>
          <li class="nav-item"><router -link class="nav-link" to="/question">QnA</router></li>
          유저 로그인 여부에 따라 관심지역. 마이페이지. 로그아웃 메뉴 추가되어야함
          <c:choose>
            <c:when test="${empty userInfo}">
              <li class="nav-item"><a class="nav-link" href="${root}/user/login">로그인</a></li>
              <li class="nav-item"><a class="nav-link" href="${root}/user/signup">회원가입</a></li>
            </c:when>
            <c:otherwise>
              <li class="nav-item">
                <a class="nav-link" href="${root}/house/favorite?id=${userInfo.id}">관심지역</a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="${root}/user/userinfo?id=${userInfo.id}">마이 페이지</a>
              </li>
              <li class="nav-item"><a class="nav-link" href="${root}/user/logout">로그아웃</a></li>

              <li class="nav-item dropdown">
                <a
                  class="nav-link dropdown-toggle"
                  id="navbarDropdownBlog"
                  href="#"
                  role="button"
                  data-bs-toggle="dropdown"
                  aria-expanded="false"
                  >실거래가 조회</a
                >
                <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdownBlog">
                  <li><a class="dropdown-item" href="${root}/house/dongfindform">동별 조회</a></li>
                  <li>
                    <a class="dropdown-item" href="${root}/house/aptfindform">아파트별 조회</a>
                  </li>
                </ul>
              </li>
            </c:otherwise>
          </c:choose>
        </ul>
      </div> -->
    </div>
  </nav>
</template>

<script>
import { mapState, mapGetters, mapActions } from 'vuex';

const memberStore = 'memberStore';
export default {
  data() {
    return {};
  },
  computed: {
    ...mapState(memberStore, ['isLogin', 'userInfo']),
    ...mapGetters(['checkUserInfo']),
  },
  methods: {
    ...mapActions(memberStore, ['userLogout']),
    // ...mapMutations(memberStore, ["SET_IS_LOGIN", "SET_USER_INFO"]),
    onClickLogout() {
      // this.SET_IS_LOGIN(false);
      // this.SET_USER_INFO(null);
      // sessionStorage.removeItem("access-token");
      // if (this.$route.path != "/") this.$router.push({ name: "main" });

      console.log(this.userInfo.email);
      //vuex actions에서 userLogout 실행(Backend에 저장 된 리프레시 토큰 없애기
      //+ satate에 isLogin, userInfo 정보 변경)
      // this.$store.dispatch("userLogout", this.userInfo.userid);
      this.userLogout(this.userInfo.email);
      sessionStorage.removeItem('access-token'); //저장된 토큰 없애기
      sessionStorage.removeItem('refresh-token'); //저장된 토큰 없애기
      if (this.$route.path != '/') this.$router.push({ name: 'home' });
    },
  },
};
</script>
