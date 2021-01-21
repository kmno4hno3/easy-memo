# class Api::V1::UsersController < ApplicationController
class Api::V1::UsersController < ApplicationController
  def index
  end

  def show
    p "show呼び出し"
    @user = User.find(params[:id])
    render json: @user, serializer: Api::V1::UsersSerializer
  end
end