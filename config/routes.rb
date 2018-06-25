# frozen_string_literal: true

Rails.application.routes.draw do
  get 'welcome/index'
  get '/about', to: 'welcome#about'
  get '/login', to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :sessions
  resources :users do
    patch 'deactivate', on: :member
    patch 'reactivate', on: :member
    resources :messages do
      patch 'hide', on: :member
    end
  end

  root 'welcome#index'
end
