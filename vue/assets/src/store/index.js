import Vue from 'vue'
import Vuex from 'vuex'

import createPersistentedState from 'vuex-persistedstate' // ブラウザリロードでもstore保持

import auth from '@/store/modules/auth.js'
import http from '@/store/modules/http.js'
import user from '@/store/modules/user.js'

Vue.use(Vuex)


export default new Vuex.Store({
  modules: {
    auth,
    user,
    http,
  },
  plugins: [createPersistentedState({
    key: 'example',
    paths: ['auth'],
    storage: window.sessionStorage
  })]
})