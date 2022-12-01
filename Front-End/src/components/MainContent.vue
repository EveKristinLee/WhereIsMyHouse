<template>
  <main>
    <!-- Header-->
    <header class="bg-dark py-5">
      <div class="container px-5">
        <div class="row gx-5 align-items-center justify-content-center">
          <div class="col-lg-8 col-xl-7 col-xxl-6">
            <div class="my-5 text-center text-xl-start">
              <h1 class="display-6 fw-bolder text-white mb-2">100세 인생 내 집 마련하기</h1>
              <p class="lead fw-normal text-white-50 mb-4">
                이번생에 서울에서 내 집 마련 가능할까요?
              </p>
            </div>
          </div>
          <div class="col-xl-5 col-xxl-6 d-none d-xl-block text-center">
            <img
              class="img-fluid rounded-3 my-5"
              src="@/assets/img/house.png"
              width="200"
              height="200"
              alt="..."
            />
            <!-- <img alt="Vue logo" src="@/assets/logo.png" /> -->
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
          <div class="col-lg-8" v-if="news.length > 0">
            <!-- 테이블만들긔-->
            <b-table
              id="news-table"
              :items="news"
              :fields="fields"
              thead-class="d-none"
              @row-clicked="goSite"
            ></b-table>
          </div>
          <div v-else>뉴스 결과가 없습니다.</div>
        </div>
      </div>
    </section>
    <!-- Testimonial section-->

    <!-- Blog preview section-->
  </main>
</template>

<script>
import http from '@/api/http';

export default {
  props: {
    msg: String,
  },
  data() {
    return {
      news: [],
      fields: [{ key: 'title', label: '제목' }],
    };
  },
  created() {
    http.get('/news').then(({ data }) => {
      console.log('뉴스성공?>>>>', data);
      this.news = data;

      for (var key in this.news) {
        console.log(this.news[key].title);
        var text = this.news[key].title.replace('&apos;', '');
        console.log('change?', text);
      }
    });
  },
  methods: {
    goSite(items) {
      console.log(items.link);
      window.open(items.link);
    },
  },
};
</script>
<style></style>
