module Api
  module V1
    class UsersController < ApplicationController
      # createメソッド(新規登録)のみ直前にトークンからユーザー認証する
      skip_before_action :authenticate_user_from_token!, only: [:create]

      # GET api/v1/users#index
      def index
        render json: User.all, each_serializer: Api::V1::UserSerializer
      end

      # GET api/v1/users#show
      def show
        render json: { email: current_account[:email] }
      end

      # POST /api/v1/users
      # 新規登録
      def create
        @user = User.new user_params

        if @user.save!
          # 正しい入力内容の場合
          sign_in @user
          render json: @user, serializer: Api::V1::SessionSerializer, root: nil
        else
          # 正しくない入力内容の場合
          render json: { error: t('user_create_error') }, status: :unprocessable_entity
        end
      end

      private

      # クエリパラメーターの値を指定
      def user_params
        params.require(:user).permit(:name, :email, :password)
      end
    end
  end
end
