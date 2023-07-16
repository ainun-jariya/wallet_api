# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  namespace :api do
    resources :users
    resources :sessions, only: %i[index create] do
      collection do
        delete :destroy
      end
    end
  end
end
