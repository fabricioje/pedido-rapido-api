Rails.application.routes.draw do
  mount_devise_token_auth_for "Employee", at: "auth/v1/employee"

  namespace :admin do
    namespace :v1 do
      get "home" => "home#index"
      resources :categories
      resources :employees
      resources :products
    end
  end

  namespace :front do
    namespace :v1 do
      get "home" => "home#index"
      resources :products
    end
  end
end
