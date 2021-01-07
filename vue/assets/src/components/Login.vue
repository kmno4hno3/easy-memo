<template>
  <div class="login">
    login
    <div>
      <div>{{ this.message }}</div>
      <input type="text" v-model="email" placeholder="メールアドレス" /><br />
      <input type="text" v-model="password" placeholder="パスワード" /><br />
      <button v-on:click="login()">LOGIN</button>
    </div>
  </div>
</template>

<script>
import axios from "../../util/axios";
const qs = require("qs");

export default {
  name: "logIn",
  data(){
    return {
      email: "",
      password: "",
      message: "",
    };
  },
  methods: {
    async login(){
      // const self = this;
      const result = await axios
        .post("/api/v1/login",{
          user: {
            email: this.email,
            password: this.password,
          },
          // クエリパラメータをオブジェクトで送信する設定
          paramsSerializer: function(params){
            // クエリ文字列生成(a: ['b', 'c'] → 'a[]=b&a[]=c')
            return qs.stringify(params, { arrayFormat: "brackets" });
          },
        })
        .catch((e) => {
          console.error(e);
        });
      console.log(result);
      if (!result){
        this.message = "エラー";
        return;
      }
      if(!result.data){
        this.message = "エラー";
        return;
      }

      if(result.status){
        // 結果を基にページ遷移
        this.$router.push("/home");
      }
    },
  },
};
</script>