Rails.application.routes.draw do

  # root "pages#test"

  mount Csf::Engine => "/"

end
