Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :menus
      resources :menu_items
    end
  end

  root "welcome#index"

  # get "up" => "rails/health#show", as: :rails_health_check
end
