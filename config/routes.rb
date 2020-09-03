Rails.application.routes.draw do
  resources :car do
    resources :periodic_check
  end
end
