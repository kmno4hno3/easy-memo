<template>
  <div>
    <v-btn elevation="2" v-on:click="logout()">Logout</v-btn>
  </div>
</template>

<script>
export default {
  methods: {
    logout() {
      this.$store.dispatch("auth/destroy");
    },
  },
  computed: {
    token() {
      return this.$store.state.auth.accessToken;
    },
  },
  created: function () {
    if (!this.$store.state.auth.accessToken) {
      this.$router.push("/login");
    }
  },
  watch: {
    token() {
      this.$router.push("/login");
    },
  },
};
</script>