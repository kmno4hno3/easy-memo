<template>
  <v-card>
    <v-toolbar color="cyan" dark flat>
      <v-app-bar-nav-icon></v-app-bar-nav-icon>

      <v-toolbar-title>EasyMemo</v-toolbar-title>

      <v-spacer></v-spacer>

      <v-btn icon>
        <v-icon>mdi-magnify</v-icon>
      </v-btn>

      <v-btn icon>
        <v-icon>mdi-dots-vertical</v-icon>
      </v-btn>

      <template v-slot:extension>
        <v-tabs v-model="tab" align-with-title>
          <v-tabs-slider color="yellow"></v-tabs-slider>

          <v-tab v-for="item in items" :key="item.name">
            <router-link :to="item.path">{{ item.name }}</router-link>
          </v-tab>
        </v-tabs>
      </template>
    </v-toolbar>
  </v-card>
</template>

<script>
export default {
  data() {
    return {
      tab: null,
      items: [
        {
          name: "Index",
          path: "/",
        },
        {
          name: "Home",
          path: "/home",
        },
        {
          name: "Login",
          path: "/login",
        },
        {
          name: "Singup",
          path: "/new",
        },
        {
          name: "Logout",
          path: "/logout",
        },
      ],
    };
  },
};
</script>