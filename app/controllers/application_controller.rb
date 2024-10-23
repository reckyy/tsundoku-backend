# frozen_string_literal: true

class ApplicationController < ActionController::API
  before_action :camel2snake_params
  before_action :authenticate

  attr_reader :current_user

  def create_token(user_id)
    payload = { user_id: }
    secret_key = Rails.application.credentials.secret_key_base
    JWT.encode(payload, secret_key, 'HS256')
  end

  private

  def authenticate
    token = request.headers[:Authorization]&.split&.last
    secret_key = Rails.application.credentials.secret_key_base
    decoded_token = JWT.decode(token, secret_key, 'HS256')
    user_id = decoded_token[0]&.fetch('user_id')
    if user_id
      @current_user = User.find(user_id)
    else
      render json: { errors: ['Not Authenticated'] }, status: :unauthorized
    end
  end

  def camel2snake_params
    params.deep_transform_keys!(&:underscore)
  end
end
