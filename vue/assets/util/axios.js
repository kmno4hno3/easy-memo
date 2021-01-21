import axios from "axios";

// APIで汎用的な設定のインスタンスを作成
export default axios.create({
  // ヘッダーにX-Requested-Withを追加する
  headers: {
    // バックエンドにAjaxであることを伝える(Rails側でチェックrequest.xhr?)
    "X-Requested-With": "XMLHttpRequest",
  },
  // リクエストに、sessionとcookieを含めるようにする
  withCredentials: true,
});