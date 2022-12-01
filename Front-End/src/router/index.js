import Vue from "vue";
import VueRouter from "vue-router";
import HomeView from "@/views/HomeView.vue";
import LoginView from "@/views/LoginView.vue";
import QuestionView from "@/views/QuestionView.vue";
import QuestionListView from "@/components/question/QuestionListView.vue";
import QuestionRegistView from "@/components/question/QuestionRegistView.vue";
import QuestionDetailView from "@/components/question/QuestionDetailView.vue";
import QuestionModifyView from "@/components/question/QuestionModifyView.vue";
import QuestionReplyView from "@/components/question/QuestionReplyView.vue";
import NaverCallbackView from "@/components/login/NaverCallbackView";
import KakaoCallbackView from "@/components/login/KakaoCallbackView";
// dong, apt 경로 수정 필요
import SearchDongView from "@/views/SearchDongView.vue";
import SearchAptView from "@/views/SearchAptView.vue";
import Favorite from "@/views/FavoriteView.vue";
import SearchDetailView from "@/views/SearchDetailView.vue";
// 마이페이지 경로 추가
import MyPageView from "@/views/MyPageView.vue";
import store from "@/store";

Vue.use(VueRouter);

// https://v3.router.vuejs.org/kr/guide/advanced/navigation-guards.html
const onlyAuthUser = async (to, from, next) => {
  const checkUserInfo = store.getters["memberStore/checkUserInfo"];
  const checkToken = store.getters["memberStore/checkToken"];
  let token = sessionStorage.getItem("access-token");
  console.log("로그인 처리 전", checkUserInfo, token);

  if (checkUserInfo != null && token) {
    console.log("토큰 유효성 체크하러 가자!!!!");
    await store.dispatch("memberStore/getUserInfo", token);
  }
  if (!checkToken || checkUserInfo === null) {
    alert("로그인이 필요한 페이지입니다..");
    // next({ name: "login" });
    router.push({ name: "login" });
  } else {
    console.log("로그인 했다!!!!!!!!!!!!!.");
    next();
  }
};

const routes = [
  {
    path: "/",
    name: "home",
    component: HomeView,
  },
  {
    path: "/login",
    name: "login",
    component: LoginView,
  },
  {
    path: "/login/naver",
    name: "naverCallback",
    component: NaverCallbackView,
  },
  {
    path: "/login/kakao",
    name: "kakaoCallback",
    component: KakaoCallbackView,
  },
  {
    path: "/dong",
    name: "searchDongView",
    beforeEnter: onlyAuthUser,
    component: SearchDongView,
  },
  {
    path: "/apartment",
    name: "searchAptView",
    beforeEnter: onlyAuthUser,
    component: SearchAptView,
  },
  {
    path: "/favorite",
    name: "favorite",
    beforeEnter: onlyAuthUser,
    component: Favorite,
  },
  {
    path: "/detail",
    name: "SearchDetailView",
    beforeEnter: onlyAuthUser,
    component: SearchDetailView,
  },
  {
    path: "/question",
    name: "QuestionView",
    component: QuestionView,
    beforeEnter: onlyAuthUser,
    redirect: "/question/questionlist",
    children: [
      {
        path: "questionlist",
        name: "QuestionListView",
        beforeEnter: onlyAuthUser,
        component: QuestionListView,
      },
      {
        path: "questionregist",
        name: "QuestionRegistView",
        beforeEnter: onlyAuthUser,
        component: QuestionRegistView,
      },
      {
        path: "questiondetail",
        name: "QuestionDetailView",
        beforeEnter: onlyAuthUser,
        component: QuestionDetailView,
      },
      {
        path: "questionmodify",
        name: "QuestionModifyView",
        beforeEnter: onlyAuthUser,
        component: QuestionModifyView,
      },
      {
        path: "questionreply",
        name: "QuestionReplyView",
        beforeEnter: onlyAuthUser,
        component: QuestionReplyView,
      },
    ],
  },
  {
    path: "/mypage",
    name: "MyPageView",
    beforeEnter: onlyAuthUser,
    component: MyPageView,
  },
  {
    path: "/about",
    name: "about",
    // route level code-splitting
    // this generates a separate chunk (about.[hash].js) for this route
    // which is lazy-loaded when the route is visited.
    component: () =>
      import(/* webpackChunkName: "about" */ "../views/AboutView.vue"),
  },
];

const router = new VueRouter({
  mode: "history",
  base: process.env.BASE_URL,
  routes,
});

export default router;