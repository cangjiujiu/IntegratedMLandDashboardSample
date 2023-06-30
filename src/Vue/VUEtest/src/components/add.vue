<style scoped>
</style>
<template>
    
<div>        
    <div style="width:50vh;height:5vh;display: flex;">
        <el-tag size="medium">Create a new model</el-tag>
        <el-upload style="display:flex"
  class="upload-demo"
  action="action"
  :on-preview="handlePreview"
  :on-remove="handleRemove"
  :before-remove="beforeRemove"
  multiple
  :limit="`1`"
  :on-exceed="handleExceed"
  :on-change="filechange"
  :http-request="upload"
  :file-list="fileList">
  <el-button :size="medium" type="primary">Click to upload</el-button>
  <div slot="tip" class="el-upload__tip">Click to upload the CSV file, and the file name cannot have special symbols</div>
</el-upload>
    </div>
    <div style="width:30vh;display: flex;">  
        <el-tag size="medium">predicted value</el-tag>
        <el-input class="input1" size="large"  v-model="input" placeholder="Please fill in the predicted value"></el-input>
    </div>
     <div><el-button :size="medium" type="success" @click="sumbit"  v-loading.fullscreen.lock="fullscreenLoading" >ok</el-button></div>
  </div>

</template>
<script>
import { add} from "../request/api";
import { Loading } from 'element-ui';
export default {
  data() {
    return {
      fullscreenLoading:false,
      input: '',
      files:[],

    }
  },
  methods: {  
    filechange(file, fileList){
      this.files=file
    },
    upload(){
      console.log(1)
    },
    sumbit(){
    this.fullscreenLoading=true
      var temp=new FormData()
      console.log(this.files)
      temp.append('Predict',this.input)
      temp.append('input',this.files.raw)
      add(temp).then((res) => {
        
          
           this.fullscreenLoading=false
           this.$router.replace({ path:'/' })
      })
    }
  }

}
</script>