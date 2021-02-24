<template>
  <div class="login">
    login
    <div>
      <v-form>
        <v-text-field
          v-model="email"
          :counter="10"
          label="メールアドレス"
          required
        ></v-text-field>
        <v-text-field
          v-model="password"
          :counter="10"
          label="パスワード"
          required
        ></v-text-field>
        <v-btn elevation="2" v-on:click="login()">LOGIN</v-btn>
      </v-form>
      <v-btn elevation="2">
        <a v-bind:href="twitter_url">Twitter</a>
      </v-btn>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      email: "",
      password: "",
      twitter_url: "/api/v1/twitter?auth_origin_url=" + location.origin + "/twitter/callback",
    };
  },
  methods: {
    login() {
      this.$store.dispatch("auth/create", {
        email: this.email,
        password: this.password,
      });
    },
  },
  computed: {
    token() {
      return this.$store.state.auth.accessToken;
    },
  },
  created: function () {
    console.log("created");
    if (this.$store.state.auth.accessToken) {
      this.$router.push("/");
    }
  },
  watch: {
    token() {
      console.log("watch");
      this.$router.push("/");
    },
  },
};
</script>

<style>
a {
  text-decoration: none;
}
</style>