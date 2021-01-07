import Vue from 'vue'
import App from './App.vue'
import router from './router' // ルーティングの設定
import Vuex from 'vuex'
import store from 'store'

Vue.config.productionTip = false // 開発者メッセージ表示の有無(true)
Vue.use(Vuex);
Vue.use(store);

new Vue({
  el: "#app", // index.htmlのマウント先の要素
  render: h => h(App), // コンポーネントから要素をレンダリング
  router,
  store
})