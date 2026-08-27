Rails.application.routes.draw do
  get "accounts/index"
  get "accounts/new"
  get "accounts/create"
  namespace :admin do
    get "dashboard/index"
    get "admin/index"
  end
  get "admin/index"
  get "profiles/show"
  devise_for :users
  get "demo", to: "demo#index"
  post "demo", to: "demo#update"
  
  get "pages/home"
  get "pages/about"
  get "profile", to: "profiles#show"
  get "home/index"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Resources
  resources :accounts, only: [:index, :new, :create]

  # Defines the root path route ("/")
  root "home#index"

  namespace :admin do
    root "dashboard#index"
  end
end
