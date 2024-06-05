# frozen_string_literal: true

Rails.application.routes.draw do
  post '/api/auth/callback/google', to: 'api/users#create'
end
