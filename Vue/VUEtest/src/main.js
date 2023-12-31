// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import App from './App'
import router from './router'


import 'lib-flexible'
import axios from 'axios'
import echarts from 'echarts'
import scroll, { vueSeamlessScroll } from 'vue-seamless-scroll'
import 'element-ui/lib/theme-chalk/index.css';
import ElementUI from 'element-ui';



Vue.use(ElementUI);
Vue.prototype.$http = axios
Vue.prototype.$echarts = echarts
Vue.use(scroll);
Vue.prototype.$http = axios
Vue.use(scroll, { componentName: 'scroll-seamless' })


Vue.config.productionTip = false
/* eslint-disable no-new */
new Vue({
  el: '#app',
  router,
  components: { App },
  template: '<App/>'
})
