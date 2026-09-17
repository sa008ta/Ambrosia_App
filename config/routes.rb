Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  root "pages#landing"

  get "/loading", to: "pages#loading", as: :loading

  get "/login", to: "sessions#new", as: :login
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy", as: :logout

  get "/signup/:role", to: "users#new", as: :signup
  post "/signup/:role", to: "users#create"

  get "/home", to: "pages#home", as: :home
  get "/information", to: "pages#information", as: :information
  get "/settings", to: "pages#settings", as: :settings
  get "/settings/account_top", to: "pages#account_top", as: :account_top
  get "/settings/history", to: "pages#history", as: :history
  get "/settings/language", to: "pages#language_settings", as: :language_settings
  patch "/settings/account_top", to: "users#update_account", as: :account_top_update
  patch "/settings/language", to: "users#update_language", as: :language_update
  get "/menu/:id", to: "pages#menu_detail", as: :menu_detail
  post "/menu/:id/order", to: "pages#order", as: :menu_order
  resources :products, only: [:index, :new, :create, :edit, :update, :destroy]

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
