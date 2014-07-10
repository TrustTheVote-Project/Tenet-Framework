Rails.application.routes.draw do

  get  '/about'    => 'csf/pages#about', as: 'about'
  get  '/login'    => 'user_sessions#new', as: 'login'
  post '/login'    => 'user_sessions#create'
  get  '/logout'   => 'user_sessions#destroy'

  get  '/register' => 'registration_requests#new', as: 'new_registration_request'
  post '/register' => 'registration_requests#create'

  get  '/data/organizations_in_state.json' => 'data#organizations_in_state', as: 'organizations_in_state'

  get  '/user_dashboard'  => 'csf/pages#user_dashboard', as: 'user_dashboard'


  namespace :group_admin do
    get '/users' => 'users#index', as: 'dashboard'
    get '/app_management' => 'pages#app_management', as: 'app_management'

    resources :users
  end


  namespace :admin_admin, path: 'admin' do
    get '/' => 'registration_requests#index', as: 'dashboard'

    resources :registration_requests
    resources :groups

    get  '/login'  => 'user_sessions#new', as: 'login'
    post '/login'  => 'user_sessions#create'
    get  '/logout' => 'user_sessions#destroy', as: 'logout'
  end

end
