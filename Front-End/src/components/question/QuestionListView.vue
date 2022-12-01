<template>
  <div class="px-5 py-1"  style="width: 1000px; margin: 0 auto">
    <div v-if="questions.length > 0">
      <b-table hover striped :items="questions" :fields="fields" @row-clicked="goDetail">
        <template #cell(번호)="data">
          {{data.index+1}}
        </template>
      </b-table>
    </div>
    <div v-else>등록된 Q&A 목록이 없습니다.</div>
  </div>
</template>

<script>
import http from "@/api/http"
import moment from "moment"

export default {
  data() {
    return { 
      questions: [], 
      word:"",
      fields: [
        '번호',
        // {key:"id", label:"번호"},
        // {key:"user_id", label:"사용자"},
        {key:"title", label:"제목"},
        {key:"regtime", label:"작성일", formatter: "formatDate"},
      ],  //table의 header에 표시되는 데이터 mapping
      key:"all",
    };
  },
  created() {
    
    http.get('/question')
      .then(({data}) => {
        console.log("getQuestions............{}", data);
        this.questions = data;
      })
  },
  methods: {
    formatDate(val) {
      return moment(new Date(val)).format('YYYY.MM.DD HH:mm:ss');
    },
    goDetail(item) {  //table에서 클릭된 row의 데이터가 인자로 전달됨
      this.$router.push({name:"QuestionDetailView", query:{id:item.id}})
    },
  },
};
</script>

<style></style>
