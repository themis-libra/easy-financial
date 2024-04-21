<template>
    <div class="container" id="aside">
        <el-aside width="200px">
        <el-menu
            default-active="1"
            background-color="rgb(34, 46, 60)"
            text-color="#fff"
            router
        >
            <el-menu-item index="/">首页</el-menu-item>
            <el-menu-item index="/Product">产品管理</el-menu-item>
            <el-submenu index="3">
            <template slot="title">账户管理</template>
            <el-menu-item index="/1">开户</el-menu-item>
            <el-menu-item index="/2">资料修改</el-menu-item>
            </el-submenu>
            <el-submenu index="4">
            <template slot="title">交易管理</template>
            <el-menu-item index="/Purchase">申购</el-menu-item>
            <el-menu-item index="/Redeem">赎回</el-menu-item>
            </el-submenu>
            <el-menu-item index="5">清算管理</el-menu-item>
            <el-submenu index="6">
            <template slot="title">查询管理</template>
            <el-menu-item index="/5">申购申请查询</el-menu-item>
            <el-menu-item index="/6">赎回申请查询</el-menu-item>
            </el-submenu>
        </el-menu>
        </el-aside>
    </div>
</template>

<style>
.el-aside {
    background-color: rgb(34, 46, 60);
    color: #fff;
    padding-top: 10px;
  }
.container {
    display: flex;
    height: 100vh;
}
.el-menu {
    border-right: solid 0px;
}
#aside .el-menu-item.is-active {
    background-color: rgb(48, 69, 102) !important;
    color: #fff;
    border-left: 3px solid #fff;
}
</style>
