# ログイン・ログアウト処理を行う
class Api::SessionController < Api::ApplicationController
  def log_in
    account = Account.find_for_database_authentication(email: account_param[:email])

    return render json: { result: false } if account.nil?

    if account.valid_password?(account_param[:password])
      # パスワードが正しい場合
      sign_in :account, account
      render json: {state: true}
    else
      # パスワードが正しくない場合
      render json: {state: false}
    end
  end

  def log_out
    # current_account:サインインしているユーザーを取得するメソッド
    sign_out current_account
    render json: {state: true}
  end

  private
  def account_param
    # params:送られた情報を取得するメソッド
    # 送られてきたパラメータは:emailと:passwordのみ許可
    params.require(:account).permit(:email, :password)
  end
end