import axios from 'axios'

export default {
  namespaced: true,
  actions: {
    async request({ rootState }, { method, url, data }) {
        const headers = {}
        headers['Content-Type'] = 'application/json'
        if(rootState.auth.token){
          headers['Authorization'] = `Token ${rootState.auth.token}`
          headers['User-Id'] = rootState.auth.userId
        }

        console.log(rootState);

        const options = {
          method,
          url: `${url}`,
          headers,
          data,
          timeout: 15000
        }

        return axios(options)
          .then(res => res)
          .catch(err => {
            console.log("err");
            console.log(err);
          })
      },
    async post ({ dispatch }, requests) {
      console.log("http");
      requests.method = 'post'
      return dispatch('request', requests)
    },
    async delete ({ dispatch }, requests) {
      requests.method = 'delete'
      return dispatch('request', requests)
    }
  }
}