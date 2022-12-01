<template>
  <div  class="px-5 py-1"  style="width: 1000px; margin: 0 auto">
    <table class="table table-borderless">
      
      <tr>
        <td>제목</td>
        <td>
          <b-form-input ref="title" v-model="question.title" />
        </td>
      </tr>
      <tr>
        <td colspan="2">내용</td>
      </tr>
      <tr>
        <td colspan="2">
          <b-form-textarea
            id="content"
            cols="46"
            rows="10"
            ref="content"
            v-model="question.content"
          ></b-form-textarea>
        </td>
      </tr>
      <tr>
        <td colspan="2">
          <div class="text-center">
            <b-button variant="primary" class="btn btn-primary" @click="createHandler">등록</b-button>
            <b-button variant="primary" class="btn btn-primary" @click="moveHandler">목록</b-button>
          </div>
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
      question: {
        title: "",
        user_email: "",
        content: "",
      }
    };
  },
  computed: {
    userInfo() {
      return this.$store.state.memberStore.userInfo;
    }
  },
  methods: {
    moveHandler() {
      this.$router.push({ name: "QuestionListView" });
    },
    createHandler() {
      //데이타 검증
      let err = false;
      let msg = "";

      if (this.question.title == "") {
        err = true;
        msg = "제목을 입력해 주세요";
        this.$refs.title.focus();
      }

      if (!err && this.question.content == "") {
        err = true;
        msg = "내용을 입력해 주세요";
        this.$refs.content.focus();
      }

      if (err) {
        alert(msg);
      } else {
        //등록 처리
        console.log("user_email --->{}", this.userInfo.email);
        this.question.user_email = this.userInfo.email;
        http.post("/question", this.question)
            .then(({data}) => {
              if (data == "success") {
                alert("등록 완료");
                this.moveHandler();
              }
            })
            .catch(({data}) => {
              alert(data);
            });
      }
    },
  },
};
</script>

<style></style>
