<template>
  <div class="app">
    <!-- 头部 -->

     <myHeader></myHeader>
    <el-container 
      style="height:210vh; 
      border: 1px solid #eee; 
      margin: 0;
      border: 0;
      padding: 0;">     <!-- style： 隐藏滚动条  去掉白边-->
      <!-- 侧边栏 -->
      <el-aside style="width: 200px;height:100%">
        <asideNav></asideNav>
      </el-aside>
      <!-- 主页面 -->
      <el-main>
        <router-view style="" :key="$route.fullPath"></router-view>  
      </el-main>
    </el-container>
  </div>
</template>
 
<script>
import myHeader from "@/components/HHeader"
import asideNav from "@/components/asideNav"
import add from '@/components/add'

 
export default {
  name: "App",
  components: {
    myHeader,
    asideNav,
    add
  }
}
</script>

<style>
  html,
  body{
    height: 100%;
    margin: 0;
    border: 0;
    padding: 0;
  }
</style>
