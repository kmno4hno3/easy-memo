# ログインしたユーザーがアカウント情報を問合せできる 
class Api::AccountsController < Api::ApplicationController

  before_action :account_login

  def show
    render json: {email: current_account[:email]}
  end

  private
  def account_login
    # ログインしていない場合、空のjsonを返す
    # リダイレクトさせたいわけではないので authenticate_account! は使わないことにした
    # account_signed_in:ログイン中か確認するメソッド
    return render json: {} unless account_signed_in?
  end
end