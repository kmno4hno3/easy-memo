export default {
  namespaced: true,
  state: {
      email: "",
  },
  mutations: {
    show(state, data) {
      state.email = data.data["email"]
    },
  },
  actions: {
    show({ commit, dispatch }, data) {
      let url = "/api/v1/users/" + data["id"];
      dispatch("http/get", { url: url, data }, { root: true })
        .then((res) => {
          commit("show", res);
        })
        .catch((err) => err);
    },
    create({ dispatch }, data) {
      dispatch("http/post", { url: "/api/v1", data }, { root: true })
        .then((res) => {
          res;
        })
        .catch((err) => err);
    },
  },
};
