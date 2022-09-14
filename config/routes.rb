# frozen_string_literal: true

Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  resources :users, only: %i[index]
  resources :posts do
    resources :comments, only: %i[create show index]
    resources :reports, only: %i[create]
    resources :suggestions, only: %i[create destroy index new]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :likes, only: %i[create destroy]
  root to: 'users#index'
end
