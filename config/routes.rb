Rails.application.routes.draw do
  mount_devise_token_auth_for 'Employe', at: 'auth/v1/employe'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
