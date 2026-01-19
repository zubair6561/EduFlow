Rails.application.routes.draw do
  devise_for :users

  get "up" => "rails/health#show", as: :rails_health_check

  authenticated :user do
    root to: "dashboards#redirect", as: :authenticated_root
  end

  root "landing#home"
  get "dashboard", to: "dashboards#redirect"

  namespace :admin do
    get "dashboard", to: "dashboard#show"
  end

  namespace :instructor do
    get "dashboard", to: "dashboard#show"
  end

  namespace :student do
    get "dashboard", to: "dashboard#show"
  end

  resources :courses do
    resources :lessons, except: [:index], shallow: true
    resources :enrollments, only: :create
  end

  resources :enrollments, only: :destroy
  resources :lesson_progresses, only: :update, param: :lesson_id
end
