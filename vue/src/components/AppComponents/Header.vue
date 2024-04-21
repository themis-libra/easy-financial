<template>
  <div class="header">
    <el-menu theme="dark" :default-active="activeIndex"
    class= "el-menu-demo" mode= "horizontal" @select= "handleSelect">
      <el-menu-item index="1">
        <img src="./学校图标.png" width="40px">
        简易理财销售柜台系统
      </el-menu-item>
    </el-menu>
  </div>
</template>

<script>
export default {
  data () {
    return {
      activeIndex: '1',
      activeIndex2: '1'
    }
  },
  methods: {
    handleSelect (key, keyPath) {
      console.log(key, keyPath)
    }
  }
}
</script>

<style>
.header .el-menu-item{
  border-bottom: 0px !important;
  font-size: 20px;
}
</style>
