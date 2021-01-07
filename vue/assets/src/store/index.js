import Vue from 'vue'
import Vuex from 'vuex'

import createPersistentedState from 'vuex-persistedstate' // ブラウザリロードでもstore保持

import auth from './modules/auth.js'

Vue.use(Vuex)

export default new Vuex.Store({
  modules: {
    auth
  },
  plugins: [createPersistentedState({
    key: 'example',
    storage: window.sessionStorage
  })]
})