# frozen_string_literal: true

Rails.application.routes.draw do
  get 'welcome/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users do
    resources :messages
  end

  root 'welcome#index'
end
