import Vue from 'vue'
import App from './App.vue'
import router from './router' // ルーティングの設定

Vue.config.productionTip = false // 開発者メッセージ表示の有無(true)

new Vue({
  el: "#app", // index.htmlのマウント先の要素
  render: h => h(App), // コンポーネントから要素をレンダリング
  router,
})