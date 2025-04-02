Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :menus
      resources :menu_items
      resources :restaurants
      resources :items

      # testing the json
      resources :json_imports, only: [ :create ]
    end
  end



  root "welcome#index"
end
