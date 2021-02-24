// import axios from "axios";

// axios.interceptors.response.use(response => {
//   console.log("interceptors");
//   return response
// })

// // APIで汎用的な設定のインスタンスを作成
// export default axios.create({
//   // ヘッダーにX-Requested-Withを追加する
//   headers: {
//     // バックエンドにAjaxであることを伝える(Rails側でチェックrequest.xhr?)
//     "X-Requested-With": "XMLHttpRequest",
//   },
//   // リクエストに、sessionとcookieを含めるようにする
//   withCredentials: true,
// });

export default ({ $axios, store, app }) => {
  $axios.onRequest(config => {
    const headers = store.state.auth
    config.headers = headers
  })

  $axios.onResponse(response => {
    if (response.headers['access-token']) {

      const authHeaders = {
        'access-token': response.headers['access-token'],
        'client': response.headers['client'],
        'expiry': response.headers['expiry'],
        'uid': response.headers['uid']
      }
      store.commit('auth', authHeaders)

      const session = app.$cookies.get('session')
      if (session) {
        session.tokens = authHeaders
        app.$cookies.set('session', session, {
          path: '/',
          maxAge: 60 * 60 * 24 * 7
        })
      }

   }
 })

 $axios.onError(error => {
   return Promise.reject(error.response);
 });

}