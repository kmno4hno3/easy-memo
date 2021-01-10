<template>
  <div>
    <button v-on:click="logout()">Logout</button>
  </div>
</template>

<script>
export default {
  data() {
    return {
      email: "",
      password: "",
    };
  },
  methods: {
    logout() {
      this.$store.dispatch("auth/destroy", {
        user: {
          email: this.email,
          password: this.password,
        },
      });
    },
  },
  computed: {
    token() {
      return this.$store.state.auth.token;
    },
  },
  // watch: {
  //   token () {
  //     this.$router.push('/')
  //   }
  // }
};
</script>