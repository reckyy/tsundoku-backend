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

  def verify_google_id_token
    audience = ENV.fetch('AUDIENCE')
    issuer = ENV.fetch('ISSUER')

    begin
      Google::Auth::IDTokens.verify_oidc(params[:id_token], aud: audience, iss: issuer)
    rescue Google::Auth::IDTokens::VerificationError => e
      render json: { errors: ["Not Authenticated #{e.message}"] }, status: :unauthorized
    end
  end
end
