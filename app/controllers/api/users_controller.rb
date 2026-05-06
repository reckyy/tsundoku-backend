# frozen_string_literal: true

module API
  class UsersController < ApplicationController
    JWT_EXPIRATION = 30.days

    before_action :verify_google_id_token, only: %i[create]
    skip_before_action :authenticate, only: %i[show create]

    def show
      user = User.find(params[:id])
      render json: UserInfoResource.new(user).serializable_hash
    end

    def create
      user = User.find_or_create_by(user_params)

      if user.persisted?
        access_token_expires_at = JWT_EXPIRATION.from_now
        encoded_token = encode_jwt({ id: user.id, exp: access_token_expires_at.to_i })

        render json: {
          id: user.id,
          access_token: encoded_token,
          access_token_expires_at: access_token_expires_at.iso8601
        }
      else
        head :unprocessable_entity
      end
    end

    def destroy
      if current_user.destroy
        head :no_content
      else
        head :unprocessable_entity
      end
    end

    private

    def user_params
      params.permit(:name, :email, :avatar_url)
    end

    def encode_jwt(payload)
      secret_key = ENV.fetch('SECRET_KEY_BASE')
      JWT.encode(payload, secret_key, 'HS256')
    end
  end
end
