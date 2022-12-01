<template>
  <div class="px-5 py-1"  style="width: 1000px; margin: 0 auto">
    <table class="table table-bordered">
      <tr>
        <th>제목</th>
        <td v-text="question.title"></td>
      </tr>
      <tr>
        <th>작성자</th>
        <td v-text="writerInfo.name"></td>
      </tr>
      <tr>
        <th colspan="2">내용</th>
      </tr>
      <tr>
        <th colspan="2"><pre v-text="question.content"></pre></th>
      </tr>
      <tr>
        <td>답변</td>
        <td>
            <b-form-input ref="answer" v-model="question.answer" />
        </td>
      </tr>
      <tr>
        <td colspan="2">
          <tr>
          <b-button variant="primary" @click="replyHandler">답변 등록하기</b-button>
          <b-button variant="primary" @click="undoHandler">취소하기</b-button>
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
      question: {},
      writerInfo: {},
    };
  },
  created() {
    //DOM객체와 연결되었고 Vue의 속성들도 초기화 된 상태
    this.id = this.$route.query.id;
    http.get(`/question/${this.id}`)
      .then(({data}) => {
        console.log('응답 데이터 ', data);
        this.question = data;
        http.get(`/user/userinfo/${this.question.user_email}`)
          .then(({data}) => {
            console.log("작성자 이메일 : " , this.question.user_email);
            console.log("작성자 정보 : " , data);
            this.writerInfo = data;
          })
      })

  },

  computed: {
    userInfo() {
      return this.$store.state.memberStore.userInfo;
    }
  },
  methods: {
    undoHandler() {
      this.$router.push({name:"QuestionDetailView", query : {id: this.id}});
    },
    replyHandler() {
      let err = false;
      let msg = "";
      if (this.question.answer == null) {
        console.log("Answer--------------------> {}", this.question.answer);
        err = true;
        msg = "답변을 입력해 주세요";
        this.$refs['answer'].focus();
      }
      if(err) {
        alert(msg);
      }
      else {
        console.log("Answer--------------------> {}", this.question.answer);
        http.put("/question/reply", this.question)
            .then(({data}) => {
              if(data === "success") {
                alert("답변등록 완료");
                this.$router.push({name:"QuestionDetailView", query : {id: this.id}});
              }
            })
      }
    },
    
  },
};
</script>

<style></style>
