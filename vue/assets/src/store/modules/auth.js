export default {
  namespaced: true,
  // 状態(データの定義)
  state: {
    accessToken: "",
    client: "",
    expiry: "",
    uid: "",
    id: "",
  },
  // stateの変更
  mutations: {
    create(state, data) {
      state.accessToken = data["access-token"];
      state.client = data["client"];
      state.expiry = data["expiry"];
      state.uid = data["uid"];
      state.id = data["id"];
    },
    //
    destroy(state) {
      state.accessToken = "";
      state.client = "";
      state.expiry = "";
      state.uid = "";
      state.id = "";
    },
  },
  // mutationsをコミットする
  actions: {
    create({ commit, dispatch }, data) {
      dispatch("http/post", { url: "/api/v1/sign_in", data }, { root: true })
        .then((res) => {
          let mergedRes = Object.assign(res.data.data, res.headers)
          commit("create", mergedRes);
        })
        .catch((err) => err);
    },
    oauth_create({ commit }, data){
      commit("create", data);
    },
    destroy({ commit, dispatch }) {
      dispatch("http/delete", { url: "/api/v1/sign_out" }, { root: true })
        .then((res) => {
          commit("create", res);
        })
        .catch((err) => err)
        // logout anyway ...
        // .finally(res => commit('destroy'))
        .finally(commit("destroy"));
    },
  },
};
