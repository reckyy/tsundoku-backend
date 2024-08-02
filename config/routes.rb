# frozen_string_literal: true

Rails.application.routes.draw do
  post '/api/auth/callback/google', to: 'api/users#create'
  namespace :api do
    resources :books, only: %i[index create] do
      resources :memos, only: %i[index update]
    end
    resources :reading_logs, only: %i[index create]
    resources :headings, only: %i[update]
    resources :users, only: %i[show destroy]
    resources :user_books, only: %i[destroy]
  end
end
