# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :lists do
    resources :items do
      member do
        patch :update_position
      end
    end

    member do
      patch :update_position
    end
  end
  root to: 'lists#index'
end
