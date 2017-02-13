Rails.application.routes.draw do

  resources :ad_accounts, only: [:index, :show]

  namespace :data_source do
    namespace :ad_accounts do
      get 'custom_audiences/:id', to: "custom_audiences#show", as: "custom_audience"
      post "custom_audiences/workflows"
      namespace :custom_audiences do
        post "uploads", to: "uploads#create"
      end
    end
  end

  get "/auth/facebook", as: "facebook_login"
	get '/auth/:provider/callback', to: 'sessions#create'

  delete "sessions/destroy", as: :logout

  namespace :api do
    post 'maropost_update', to: 'maropost#update'
  end

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  root to: "home#index"
end
