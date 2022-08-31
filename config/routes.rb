# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  resources :users

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :posts do
    resources :comments
  end
  resources :posts do
    resources :suggestions, only: %i[create destroy index new]
  end
  resources :likes, only: %i[create destroy]
  root to: 'users#index'
end
