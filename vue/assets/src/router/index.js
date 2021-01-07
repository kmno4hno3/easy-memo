import Vue from "vue";
import VueRouter from "vue-router";

// 単一コンポーネント読み込み
import index from "../components/Index.vue";
import login from "../components/Login.vue";
import home from "../components/Home.vue";
import sigunup from "../components/New.vue";

import store from "../store/index.js"

// プラグインを使用
Vue.use(VueRouter);

// ルーティングの設定
const routes = [
  {
    path: "/",
    name: "Index",
    component: index,
    meta: {
      isPublic: true
    }
  },
  {
    path: "/login",
    name: "Login",
    component: login,
    meta: {
      isPublic: true
    }
  },
  {
    path: "/home",
    name: "Home",
    component: home,
  },
  {
    path: "/new",
    name: "New",
    component: sigunup,
  },
];

const router = new VueRouter({
  mode: "history", // URLに#が入らない,etc...
  base: process.env.BASE_URL, // ベースとなるURLを設定(デフォルトは「/」)
  routes,
});

router.beforeEach((to, from, next) => {
  if (to.matched.some(page => page.meta.isPublic) || store.state.auth.token) {
    // ログインが必要な画面 or ログイン済みの場合
    next()
  } else {
    next('/login')
  }
})

export default router;