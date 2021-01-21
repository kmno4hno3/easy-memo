<template>
  <div class="login">
    新規登録
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
        <v-text-field
          v-model="password_confirmation"
          :counter="10"
          label="パスワード(確認)"
          required
        ></v-text-field>
        <v-btn elevation="2" v-on:click="signup()">SINGUP</v-btn>
      </v-form>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      email: "",
      password: "",
      password_confirmation: "",
    };
  },
  methods: {
    signup() {
      this.$store.dispatch("user/create", {
        email: this.email,
        password: this.password,
        password_confirmation: this.password_confirmation,
      });
    },
  },
};
</script>