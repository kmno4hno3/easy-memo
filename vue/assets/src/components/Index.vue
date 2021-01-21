<template>
  <div class="Index">
    <h1>This is index page</h1>
  </div>
</template>

<script>
export default {
  created: function () {
    if (!this.$store.state.auth.accessToken) {
      console.log("created_logout");
      this.$router.push("/login");
    }
  },
};
</script>