
<template>
    
<div>   
  <div style="display:flex"  v-for=" (val, key , i) in TypeList" :key="key" >    
    <el-tag size="medium">Enter{{val}}</el-tag>
   <el-input  v-model="ValueList[key]"></el-input>
  </div>
  <div><el-button :size="medium" type="success" @click="sumbit">ok</el-button></div>
  <div>
    <div style="display: flex; margin-top: 20px; height: 100px;">
      <transition name="el-zoom-in-center">
        <div v-show="show2" class="transition-box">{{ result }}</div>
      </transition>
    </div>
  </div>
  <iframe  v-bind:src="url" height="500" width="100%"></iframe>
  </div>
</template>
<script>
import { getContent,getPredict } from "../request/api";
export default {
  mounted(){
      this.getContent()
    },
  data() {
    return {
      result:'',
      show2: true,
      input: this.$route.params.type,
      TypeList:['x','w'],
      ValueList:[],
      url:$mainConfig.iframeUrl+"_DeepSee.UserPortal.DashboardViewer.zen?EMBED=1&NOBORDER=1&DASHBOARD=CustomizeMashineLerningAndaAnalysis/Dashboard/"+this.$route.params.type+"Analysis.dashboard"

    }
  },
  methods: {  
    filechange(file, fileList){
      this.files=file
    },
    getContent(){
      var formdata=new FormData()
      formdata.append("Type",this.$route.params.type)
      getContent(formdata).then((res) => {
        console.log(res.data.array)
        this.TypeList=res.data.array
        console.log(this.TypeList)
        //this.pHeight=res.data

   })
     // console.log(this.$route.params.type)
    },
    sumbit(){

     /* var temp=new FormData()
      console.log(this.files)
      temp.append('Predict',this.input)
      temp.append('input',this.files.raw)
      add(temp).then((res) => {
        
           this.pHeight=res.array

      })*/
      this.show2=false
      var temp=new FormData()
     
      var param={"name":this.$route.params.type}
       param.ValueList=this.ValueList
       temp.append("input", JSON.stringify(param) )
     
      getPredict(temp).then((res) => {
           this.typelist =res;
           this.show2=true
           var arr=res.data.split('---resultFlag---')
           this.result=arr[1]
   })
    }
  }

}
</script>