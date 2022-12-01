<template>
  <div class="px-5 py-5 input-group" style="width: 1000px; margin: 0 auto">
    <div class="input-group" style="display: flex; justify-content: center">
      <h2 class="fw-bolder" style="display: inline">동으로 검색</h2>
    </div>
    <div class="container">
      <div class="px-3 py-3 row col-md-12 justify-content-center mb-2">
        <div class="form-group col-md-3">
          <b-form-select class="form-select bg-secondary text-light" id="sido">
            <option value="">시도선택</option>
          </b-form-select>
        </div>
        <div class="form-group col-md-3">
          <select class="form-select bg-secondary text-light" id="gugun">
            <option value="">구군선택</option>
          </select>
        </div>
        <div class="form-group col-md-3">
          <b-form-select
            v-model="dongCode"
            class="form-select bg-secondary text-light"
            name="dongCode"
            id="dong"
          >
            <option value="">동선택</option>
          </b-form-select>
        </div>
        <b-button
          @click="searchHandler"
          type="submit"
          id="list-btn"
          class="btn btn-outline-primary form-group col-md-3"
        >
          검색하기
        </b-button>
      </div>

      <div v-if="dongs.length > 0">
        <section class="py-5" id="contents">
          <div v-if="isFav">
            <div style="display: flex; justify-content: center">
              <b-button
                @click="deleteFav"
                type="submit"
                id="list-btn"
                class="btn btn-primary form-group col-md-3"
              >
                관심 목록에서 삭제하기
              </b-button>
            </div>
          </div>
          <div v-else>
            <div style="display: flex; justify-content: center">
              <b-button
                @click="changeFav"
                type="submit"
                id="list-btn"
                class="btn btn-primary form-group col-md-3"
              >
                관심 목록에 추가하기
              </b-button>
            </div>
          </div>
        </section>
        <b-table
          id="dong-table"
          hover
          striped
          :per-page="perPage"
          :current-page="currentPage"
          :items="dongs"
          :fields="fields"
          @row-clicked="goDetail"
        >
        </b-table>
        <b-pagination
          aria-controls="dong-table"
          v-model="currentPage"
          :total-rows="dongs.length"
          :per-page="perPage"
          first-number
          last-number
          align="center"
        ></b-pagination>
      </div>
      <div v-else>등록되어있는 매물 정보들이 없습니다.</div>
    </div>
  </div>
</template>

<script>
import http from '@/api/http';

export default {
  name: 'SearchDong',
  data() {
    return {
      perPage: 5,
      currentPage: 1,
      dongs: [],
      dongCode: '',
      fields: [
        { key: 'aptName', label: '아파트 이름' },
        { key: 'dongName', label: '동 이름' },
        { key: 'dealAmount', label: '거래 금액' },
      ],
      isFav: '',
    };
  },
  computed: {
    userInfo() {
      return this.$store.state.memberStore.userInfo;
    },
  },
  created() {},
  mounted() {
    // 드롭다운 메뉴 월 범위 설정하는거 (22년도는 지나간 8월까지만 체크해주는거)
    window.onload = function () {
      sendRequest('sido', '*00000000');
    };

    document.querySelector('#sido').addEventListener('change', function () {
      if (this[this.selectedIndex].value) {
        let regcode = this[this.selectedIndex].value.substr(0, 2) + '*00000';
        sendRequest('gugun', regcode);
      } else {
        initOption('gugun');
        initOption('dong');
      }
    });

    // 구군이 바뀌면 동정보 얻기.
    document.querySelector('#gugun').addEventListener('change', function () {
      if (this[this.selectedIndex].value) {
        let regcode = this[this.selectedIndex].value.substr(0, 5) + '*';
        sendRequest('dong', regcode);
      } else {
        initOption('dong');
      }
    });

    // 프록시서버로 지역별 선택지 받아올 수 있음
    function sendRequest(selid, regcode) {
      const url = 'https://grpc-proxy-server-mkvo6j4wsq-du.a.run.app/v1/regcodes';
      let params = 'regcode_pattern=' + regcode + '&is_ignore_zero=true';
      fetch(`${url}?${params}`)
        .then((response) => response.json())
        .then((data) => addOption(selid, data));
    }

    function addOption(selid, data) {
      let opt = ``;

      initOption(selid);
      switch (selid) {
        case 'sido':
          opt += `<option value="">시도선택</option>`;
          data.regcodes.forEach(function (regcode) {
            opt += `
              <option value="${regcode.code}">${regcode.name}</option>
              `;
          });
          break;
        case 'gugun':
          opt += `<option value="">구군선택</option>`;
          for (let i = 0; i < data.regcodes.length; i++) {
            if (i != data.regcodes.length - 1) {
              if (
                data.regcodes[i].name.split(' ')[1] == data.regcodes[i + 1].name.split(' ')[1] &&
                data.regcodes[i].name.split(' ').length !=
                  data.regcodes[i + 1].name.split(' ').length
              ) {
                data.regcodes.splice(i, 1);
                i--;
              }
            }
          }
          data.regcodes.forEach(function (regcode) {
            let name = '';
            if (regcode.name.split(' ').length == 2) name = regcode.name.split(' ')[1];
            else name = regcode.name.split(' ')[1] + ' ' + regcode.name.split(' ')[2];
            opt += `
              <option value="${regcode.code}">${name}</option>
              `;
          });
          break;
        case 'dong':
          opt += `<option value="">동선택</option>`;
          data.regcodes.forEach(function (regcode) {
            let idx = 2;
            if (regcode.name.split(' ').length != 3) idx = 3;
            opt += `
              <option value="${regcode.code}">${regcode.name.split(' ')[idx]}</option>
              `;
          });
      }
      document.querySelector(`#${selid}`).innerHTML = opt;
    }

    function initOption(selid) {
      let options = document.querySelector(`#${selid}`);
      options.length = 0;
    }

    ///////////////////////// 아파트 매매 정보 /////////////////////////
  },
  methods: {
    searchHandler() {
      console.log('이게뭐임...', this.dongCode);
      http.get(`/search/dong?dongCode=${this.dongCode}`).then(({ data }) => {
        console.log('success>>', data);
        this.dongs = data;
      });

      http.get(`/favorite/${this.userInfo.email}/${this.dongCode}`).then(({ data }) => {
        console.log('count>>', data);
        if (data == 1) {
          this.isFav = true;
        } else {
          this.isFav = false;
        }
      });
    },
    goDetail(item) {
      this.$router.push({ name: 'SearchDetailView', query: { no: item.no } });
    },
    changeFav() {
      if (this.isFav) {
        // 이미 찜한 지역이라는 팝업 메시지 출력
        window.alert('이전에 저장된 관심지역입니다.');
      } else {
        http.post(`/favorite/add/${this.userInfo.email}/${this.dongCode}`).then(({ data }) => {
          console.log(data);
          window.alert('관심지역에 성공적으로 등록되었습니다.');
          this.isFav = true;
        });
      }
    },
    deleteFav() {
      http
        .delete(`/favorite/delete/${this.userInfo.email}/${this.dongCode}`)
        .then(({ data }) => {
          if (data == 'success') {
            window.alert('저장한 관심지역에서 삭제했습니다.');
            this.isFav = false;
          }
        })
        .catch(({ data }) => {
          alert(data);
        });
    },
  },
};
///////////////////////// select box 설정 (지역, 매매기간) /////////////////////////
// 드롭다운 메뉴 월 범위 설정하는거 (22년도는 지나간 8월까지만 체크해주는거)
</script>

<style>
a {
  color: inherit;
  text-decoration: none;
}
</style>