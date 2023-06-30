import Vue from 'vue'
import Router from 'vue-router'

import index from '@/view/index'
import add from '@/components/add'
Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      name: 'index',
      component: index,
      children:[

        {
          path: '/add',
          name: 'add',
          component : ()=>import('@/components/add')
        
        },
        {
          path: '/Predict/:type',
          name: 'Predict',
          component : ()=>import('@/components/Predict')
        
        }
      ]
    }
  ]
})
