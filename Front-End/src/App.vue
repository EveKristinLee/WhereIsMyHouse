<template>
<body class="d-flex flex-column h-100">
  <div id="app" class="flex-shrink-0">
    <nav-header></nav-header>
    <router-view></router-view>
    
  </div>
  <nav-footer></nav-footer>
</body>
</template>

<script>
import NavHeader from '@/components/NavHeader.vue';
import NavFooter from '@/components/NavFooter.vue';
export default {
  name: 'App',
  components: {
    NavHeader,
    NavFooter,
  },
};
</script>

<style>
/* #app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
}

nav {
  padding: 30px;
}

nav a {
  font-weight: bold;
  color: #2c3e50;
}

nav a.router-link-exact-active {
  color: #42b983;
} */
</style>
