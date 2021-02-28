<template>
  <div></div>
</template>

<script>
export default {
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
    }

    let json = {
      "access-token": queryObject["auth_token"],
      "client": queryObject["client_id"],
      "expiry": queryObject["expiry"],
      "uid": queryObject["uid"],
      "id": queryObject["id"],
    };
    console.log(json);

    this.$store.dispatch("auth/oauth_create", json);
  }
}
</script>