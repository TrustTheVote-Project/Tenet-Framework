Rails.application.routes.draw do

  get  '/about'    => 'csf/pages#about', as: 'about'
  get  '/login'    => 'user_sessions#new', as: 'login'
  post '/login'    => 'user_sessions#create'

  get  '/register' => 'registration_requests#new', as: 'new_registration_request'
  post '/register' => 'registration_requests#create'

  get  '/data/organizations_in_state.json' => 'data#organizations_in_state', as: 'organizations_in_state'

  get  '/admin_dashboard' => 'csf/pages#admin_dashboard', as: 'admin_dashboard'
  get  '/user_dashboard'  => 'csf/pages#user_dashboard', as: 'user_dashboard'

end
