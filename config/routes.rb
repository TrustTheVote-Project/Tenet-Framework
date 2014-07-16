Rails.application.routes.draw do

  get   '/about'    => 'csf/pages#about', as: 'about'
  get   '/login'    => 'user_sessions#new', as: 'login'
  post  '/login'    => 'user_sessions#create'
  get   '/logout'   => 'user_sessions#destroy'

  get   '/forgot-password'       => 'password_resets#new', as: 'forgot_password'
  post  '/forgot-password'       => 'password_resets#create'
  get   '/reset-password/:token' => 'password_resets#edit', as: 'reset_password'
  patch '/reset-password/:token' => 'password_resets#update'
  get   '/init-password/:token'  => 'password_resets#edit', as: 'init_password'
  patch '/init-password/:token'  => 'password_resets#update'

  get   '/register' => 'registration_requests#new', as: 'new_registration_request'
  post  '/register' => 'registration_requests#create'

  get   '/data/organizations_in_state.json' => 'data#organizations_in_state', as: 'organizations_in_state'

  get   '/user-dashboard'  => 'csf/pages#user_dashboard', as: 'user_dashboard'


  namespace :group_admin do
    get '/users'          => 'users#index', as: 'dashboard'
    get '/app-management' => 'pages#app_management', as: 'app_management'

    resources :users
  end


  namespace :admin_admin, path: 'admin' do
    get '/'               => 'registration_requests#index', as: 'dashboard'
    get '/app-management' => 'pages#app_management', as: 'app_management'

    get  '/login'         => 'user_sessions#new', as: 'login'
    post '/login'         => 'user_sessions#create'
    get  '/logout'        => 'user_sessions#destroy', as: 'logout'

    resources :registration_requests
    resources :groups
  end

end
