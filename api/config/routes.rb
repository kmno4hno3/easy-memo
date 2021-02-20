Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      mount_devise_token_auth_for 'User', controllers: {
        omniauth_callbacks: 'api/v1/omniauth_callbacks'
      }
      resources :users
    end
  end

end