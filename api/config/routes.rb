Rails.application.routes.draw do
  # devise_for:指定したリソース（モデル）を使用した認証関連のルーティングの設定する
  devise_for :accounts, skip: [:sessions, :passwords, :registrations]

  namespace :api do
    post '/login', to: 'session#log_in'
    post '/logout', to: 'session#log_out'
    get '/account', to: 'accounts#show'
  end
end
