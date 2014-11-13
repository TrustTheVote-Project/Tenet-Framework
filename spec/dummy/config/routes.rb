Rails.application.routes.draw do

  root "tenet/pages#landing"

  get  '/user_dash'  => 'tenet/pages#landing'
  get  '/admin_dash' => 'tenet/pages#admin_dashboard'

end
