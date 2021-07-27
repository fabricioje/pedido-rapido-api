Rails.application.routes.draw do
  mount_devise_token_auth_for 'Employe', at: 'auth/v1/employe'

  namespace :admin do
    namespace :v1 do
      get "home" => "home#index"
      resources :categories
      resources :products
    end
  end
end
