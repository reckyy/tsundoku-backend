# frozen_string_literal: true

module API
  class UsersController < ApplicationController
    before_action :verify_google_id_token, only: %i[create]
    skip_before_action :authenticate, only: %i[show create]

    def show
      user = User.find(params[:id])
      render json: UserInfoResource.new(user).serialize
    end

    def create
      user = User.find_or_create_by(user_params)

      if user.persisted?
        encoded_token = encode_jwt({ id: user.id })
        render json: { id: user.id, access_token: encoded_token }
      else
        render json: { error: 'ログインに失敗しました' }, status: :unprocessable_entity
      end
    end

    def destroy
      if current_user.destroy
        head :no_content
      else
        render json: { error: '退会に失敗しました。' }, status: :unprocessable_entity
      end
    end

    private

    def user_params
      params.permit(:id, :name, :email, :avatar_url)
    end

    def encode_jwt(payload)
      secret_key = Rails.application.credentials.secret_key_base
      JWT.encode(payload, secret_key, 'HS256')
    end
  end
end
