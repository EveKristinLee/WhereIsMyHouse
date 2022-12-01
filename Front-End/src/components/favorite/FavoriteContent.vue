<template>
  <body class="d-flex flex-column">
    <main class="flex-shirnk-0">
      <div class="px-5 py-5 input-group" style="width: 1000px; margin: 0 auto">
        <div class="input-group" style="display: flex; justify-content: center">
          <h2 class="mx-auto fw-bolder" style="display: inline">관심지역 조회</h2>
        </div>
      </div>

      <div class="container-fluid">
        <section id="contents" class="py-3">
          

          <div class="row">
            <div class="container col-3" style="height: 100%; width: 40%">
              
              <div  style="display: flex; justify-content: center">
                <h4 class="fw-bolder align-middle" style="display: inline">관심지역 목록</h4>
              </div>
              <div v-if="favorites.length > 0">
              <b-table id="favorite-table" class="mt-3" striped hover :items="favorites" :fields ="fields" :per-page="perPage" :current-page="currentPage" @row-clicked="searchApt">
                <template v-slot:cell(actions)="data">
                  <button class="remove_button" size="sm" variant="primary" @click="del(data)"><img src="@/assets/img/remove.png" width="20px" /></button>
                </template>
              </b-table>
              <b-pagination aria-controls="favorite-table" v-model="currentPage" :total-rows="favorites.length" :per-page="perPage" first-number last-number align="center"></b-pagination>
              </div>
              <div class="mt-4" v-else style="display: flex; justify-content: center">
                <h6>관심지역이 없습니다</h6>
              </div>
              <!-- TODO : 페이징 처리 -->
              
            </div>
            <div class="container col-9 right">
              <div class="map_wrap">
                <div style="width: 100%; height: 100%" id="map"></div>
                <ul class="left" id="category">
                  <li ref="BK9" id="BK9" data-order="0" @click="onClickCategory">
                    <span class="category_bg bank"></span> 은행
                  </li>
                  <li ref="MT1" id="MT1" data-order="1" @click="onClickCategory">
                    <span class="category_bg mart"></span> 마트
                  </li>
                  <li ref="PM9" id="PM9" data-order="2" @click="onClickCategory">
                    <span class="category_bg pharmacy"></span> 약국
                  </li>
                  <li ref="OL7" id="OL7" data-order="3" @click="onClickCategory">
                    <span class="category_bg oil"></span> 주유소
                  </li>
                  <li ref="CE7" id="CE7" data-order="4" @click="onClickCategory">
                    <span class="category_bg cafe"></span> 카페
                  </li>
                  <li ref="CS2" id="CS2" data-order="5" @click="onClickCategory">
                    <span class="category_bg store"></span> 편의점
                  </li>
                </ul>
              </div>
            </div>
          </div>
        </section>
      </div>
    </main>
  </body>
</template>

<script>
  import http from "@/api/http"
export default {
  name: 'KakaoMap',
  data() {
    return {
      perPage:5,
      currentPage:1,
      favorites: [],
      fields:[
        {key:"sidoName", label:"시", thStyle : {display : 'none'}},
        {key:"gugunName", label:"구", thStyle : {display : 'none'}},
        {key:"dongName", label:"동", thStyle : {display : 'none'}},
        {key: "actions", label:"삭제", thStyle : {display : 'none'}}
      ],
      // userInfo: [],
      key:"all",
      markers: [],
      latitude: 0,
      longitude: 0,
      placeOverlay: new window.kakao.maps.CustomOverlay({ zIndex: 1 }),
      currCategory: '',
      contentNode: document.createElement('div'),
      apts: [], //아파트 정보 마커 저장
      aptsMarkers: [],
      dealAmount : [],
      infoWindows : [],
    };
  },

  computed: {
    userInfo() {
      return this.$store.state.memberStore.userInfo;
    }
  },

  created() {
    console.log("관심지역 조회 userEmail : " , this.userInfo);

    http.get(`/favorite/${this.userInfo.email}`)
      .then(({data}) => {
        this.favorites = data;
      })
  },

  mounted() {
    if (!('geolocation' in navigator)) {
      return;
    }

    //getPosition
    navigator.geolocation.getCurrentPosition(
      (pos) => {
        this.latitude = pos.coords.latitude;
        this.longitude = pos.coords.longitude;

        if (window.kakao && window.kakao.maps) {
          this.initMap();
        } else {
          const script = document.createElement('script');
          // script.async = true;
          /* global kakao */
          script.onload = () => window.kakao.maps.load(this.initMap());
          script.src = `//dapi.kakao.com/v2/maps/sdk.js?autoload=false&appkey=ddca17d930f7fc38eba631648c6e744e&libraries=services`;
          document.head.appendChild(script);
        }
      },
      (err) => {
        alert(err.message);
      }
    );

  },
  methods: {
    del(data) {
      console.log(data.item.dongName, " : ", data.item.dongCode);
      http
        .delete(`/favorite/delete/${this.userInfo.email}/${data.item.dongCode}`)
        .then(({ data }) => {
          if (data == 'success') {
            window.alert('저장한 관심지역에서 삭제했습니다.');
            this.$router.go(this.$router.currentRoute);
          }
        })
        .catch(({ data }) => {
          alert(data);
        });
    },
    searchApt(item) {
      console.log("선택한 동 : " , item)
      http.get(`/search/dong?dongCode=${item.dongCode}`).then(({ data }) => {
        console.log('success>>', data);
        this.apts = data;
      });

      this.placeOverlay.setMap(null);
      this.removeMarker();
      for (var i = 0; i < this.aptsMarkers.length; i++) {
        this.aptsMarkers[i].setMap(null);
      }
      this.aptsMarkers = [];
      for (var k = 0; k < this.infoWindows.length; k++) {
        this.infoWindows[k].close();
      }
      const tmp = this;
      var geocoder = new window.kakao.maps.services.Geocoder();
      var address = `${item.sidoName} ${item.gugunName} ${item.dongName}`;
      console.log("선택한 주소 : ", address)
      geocoder.addressSearch(address, function(result, status) {

        // 정상적으로 검색이 완료됐으면 지도 중심 옮기기
        if (status === kakao.maps.services.Status.OK) {
            var coords = new window.kakao.maps.LatLng(result[0].y, result[0].x);
            tmp.map.setCenter(coords);
        } 

        for (var i = 0, len = tmp.apts.length; i < len; i++) {
          // 마커를 생성하고 지도위에 표시합니다
          tmp.addHouseMarker(i, tmp.apts[i]);
        }
      });
      
    },

    // 마커를 생성하고 지도위에 표시하는 함수입니다
    addHouseMarker(index, housePosition) {
      // 마커를 생성합니다
      console.log("housePosition : " , housePosition)
      var hposition = new window.kakao.maps.LatLng(housePosition.lat, housePosition.lng);
      var marker = new window.kakao.maps.Marker({
          position: hposition
      });

      // 마커가 지도 위에 표시되도록 설정합니다
      marker.setMap(this.map);
      
      // 생성된 마커를 배열에 추가합니다
      this.aptsMarkers.push(marker);

      var tmp = this;
      (function (marker, housePosition) {
        window.kakao.maps.event.addListener(marker, 'click', function () {
          console.log("클릭!!!!!!")
          tmp.displayHouseInfo(marker, housePosition);
        });
      })(marker, housePosition);
    },

    displayHouseInfo(marker, housePosition) {
      for (var k = 0; k < this.infoWindows.length; k++) {
        this.infoWindows[k].close();
      }
      // 마커를 클릭했을 때 마커 위에 표시할 인포윈도우를 생성합니다
      var iwContent = `<span class="info-title" style="display: block;background: #50627F;color: #fff;text-align: center;height: 24px;line-height:22px;border-radius:4px;padding:0px 10px;">${housePosition.aptName} : ${housePosition.dealAmount}</span>`, // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
          iwRemoveable = false; // removeable 속성을 ture 로 설정하면 인포윈도우를 닫을 수 있는 x버튼이 표시됩니다

      // 인포윈도우를 생성합니다
      var infowindow = new window.kakao.maps.InfoWindow({
          content : iwContent,
          removable : iwRemoveable
      });  
      this.infoWindows.push(infowindow);

      infowindow.open(this.map, marker);

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

    initMap() {
      const container = document.getElementById('map');
      const options = {
        center: new window.kakao.maps.LatLng(this.latitude, this.longitude),
        level: 6,
      };

      //지도 객체를 등록합니다.
      //지도 객체는 반응형 관리 대상이 아니므로 initMap에서 선언합니다.
      this.map = new window.kakao.maps.Map(container, options);
    },

    displayMarker(markerPositions) {
      if (this.markers.length > 0) {
        this.markers.forEach((marker) => marker.setMap(null));
      }

      const positions = markerPositions.map(
        (position) => new window.kakao.maps.LatLng(...position)
      );

      if (positions.length > 0) {
        this.markers = positions.map(
          (position) =>
            new window.kakao.maps.Marker({
              map: this.map,
              position,
            })
        );

        const bounds = positions.reduce(
          (bounds, latlng) => bounds.extend(latlng),
          new window.kakao.maps.LatLngBounds()
        );

        this.map.setBounds(bounds);
      }
    },

    searchPlaces() {
      if (!this.currCategory) {
        return;
      }

      this.placeOverlay.setMap(null);
      for (var i = 0; i < this.aptsMarkers.length; i++) {
        this.aptsMarkers[i].setMap(null);
      }
      this.aptsMarkers = [];
      for (var k = 0; k < this.infoWindows.length; k++) {
        this.infoWindows[k].close();
      }
      this.removeMarker();
      new window.kakao.maps.services.Places(this.map).categorySearch(
        this.currCategory,
        this.placesSearchCB,
        { useMapBounds: true }
      );
    },

    placesSearchCB(data, status) {
      if (status === kakao.maps.services.Status.OK) {
        // console.log("data   -> places : " + JSON.stringify(data))
        this.displayPlaces(data);
      } else if (status === kakao.maps.services.Status.ZERO_RESULT) {
        //검색결과가 없는 경우
      } else if (status === kakao.maps.services.Status.ERROR) {
        //에러로 인해 검색결과가 나오지 않는 경우
      }
    },

    displayPlaceInfo(place) {
      var content =
        '<div class="placeinfo" ref="popup_map" id="popup_map">' +
        '   <a class="title" href="' +
        place.place_url +
        '" target="_blank" title="' +
        place.place_name +
        '">' +
        place.place_name +
        '</a>';

      if (place.road_address_name) {
        content +=
          '    <span title="' +
          place.road_address_name +
          '">' +
          place.road_address_name +
          '</span>' +
          '  <span class="jibun" title="' +
          place.address_name +
          '">(지번 : ' +
          place.address_name +
          ')</span>';
      } else {
        content += '    <span title="' + place.address_name + '">' + place.address_name + '</span>';
      }

      content +=
        '    <span class="tel">' + place.phone + '</span>' + '</div>' + '<div class="after"></div>';

      this.contentNode.innerHTML = content;
      this.placeOverlay.setPosition(new window.kakao.maps.LatLng(place.y, place.x));

      this.placeOverlay.setMap(this.map);
    },

    displayPlaces(places) {
      var order = document.getElementById(this.currCategory).getAttribute('data-order');

      for (var i = 0; i < places.length; i++) {
        var marker = this.addMarker(new window.kakao.maps.LatLng(places[i].y, places[i].x), order);

        console.log('1.this : ' + this);
        const tmp = this;
        (function (marker, place) {
          window.kakao.maps.event.addListener(marker, 'click', function () {
            console.log('place : ' + JSON.stringify(place));
            console.log('this : ' + this);
            tmp.displayPlaceInfo(place);
          });
        })(marker, places[i]);
      }
    },

    addMarker(position, order) {
      var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_category.png',
        imageSize = new kakao.maps.Size(27, 28),
        imgOptions = {
          spriteSize: new kakao.maps.Size(72, 208),
          spriteOrigin: new kakao.maps.Point(46, order * 36),
          offset: new kakao.maps.Point(11, 28),
        },
        markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
        marker = new kakao.maps.Marker({
          position: position,
          image: markerImage,
        });

      marker.setMap(this.map);
      this.markers.push(marker);

      return marker;
    },

    removeMarker() {
      for (var i = 0; i < this.markers.length; i++) {
        this.markers[i].setMap(null);
      }
      this.markers = [];
    },

    onClickCategory() {
      console.log(event.currentTarget.id);
      var id = event.currentTarget.id,
        className = event.currentTarget.className;
      console.log('className : ' + className);

      this.placeOverlay.setContent(this.contentNode);
      this.placeOverlay.setMap(null);

      if (className === 'on') {
        this.currCategory = '';
        this.changeCategoryClass();
        this.removeMarker();
      } else {
        this.currCategory = id;
        this.changeCategoryClass(this);
        this.searchPlaces();
      }
    },

    changeCategoryClass(el) {
      var category = document.getElementById('category'),
        children = category.children,
        i;

      for (i = 0; i < children.length; i++) {
        children[i].className = '';
      }

      if (el) {
        el.className = 'on';
      }
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
  /* margin: 0; */
  /* padding: 0; */
  font-family: 'Malgun Gothic', dotum, '돋움', sans-serif;
  font-size: 12px;
}

.row {
  width: 100%;
  /* border: 1px solid #003458; */
}

div.left {
  width: 30%;
  float: left;
  /* box-sizing: border-box; */
  /* background: #8977ad; */
}
div.right {
  width: 80%;
  float: right;
  /* box-sizing: border-box; */
  /* background: #ece6cc; */
}

/* #map {
  width: 10px;
  height: 400px;
} */

.map_wrap {
  /* position: relative; */
  width: 100%;
  height: 700px;
}

#category {
  position: absolute;
  top: 10px;
  left: 10px;
  border-radius: 5px;
  border: 1px solid #909090;
  box-shadow: 0 1px 1px rgba(0, 0, 0, 0.4);
  background: #fff;
  overflow: hidden;
  z-index: 2;
}

#category li {
  float: left;
  list-style: none;
  width: 50px;
  border-right: 1px solid #acacac;
  padding: 6px 0;
  text-align: center;
  cursor: pointer;
}

#category li.on {
  background: #eee;
}

#category li:hover {
  background: #ffe6e6;
  border-left: 1px solid #acacac;
  margin-left: -1px;
}

#category li:last-child {
  margin-right: 0;
  border-right: 0;
}

#category li span {
  display: block;
  margin: 0 auto 3px;
  width: 27px;
  height: 28px;
}

#category li .category_bg {
  background: url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_category.png)
    no-repeat;
}

#category li .bank {
  background-position: -10px 0;
}

#category li .mart {
  background-position: -10px -36px;
}

#category li .pharmacy {
  background-position: -10px -72px;
}

#category li .oil {
  background-position: -10px -108px;
}

#category li .cafe {
  background-position: -10px -144px;
}

#category li .store {
  background-position: -10px -180px;
}

#category li.on .category_bg {
  background-position-x: -46px;
}

.placeinfo_wrap {
  position: absolute;
  bottom: 28px;
  left: -150px;
  width: 300px;
}

.placeinfo {
  position: relative;
  width: 100%;
  border-radius: 6px;
  border: 1px solid #ccc;
  border-bottom: 2px solid #ddd;
  padding-bottom: 10px;
  background: #fff;
}

.placeinfo:nth-of-type(n) {
  border: 0;
  box-shadow: 0px 1px 2px #888;
}

.placeinfo_wrap .after {
  content: '';
  position: relative;
  margin-left: -12px;
  left: 50%;
  width: 22px;
  height: 12px;
  background: url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png');
}

.placeinfo a,
.placeinfo a:hover,
.placeinfo a:active {
  color: #fff;
  text-decoration: none;
}

.placeinfo a,
.placeinfo span {
  display: block;
  text-overflow: ellipsis;
  overflow: hidden;
  white-space: nowrap;
}

.placeinfo span {
  margin: 5px 5px 0 5px;
  cursor: default;
  font-size: 13px;
}

.placeinfo .title {
  font-weight: bold;
  font-size: 14px;
  border-radius: 6px 6px 0 0;
  margin: -1px -1px 0 -1px;
  padding: 10px;
  color: #fff;
  background: #d95050;
  background: #d95050 url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/arrow_white.png)
    no-repeat right 14px center;
}

.placeinfo .tel {
  color: #0f7833;
}

.placeinfo .jibun {
  color: #999;
  font-size: 11px;
  margin-top: 0;
}

.remove_button {
  border : 0;
  background-color:transparent;
}

</style>
