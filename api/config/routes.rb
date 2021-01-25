Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: '/api/v1/', controllers: {
    omniauth_callbacks: 'api/v1/omniauth_callbacks'
  }

  namespace :api do
    namespace :v1 do
      resources :users
    end
  end

end