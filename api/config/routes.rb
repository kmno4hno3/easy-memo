Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: '/api/v1/'

  namespace :api do
    namespace :v1 do
      resources :users
    end
  end

end