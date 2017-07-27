Rails.application.routes.draw do
  use_doorkeeper
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :admin do
    root "home#index"
  end

  namespace :api do
    namespace :v1 do
      resources :users
    end
  end
end
