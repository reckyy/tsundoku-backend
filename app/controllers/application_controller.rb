# frozen_string_literal: true

require 'googleauth'

class ApplicationController < ActionController::API
  before_action :camel2snake_params
  before_action :verify_google_id_token

  attr_reader :current_user

  private

  def verify_google_id_token
    audience = ENV.fetch('AUDIENCE')
    issuer = ENV.fetch('ISSUER')
    id_token = request.headers[:Authorization]&.split&.last
    Rails.logger.debug(id_token)

    begin
      payload = Google::Auth::IDTokens.verify_oidc(id_token, aud: audience, iss: issuer)
      @current_user = User.find_by!(name: payload['name'], email: payload['email'])
    rescue Google::Auth::IDTokens::VerificationError
      render json: { errors: ['Not Authenticated'] }, status: :unauthorized
    end
  end

  def camel2snake_params
    params.deep_transform_keys!(&:underscore)
  end
end
