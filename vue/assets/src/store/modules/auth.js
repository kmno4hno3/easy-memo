export default {
  namespaced: true,
  // 状態(データの定義)
  state: {
    tenant: '',
    userId: '',
    token: ''
  },
  // stateの変更
  mutations: {
    create (state, data) {
      state.tenant = ''
      state.token = data.token
      state.userId = data.user_id
    },
    // 
    destroy(state) {
      state.tenant = ''
      state.token = ''
      state.userId = ''
    },
  },
  // mutationsをコミットする
  actions: {
    create({ commit, dispatch }, data) {
      console.log("auth");
      dispatch(
        'http/post',
        { url: '/auth', data, error: 'message.unauthorized' },
        { root: true }
      ).then(res => commit('create', res.data))
        .catch(err => err)
    },
    destroy({ commit, dispatch }, data) {
      dispatch(
        'http/delete',
        { url: '/auth', data },
        { root: true }
      ).then(res => commit('create', res.data))
        .catch(err => err)
        // logout anyway ...
        // .finally(res => commit('destroy'))
        .finally(commit('destroy'))
    }
  }
}