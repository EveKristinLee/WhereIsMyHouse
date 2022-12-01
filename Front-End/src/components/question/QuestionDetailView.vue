<template>
  <div class="px-5 py-1"  style="width: 1000px; margin: 0 auto">
    <table class="table table-bordered" >
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
      <tr v-if="question.answer">
        <th colspan="2">답변</th>
      </tr>
      <tr v-if="question.answer">
        <th colspan="2"><pre v-text="question.answer"></pre></th>
      </tr>
      <tr>
        <td colspan="2">
          <tr v-if='userInfo.level != "admin"'>
            <!-- <tr v-if="userInfo.email == writerInfo.email"> -->
              <router-link
                :to="{ name: 'QuestionModifyView', query: { id: question.id } }"
                v-if="question.answer == null && userInfo.email == writerInfo.email"
              >
                <b-button variant="primary" >수정</b-button>
              </router-link>
              <b-button variant="primary" @click="removeHandler" v-if="userInfo.email == writerInfo.email">삭제</b-button>
            <!-- </tr> -->
          </tr>
          <tr v-else>
            <b-button variant="primary" @click="replyPageHandler" v-if="question.answer == null">답변 작성하기</b-button>
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
      writerInfo:{},
    };
  },
  computed: {
    userInfo() {
      return this.$store.state.memberStore.userInfo;
    }
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
  methods: {
    moveHandler() {
      this.$router.push({ name: "QuestionListView" });
    },
    removeHandler() {
      http.delete(`/question/${this.id}`)
        .then(({data}) => {
          if(data == 'success') {
            alert("삭제 성공")
            this.moveHandler();
          }
        })
        .catch(({data}) => {
          alert(data);
        })
    },
    replyPageHandler() {
      this.$router.push({name:"QuestionReplyView", query : {id: this.id}});
    },
  },
};
</script>

<style></style>
