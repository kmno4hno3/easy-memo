import Vue from "vue";
import VueRouter from "vue-router";
// 単一コンポーネント読み込み
import index from "../views/Index.vue";
import login from "../views/Login.vue";
import home from "../views/Home.vue";

// プラグインを使用
Vue.use(VueRouter);

// ルーティングの設定
const routes = [
  {
    path: "/",
    name: "Index",
    component: index,
  },
  {
    path: "/login",
    name: "Login",
    component: login,
  },
  {
    path: "/home",
    name: "Home",
    component: home,
  },
];

const router = new VueRouter({
  mode: "history", // URLに#が入らない,etc...
  base: process.env.BASE_URL, // ベースとなるURLを設定(デフォルトは「/」)
  routes,
});

export default router;