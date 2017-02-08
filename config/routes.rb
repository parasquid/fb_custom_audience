Rails.application.routes.draw do
  get "/auth/facebook", as: "facebook_login"
	get '/auth/:provider/callback', to: 'sessions#create'

  delete "sessions/destroy", as: :logout

  root to: "home#index"
end
