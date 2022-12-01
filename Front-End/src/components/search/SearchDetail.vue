<template>
  <body class="d-flex flex-column">
    <main class="flex-shrink-0">
      <div class="px-5 py-5 input-group" style="width: 1000px; margin: 0 auto">
        <div class="input-group" style="display: flex; justify-content: center">
          <h2 class="fw-bolder" style="display: inline">거래 정보 보기</h2>
        </div>
      </div>

      <div class="container">
        <section class="py-3" id="contents">
          <div class="row">
            <div class="container col-4 left" style="float: left">
              <table
                class="table table-hover"
                style="text-align: center; vertical-align: middle; height: 400px"
              >
                <thead>
                  <tr>
                    <th colspan="2">
                      <h4 class="fw-bolder" style="display: inline" v-text="house.aptName"></h4>
                    </th>
                  </tr>
                </thead>
                <tbody>
                  <tr>
                    <td><b>동 이름</b></td>
                    <td v-text="house.dongName"></td>
                  </tr>
                  <tr>
                    <td><b>거래 금액</b></td>
                    <td v-text="house.dealAmount"></td>
                  </tr>
                  <tr>
                    <td><b>면적</b></td>
                    <td v-text="house.area"></td>
                  </tr>
                  <tr>
                    <td><b>층수</b></td>
                    <td v-text="house.floor"></td>
                  </tr>
                  <tr>
                    <td><b>지번</b></td>
                    <td v-text="house.jibun"></td>
                  </tr>
                  <tr>
                    <td><b>건축년도</b></td>
                    <td v-text="house.buildYear"></td>
                  </tr>
                </tbody>
              </table>
            </div>
            <div class="col-8 right">
              <div class="map_wrap">
                <div style="width: 100%; height: 100%" id="map"></div>
              </div>
            </div>
          </div>
        </section>
      </div>
    </main>
  </body>
</template>

<script>
import http from '@/api/http';

export default {
  data() {
    return {
      no: '',
      lat: 0,
      lng: 0,
      house: {},
      markers: [],
      infowindow: null,
    };
  },
  created() {
    this.no = this.$route.query.no;
    http.get(`/search?no=${this.no}`).then(({ data }) => {
      console.log('집 상세정보 뜨나?', data);
      this.house = data;
    });
  },

  beforeUpdate() {
    if (window.kakao && window.kakao.maps) {
      this.initMap();
    } else {
      const script = document.createElement('script');
      /* global kakao */
      script.onload = () => kakao.maps.load(this.initMap);
      script.src =
        '//dapi.kakao.com/v2/maps/sdk.js?autoload=false&appkey=ddca17d930f7fc38eba631648c6e744e&libraries=services';
      document.head.appendChild(script);
    }
  },
  methods: {
    initMap() {
      const mapContainer = document.getElementById('map');
      const mapOption = {
        center: new window.kakao.maps.LatLng(this.house.lat, this.house.lng), // 지도의 중심좌표
        level: 2, // 지도의 확대 레벨
      };
      this.map = new window.kakao.maps.Map(mapContainer, mapOption);

      const markerPosition = new window.kakao.maps.LatLng(this.house.lat, this.house.lng);
      const marker = new window.kakao.maps.Marker({
        position: markerPosition,
      });
      marker.setMap(this.map);

      // var iwContent = `<div style="padding:5px; text-align:center">거래 금액<br>${this.house.dealAmount}</div>`;
      var iwPosition = new kakao.maps.LatLng(this.house.lat, this.house.lng); //인포윈도우 표시 위치입니다

      var infoWindow = new kakao.maps.InfoWindow({
        position: iwPosition,
        content: `<span class="info-title" style="display: block;background: #50627F;color: #fff;text-align: center;height: 24px;line-height:22px;border-radius:4px;padding:0px 10px;">${this.house.dealAmount}</span>`,
      });

      // 마커 위에 인포윈도우를 표시합니다. 두번째 파라미터인 marker를 넣어주지 않으면 지도 위에 표시됩니다
      infoWindow.open(this.map, marker);

      var infoTitle = document.querySelectorAll('.info-title');
      infoTitle.forEach(function (e) {
        var w = e.offsetWidth + 10;
        var ml = w / 2;
        e.parentElement.style.top = '82px';
        e.parentElement.style.left = '50%';
        e.parentElement.style.marginLeft = -ml + 'px';
        e.parentElement.style.width = w + 'px';
        e.parentElement.previousSibling.style.display = 'none';
        e.parentElement.parentElement.style.border = '0px';
        e.parentElement.parentElement.style.background = 'unset';
      });
    },
  },
};
</script>

<style>
a {
  color: inherit;
  text-decoration: none;
}

.map_wrap,
.map_wrap * {
  margin: 0;
  padding: 0;
  font-family: 'Malgun Gothic', dotum, '돋움', sans-serif;
  font-size: 12px;
}

.row {
  width: 100%;
  /* border: 1px solid #003458; */
}

div.left {
  width: 60%;
  float: left;
  box-sizing: border-box;
  /* background: #8977ad; */
}
div.right {
  width: 40%;
  float: right;
  box-sizing: border-box;
  /* background: #ece6cc; */
}

#map {
  width: 400px;
  height: 400px;
}

.map_wrap {
  position: relative;
  width: 100%;
  height: 500px;
}
</style>