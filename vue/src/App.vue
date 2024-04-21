<template>
  <div id="app">
    <el-container>
      <el-header>
        <myheader></myheader>
      </el-header>
      <el-container>
        <el-aside width="200px"><myaside></myaside></el-aside>
        <el-main>
          <router-view></router-view>
        </el-main>
      </el-container>
    </el-container>
  </div>
</template>

<script>

import myheader from './components/AppComponents/Header.vue'
import myaside from './components/AppComponents/Aside.vue'

export default {
  name: 'App',
  components: {
    myheader,
    myaside
  }
}
</script>

<style>
#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  /* text-align: center; */
  color: #2c3e50;
}
html{
  background-color: rgb(237, 239, 241);
}
.el-header{
  padding: 0px;
}
</style>
