# ログイン関連controller共通設定
class Api::ApplicationController < ActionController
  # CSRF対策用のトークンを用いないのでチェックを外す
  skip_before_action :verify_authenticity_token

  # リクエストがxhr(XMLHttpRequest)であることをチェックする
  before_action :check_xhr_header

  private
  def check_xhr_header
    # 「X-Requested-With」ヘッダーに「XMLHttpRequest」が含まれているか？
    return if request.xhr?

    render json: { error: 'forbidden' }, status: :forbidden
  end
end