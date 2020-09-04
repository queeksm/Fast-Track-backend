Rails.application.routes.draw do
  resources :car do
    resources :periodic_check
  end

  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'users#create'
end
