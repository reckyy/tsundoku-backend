# frozen_string_literal: true

Rails.application.routes.draw do
  post '/api/auth/callback/google', to: 'api/users#create'
  get 'api/auth/add_session_user_data', to: 'api/auth#add_session_user_data'
  namespace :api do
    resources :books, only: %i[index create]
    resources :memos, only: %i[index update]
    resources :reading_logs, only: %i[index create]
    resources :headings, only: %i[update]
    resources :users, only: %i[show update destroy]
    resources :user_books, only: %i[destroy] do
      collection do
        post :move_position
      end
    end
  end
end
