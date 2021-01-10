<template>
  <div class="login">
    login
    <div>
      <input type="text" v-model="email" placeholder="メールアドレス" /><br />
      <input type="text" v-model="password" placeholder="パスワード" /><br />
      <button v-on:click="login()">LOGIN</button>
    </div>
  </div>
</template>

<script>
export default {
  data(){
    return {
      email: "",
      password: "",
    }
  },
  methods: {
    login(){
     this.$store.dispatch(
       'auth/create',
       {
          'user': {
            email: this.email,
            password: this.password
          }
       }
     )
    }
  },
  computed: {
    token(){
      return this.$store.state.auth.token
    }
  },
  created: function(){
    if (this.$store.state.auth.access_token){
      this.$router.push('/')
    }
  },
  // watch: {
  //   token () {
  //     this.$router.push('/')
  //   }
  // }
}
</script>

