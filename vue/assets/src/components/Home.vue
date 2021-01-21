<template>
  <div class="home">
    <span>{{ displayEmail }}</span>
  </div>
</template>

<script>
export default {
  methods: {
    async getAccountData() {
      this.$store.dispatch("user/show", {
        id : this.$store.state.auth.id
      });
    },
  },
  computed: {
    displayEmail: function(){
      return this.$store.state.user.email;
    }
  },
  async mounted() {
    this.getAccountData();
  },
};
</script>