Rails.application.routes.draw do
  devise_for :admins, skip: [ :registration ], controllers: { sessions: "admins/sessions" }
  get "admin", to: "admin#show", as: :admin
  namespace :admin do
    resources :projects, only: :index
    resources :artworks, only: :index
    resources :posts, only: :index
  end
  root "pages#about"
  get "resume", to: "pages#resume"
  resources :projects
  resources :artworks, except: :show
  resources :posts
  resource :contact, only: [ :new, :create ]

  match "/404", to: "errors#not_found", via: :all
end
