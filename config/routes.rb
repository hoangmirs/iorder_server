Rails.application.routes.draw do
  use_doorkeeper do
    skip_controllers :applications, :authorized_applications
    controllers tokens: "custom_tokens"
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :admin do
    root "home#index"
    resources :categories
    resources :products
  end

  namespace :api do
    namespace :v1 do
      resource :sessions do
        post "login", to: "sessions#create"
        delete "logout", to: "sessions#destroy"
      end
      resource :social_authentications, only: :create

      resources :users
      resources :categories
    end
  end
end
