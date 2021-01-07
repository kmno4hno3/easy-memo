Rails.application.routes.draw do
  # デフォルトのアクションを削除している?
  devise_for :users, only: []

  namespace :api do
    namespace :v1, defaults: { format: :json } do
      resource :login, only: [:create], controller: :sessions
      resources :users, only: [:index, :show, :create]
    end
  end
end