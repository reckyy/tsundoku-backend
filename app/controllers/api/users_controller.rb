# frozen_string_literal: true

module Api
  class UsersController < ApplicationController
    before_action :authenticate, only: %i[destroy]

    def create
      user = User.find_or_create_by!(user_params)
      if user
        head :ok
      else
        render json: { error: 'ログインに失敗しました' }, status: :unprocessable_entity
      end
    rescue StandardError => e
      render json: { error: e.message }, status: :internal_server_error
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
      params.permit(:name, :email, :avatar_url, :uid)
    end
  end
end
