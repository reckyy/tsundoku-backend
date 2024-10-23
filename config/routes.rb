# frozen_string_literal: true

Rails.application.routes.draw do
  post '/api/auth/callback/google', to: 'api/users#create'
  namespace :api do
    resources :books, only: %i[create]
    resources :memos, only: %i[index update]
    resources :reading_logs, only: %i[index create]
    resources :headings, only: %i[update]
    resources :users, only: %i[show update destroy]
    resources :user_books, only: %i[index create destroy] do
      member do
        patch :position
      end
    end
  end
end
