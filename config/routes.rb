Rails.application.routes.draw do
  resources :items
  
  namespace :api do
    namespace :v1 do
      resources :menus
      resources :menu_items
      resources :restaurants
    end
  end

  root "welcome#index"

  # get "up" => "rails/health#show", as: :rails_health_check
end
