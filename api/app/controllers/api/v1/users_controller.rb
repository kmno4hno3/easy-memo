# class Api::V1::UsersController < ApplicationController
class Api::V1::UsersController < ApplicationController
  def index
  end

  def show
    @user = User.find(params[:id])
    render json: @user, serializer: Api::V1::UsersSerializer
  end

  # def user_params
  #   params.require(:id)
  # end
end