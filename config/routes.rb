# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admins, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  root 'pages#index'
  post 'locales/:locale', to: 'locales#create', as: 'set_locale'
  resources :books, only: %i[index show], param: :slug
  resources :book_categories, only: %i[index show], param: :slug
end
