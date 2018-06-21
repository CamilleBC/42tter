# frozen_string_literal: true

Rails.application.routes.draw do
  get 'welcome/index'
  get '/login', to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :sessions
  resources :users do
    patch 'deactivate', on: :member
    resources :messages do
      patch 'hide', on: :member
    end
  end

  root 'welcome#index'
end
