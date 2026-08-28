Rails.application.routes.draw do
  # namespace
  namespace :api do
    namespace :v1 do
      get "payment_webhooks", to: "payment_webhooks#create"
      post "payment_webhooks", to: "payment_webhooks#create"
    end
  end
  
  namespace :admin do
    get "dashboard/index"
    get "admin/index"
  end

  namespace :admin do
    root "dashboard#index"
  end

  # Resources
  resources :accounts, only: [:index, :new, :create]

  # Devise
  devise_for :users

  # simple get post
  get "accounts/index"
  get "accounts/new"
  get "accounts/create"
  get "admin/index"
  get "profiles/show"
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

  # Defines the root path route ("/")
  root "home#index"
end
