<template>
  <div class="px-5 py-1"  style="width: 1000px; margin: 0 auto">
    <table class="table table-bordered">
      <tr>
        <th>제목</th>
        <td>
          <b-form-input ref="title" v-model="question.title" />
        </td>
      </tr>
      <tr>
        <th colspan="2">내용</th>
      </tr>
      <tr>
        <td colspan="2">
          <textarea
            id="content"
            cols="46"
            rows="10"
            ref="content"
            v-model="question.content"
          ></textarea>
        </td>
      </tr>
      <tr>
        <td colspan="2">
          <tr>
          <b-button variant="primary" @click="updateHandler">수정</b-button>
          <router-link :to="{ name: 'QuestionListView' }">
            <b-button variant="primary">목록</b-button>
          </router-link>
          </tr>
        </td>
      </tr>
    </table>
  </div>
</template>

<script>
import http from "@/api/http";
export default {
  data() {
    return {
      id: "",
      question: {
        id: "",
        title: "",
        user_id: "",
        content: "",
        regtime: "",
      },
    };
  },
  created() {
    //DOM객체와 연결되었고 Vue의 속성들도 초기화 된 상태
    this.id = this.$route.query.id;
    http.get(`/question/${this.id}`)
      .then(({data}) => {
        console.log('응답 데이터 ', data);
        this.question = data;
      })
  },
  methods: {
    updateHandler() {
      //데이타 검증
      let err = false;
      let msg = "";
      if (this.question.title == "") {
        err = true;
        msg = "제목을 입력해 주세요";
        this.$refs['title'].focus();
      }
      if (!err && this.question.content == "") {
        err = true;
        msg = "내용을 입력해 주세요";
        this.$refs['content'].focus();
      }

      if (err) {
        alert(msg);
      } else {
        //수정하기
        http.put("/question", this.question)
          .then(({data}) => {
            if(data === "success") {
              alert("수정 완료");
              this.$router.push({name:"QuestionDetailView", 
                                query : {id: this.id}});
            }
          })
      }
    },
    
  },
};
</script>

<style></style>
