module Api
  module V1
    class SessionsController < ApplicationController
      skip_before_action :authenticate_user_from_token!

      # POST /api/v1/login
      def create
        # 送られてきたemailのユーザー情報を取得
        @user = User.find_for_database_authentication(email: user_param[:email])
        # emailがない場合
        return invalid_email unless @user

        if @user.valid_password?(user_param[:password])
          # パスワードが正しい場合
          p sign_in :user, @user
          render json: @user, serializer: SessionSerializer, root: nil
        else
          # パスワードが正しくない場合
          invalid_password
        end
      end

      private

      # jsonを返す(emailが正しくないとエラー)
      def invalid_email
        warden.custom_failure!
        render json: { error: t('invalid_email') }
      end

      # jsonを返す(パスワードが正しくないとエラー)
      def invalid_password
        warden.custom_failure!
        render json: { error: t('invalid_password') }
      end

      private
      def user_param
        params.require(:user).permit(:email, :password)
      end
    end
  end
end