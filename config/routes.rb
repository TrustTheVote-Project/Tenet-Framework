Csf::Engine.routes.draw do

  namespace :csf do
  get 'registration_requests/new'
  end

  namespace :csf do
  get 'registration_requests/create'
  end

  get '/about' => 'pages#about', as: 'about'
  get '/login' => 'pages#about', as: 'login'

  resources :registration_requests, only: [ :new, :create ]

  root 'pages#landing'

end
