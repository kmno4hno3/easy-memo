export default {
  namespaced: true,
  // 状態(データの定義)
  state: {
    userId: '',
    access_token: ''
  },
  // stateの変更
  mutations: {
    create (state, data) {
      state.userId = data.user_id
      state.access_token = data.access_token
      console.log(state);
    },
    // 
    destroy(state) {
      state.userId = ''
      state.access_token = ''
    },
  },
  // mutationsをコミットする
  actions: {
    create({ commit, dispatch }, data) {
      console.log("auth");
      dispatch(
        'http/post',
        { url: '/api/v1/login', data, error: 'message.unauthorized' },
        { root: true }
      ).then(res => {
        console.log("=======");
        console.log(res);
        commit('create', res.data)
      })
        .catch(err => err)
    },
    destroy({ commit, dispatch }, data) {
      dispatch(
        'http/delete',
        { url: '/api/v1/logout', data },
        { root: true }
      ).then(res => {
        console.log("resres");
        console.log(res.data);
        commit('create', res.data);
      })
        .catch(err => err)
        // logout anyway ...
        // .finally(res => commit('destroy'))
        .finally(commit('destroy'))
    }
  }
}