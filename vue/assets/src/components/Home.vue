<template>
  <div class="home">
    <span>{{ email }}</span>
  </div>
</template>

<script>
import axios from "../../util/axios";

export default {
  name: "Home",
  data() {
    return {
      email: "",
    };
  },
  methods: {
    async getAccountData() {
      const result = await axios.get("/api/v1/user").catch((e) => {
        console.error(e);
      });
      console.log("home");

      if(!result){
        // エラーの場合ログイン画面へ遷移させる
        this.redirectLogin();
        return;
      }
      if(!result.data.email){
        // エラーの場合ログイン画面へ遷移させる
        this.redirectLogin();
        return;
      }

      this.email = result.data.email;
    },
    redirectLogin(){
      // ページ遷移
      this.$router.push("/login");
    },
  },
  // インスタンスがマウントされた後に呼ばれる
  async mounted() {
    this.getAccountData();
  },
};
</script>