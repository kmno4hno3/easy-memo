import axios from "axios";

export default {
  namespaced: true,
  actions: {
    async request({ rootState }, { method, url, data }) {
      const headers = {};
      headers["Content-Type"] = "application/json";
      if (rootState.auth.accessToken) {
        headers["access-token"] = `${rootState.auth.accessToken}`;
        headers["client"] = `${rootState.auth.client}`;
        headers["uid"] = `${rootState.auth.uid}`;
      }

      const options = {
        method,
        url: `${url}`,
        headers,
        data,
        timeout: 15000,
      };

      return axios(options)
        .then((res) => res)
        .catch((err) => {
          err;
        });
    },
    async get({ dispatch }, requests) {
      requests.method = "get";
      return dispatch("request", requests);
    },
    async post({ dispatch }, requests) {
      requests.method = "post";
      return dispatch("request", requests);
    },
    async delete({ dispatch }, requests) {
      requests.method = "delete";
      return dispatch("request", requests);
    },
  },
};
