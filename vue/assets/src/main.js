import Vue from 'vue'
import App from '@/App'
import router from '@/router' // ルーティングの設定
import store from '@/store'
import vuetify from './plugins/vuetify';

Vue.config.productionTip = false // 開発者メッセージ表示の有無(true)

new Vue({
  // index.htmlのマウント先の要素
  el: "#app",

  // コンポーネントから要素をレンダリング
  render: h => h(App),

  router,
  vuetify,
  store
})