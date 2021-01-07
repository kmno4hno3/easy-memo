# ユーザー認証関連
class ApplicationController < ActionController::API
  include AbstractController::Translation

  before_action :authenticate_user_from_token!

  # JSON形式で出力
  respond_to :json

  ##
  # トークンからユーザー認証する
  def authenticate_user_from_token!
    # トークンをヘッダーのAuthorizationから受け取る
    auth_token = request.headers['Authorization']
    if auth_token
      # トークンがある場合
      authenticate_with_auth_token auth_token
    else
      # トークンがない場合
      authenticate_error
    end
  end

  private

  def authenticate_with_auth_token auth_token
    # 「:」が含まれてない場合
    unless auth_token.include?(':')
      authenticate_error
      return
    end

    user_id = auth_token.split(':').first
    user = User.where(id: user_id).first

    if user && Devise.secure_compare(user.access_token, auth_token)
      # ユーザーが登録されている & トークンが正しい場合
      # sign_in:ログイン状態にする
      sign_in user, store: false # store: falseはセッション機能無効
    else
      authenticate_error
    end
  end

  ##
  # 認証失敗
  # Renders a 401 error
  def authenticate_error
    render json: { error: t('devise.failure.unauthenticated') }, status: 401
  end
end
