# frozen_string_literal: true

Rails.application.routes.draw do
  post '/api/auth/callback/google', to: 'api/users#create'
  get '/api/books', to: 'api/books#index'
  post '/api/books', to: 'api/books#create'
  get 'api/books/:id/memos', to: 'api/memos#index', constraints: { id: /\d+/ }
  patch 'api/books/:id/memos', to: 'api/memos#update', constraints: { id: /\d+/ }
  delete 'api/users/:uid', to: 'api/users#destroy', constraints: { uid: /\d+/ }
  get 'api/reading_logs', to: 'api/reading_logs#index'
  get '/api/users/:uid', to: 'api/users#show', constraints: { uid: /\d+/ }
  patch 'api/headings', to: 'api/headings#update'
  patch 'api/reading_logs', to: 'api/reading_logs#create'
end
