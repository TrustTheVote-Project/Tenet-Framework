Rails.application.routes.draw do

  root 'csf/pages#landing'

  get  '/user_dash'  => 'csf/pages#landing'
  get  '/admin_dash' => 'csf/pages#admin_dashboard'

end
