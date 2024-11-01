# frozen_string_literal: true

Rails.application.routes.draw do
  get 'up' => 'rails/health#show', as: :rails_health_check

  devise_for :admins, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  namespace :admin do
    resources :products do
      member do
        delete :delete_image
      end
    end
  end

  root 'pages#index'
  post 'locales/:locale', to: 'locales#create', as: 'set_locale'
  resources :products, param: :slug
end
