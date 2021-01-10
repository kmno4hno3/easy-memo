import Vue from "vue";
import VueRouter from "vue-router";

// 単一コンポーネント読み込み
import index from "@/components/Index.vue";
import login from "@/components/Login.vue";
import logout from "@/components/Logout.vue";
import home from "@/components/Home.vue";
import signup from "@/components/New.vue";

import store from "@/store/index.js"

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
    path: "/logout",
    name: "Logout",
    component: logout,
  },
  {
    path: "/home",
    name: "Home",
    component: home,
  },
  {
    path: "/new",
    name: "New",
    component: signup,
  },
];

const router = new VueRouter({
  mode: "history", // URLに#が入らない,etc...
  base: process.env.BASE_URL, // ベースとなるURLを設定(デフォルトは「/」)
  routes,
});

router.beforeEach((to, from, next) => {
  if (to.matched.some(page => page.meta.isPublic) || store.state.auth.access_token) {
    // ログインが必要な画面 or ログイン済みの場合
    next()
  } else {
    next('/login')
  }
})

export default router;