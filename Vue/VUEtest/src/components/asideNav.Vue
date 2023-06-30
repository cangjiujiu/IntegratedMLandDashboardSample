
<template>
    <div class="aside" style="height: 100%; width: 100%;">
      <el-row class="tac" style="height: 100%; width: 100%;">
        <el-col :span="12" style="height: 100%; width: 100%;">
          <el-menu size="large" 
            default-active="this.$route.path" router
            class="el-menu-vertical-demo"
            @open="handleOpen"
            @close="handleClose"
            background-color="#545c64"
            text-color="#fff"
           
            active-text-color="#ffd04b"
            style="height: 100%; width: 100%;">
            <el-menu-item index="/add">
              <i class="el-icon-setting"></i>
              <span slot="title">Create a new model</span>
            </el-menu-item>
            <el-submenu index="/add">
             <template slot="title">
                <i class="el-icon-location"></i>
                <span>Model List</span>
              </template>
              <el-menu-item-group v-for=" (val, key , i) in typelist" :key="key">
                <el-menu-item :index="val">{{val}}</el-menu-item>
                
              </el-menu-item-group>
            
            </el-submenu>
         
          



          </el-menu>
        </el-col>
      </el-row>
    </div>
  </template>
  
<script>
  import { getMenuList } from "../request/api";
  export default {
    mounted(){
       this.getMenuList()
    },
    data() {
    return {
      typelist:[]

    }
  },
 
      methods: {
        handleOpen(key, keyPath) {
         
        },
        handleClose(key, keyPath) {
         
        },
        getMenuList(){
          getMenuList().then((res) => {
          
           this.typelist =res;
       

   })
          
        }
      }
    }
</script>