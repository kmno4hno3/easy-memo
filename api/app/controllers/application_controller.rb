class ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken
  skip_before_action :verify_authenticity_token, if: :devise_controller? # APIではCSRFチェックをしない
  before_action :authenticate_user!, unless: :devise_controller?
  # 送信されるパラメーターを選択できる
  before_action :configure_permitted_parameters, if: :devise_controller? 

  private

  def configure_permitted_parameters
    # DBにaccounts.nameカラムがある場合
    # devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    # devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end 
end