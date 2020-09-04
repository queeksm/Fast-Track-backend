Rails.application.routes.draw do
  resources :car, only: [:show, :index] do
    resources :periodic_check, only: [:show, :index]
  end

  root to: 'car#index'

  get '/', to: 'car#index'

  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'users#create'
  post 'car/create', to: 'car#create'
  put 'car/update/:id', to: 'car#update'
  delete 'car/destroy/:id', to: 'car#destroy'
  put 'checks/update/:car_id/:id', to: 'periodic_check#update'
  post 'checks/create/:car_id', to: 'periodic_check#create'
  delete 'checks/destroy/:car_id/:id', to: 'periodic_check#destroy'
end
