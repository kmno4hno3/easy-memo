# frozen_string_literal: true

DeviseTokenAuth.setup do |config|
  # リクエストごとにトークンを更新するか
  # 扱いやすいようにFalseにする
  config.change_headers_on_each_request = false

  # トークンの有効期間
  # デフォルトでは2週間
  config.token_lifespan = 2.weeks

  # ヘッダーの名前の対応
  config.headers_names = {:'access-token' => 'access-token',
                         :'client' => 'client',
                         :'expiry' => 'expiry',
                         :'uid' => 'uid',
                         :'token-type' => 'token-type' }
end
