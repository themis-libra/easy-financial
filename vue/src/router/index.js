import Vue from 'vue'
import Router from 'vue-router'

import HelloWorld from '@/components/HelloWorld'
import Home from '@/components/Home'
import OpenAccount from '@/components/OpenAccount'
import Product from '../views/product.vue'
import Purchase from '../views/purchase.vue'
import Redeem from '../views/redeem.vue'
import PruchaseSearch from '../views/purchaseSearch.vue'
import RedeemSearch from '../views/redeemSearch.vue'

Vue.use(Router)

export default new Router({
  routes: [
    // 首页
    {
      path: '/',
      name: 'HelloWorld',
      component: HelloWorld
    },
    // 暂时没用
    {
      path: '/Home',
      name: 'Home',
      component: Home
    },
    // 产品管理
    {
      path: '/OpenAccount',
      name: 'OpenAccount',
      component: OpenAccount
    },
    {
      path: '/Product',
      name: 'Product',
      component: Product
    },
    {
      path: '/Purchase',
      name: 'Purchase',
      component: Purchase
    },
    {
      path: '/Redeem',
      name: 'Redeem',
      component: Redeem
    },
    {
      path: '/PruchaseSearch',
      name: 'PruchaseSearch',
      component: PruchaseSearch
    },
    {
      path: '/RedeemSearch',
      name: 'RedeemSearch',
      component: RedeemSearch
    },
  ]
})
