<template>
  <div class="px-5 py-5 input-group" style="width: 1000px; margin: 0 auto">
    <div class="input-group" style="display: flex; justify-content: center">
      <h2 class="fw-bolder" style="display: inline">Q & A</h2>
    </div>
    <b-nav pills class="px-5 py-5 input-group ml-auto">
      <b-nav-item class="nav-item align-self-center link">
        <router-link class="nav-link" :to="{ name: 'QuestionListView' }">목록</router-link>
      </b-nav-item>
      <b-nav-item class="nav-item">
        <router-link class="nav-link" :to="{ name: 'QuestionRegistView' }">등록</router-link>
      </b-nav-item>
    </b-nav>

    <router-view />
  </div>
</template>

<script>
export default {};
</script>

<style></style>