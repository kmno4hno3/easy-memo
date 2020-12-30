<template>
  <a v-on:click="logout()">Logout</a>
</template>

<script>
import axios from "../../util/axios";

export default {
  name: "logout",
  methods: {
    async logout() {
      // const self = this;
      const result = await axios.post("/api/logout").catch((e) => {
        console.error(e);
      });

      if(!result){
        this.message = "エラー";
        return;
      }
      if(!result.data){
        this.message = "エラー";
        return;
      }

      if(result.data.state){
        // 結果を基にページ遷移
        this.$router.push("/");
      }
    },
  },
};
</script>