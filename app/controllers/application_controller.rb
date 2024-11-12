# frozen_string_literal: true

require 'jwt'

class ApplicationController < ActionController::API
  before_action :camel2snake_params
  before_action :authenticate

  attr_reader :current_user

  private

  def authenticate
    token = request.headers[:Authorization]&.split&.last
    secret_key = Rails.application.credentials.secret_key_base
    decoded_token = JWT.decode(token, secret_key, 'HS256')
    if decoded_token
      @current_user = User.find(decoded_token[0]['id'])
    else
      render json: { errors: ['Not Authenticated'] }, status: :unauthorized
    end
  end

  def camel2snake_params
    params.deep_transform_keys!(&:underscore)
  end
end
