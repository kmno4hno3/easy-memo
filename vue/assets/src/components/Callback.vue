<template>
  <div></div>
</template>

<script>
export default {
  namespaced: true,
  // 状態(データの定義)
  state: {
    accessToken: "",
    client: "",
    expiry: "",
    uid: "",
    id: "",
  },
  // stateの変更
  mutations: {
    create(state, data) {
      state.accessToken = data["access-token"];
      state.client = data["client"];
      state.expiry = data["expiry"];
      state.uid = data["uid"];
      state.id = data["id"];
    },
  },
  created() {
    let queryString = window.location.search;
    let queryObject = new Object();
    if (queryString) {
      queryString = queryString.substring(1);
      let params = queryString.split("&");

      for (let i = 0; i < params.length; i++) {
        let elem = params[i].split("=");
        let key = decodeURIComponent(elem[0]);
        let value = decodeURIComponent(elem[1]);

        queryObject[key] = value;
      }
      console.log("auth_token");
      console.log(queryObject["auth_token"]);
    }
    console.log("callback");

    let json = {
      "access-token": queryObject["auth_token"],
      "client": queryObject["client"],
      "expiry": queryObject["expiry"],
      "uid": queryObject["uid"],
      "id": queryObject["id"],
    };

    console.log(this.$store);
    this.$store.commit("create", json);

  },
};
</script>