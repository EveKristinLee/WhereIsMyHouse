<template>
  <div class="px-5 py-5 input-group" style="width: 1000px; margin: 0 auto">
    <div class="input-group" style="display: flex; justify-content: center">
      <h2 class="fw-bolder" style="display: inline">아파트명으로 검색</h2>
    </div>
    <div class="px-5 py-5 input-group">
      <b-form-input
        v-model="aptName"
        type="search"
        class="form-control rounded"
        placeholder="아파트를 검색하세요"
        aria-label="Search"
        aria-describedby="search-addon"
      />
      <b-button @click="searchHandler" type="submit" id="apt-btn" class="btn btn-outline-primary"
        >검색하기</b-button
      >
    </div>

    <div class="container" v-if="apts.length > 0">
      <b-table
        id="apt-table"
        :per-page="perPage"
        :current-page="currentPage"
        hover
        striped
        :items="apts"
        :fields="fields"
        @row-clicked="goDetail"
      ></b-table>
      <b-pagination
        aria-controls="apt-table"
        v-model="currentPage"
        :total-rows="apts.length"
        :per-page="perPage"
        first-number
        last-number
        align="center"
      ></b-pagination>
    </div>
    <div class="container px-5 py-5" v-else>검색 결과가 없습니다.</div>
    <!--  pagination 처리 -->
  </div>
</template>

<script>
import http from '@/api/http';

export default {
  data() {
    return {
      perPage: 5,
      currentPage: 1,
      apts: [],
      aptName: '',
      fields: [
        { key: 'aptName', label: '아파트 이름' },
        { key: 'dongName', label: '동 이름' },
        { key: 'dealAmount', label: '거래 금액' },
      ],
    };
  },
  methods: {
    searchHandler() {
      const url = `search/apt?aptName=${this.aptName}`;
      http.get(url).then(({ data }) => {
        console.log('success>>', data);
        this.apts = data;
      });
    },
    goDetail(item) {
      this.$router.push({ name: 'SearchDetailView', query: { no: item.no } });
    },
  },
};
</script>
<style></style>