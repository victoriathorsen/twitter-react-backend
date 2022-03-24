Rails.application.routes.draw do
  resources :tweets
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :registrations, only: [:create]
  get :login, to: 'sessions#login'
  post :login, to: 'sessions#create'


  # Routes for Google authentication
  # get ‘auth/:provider/callback’, to: ‘sessions#googleAuth’
  # get ‘auth/failure’, to: redirect(‘/’)

end
