# frozen_string_literal: true

module Api
  class UsersController < ApplicationController
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

    private

    def user_params
      params.permit(:name, :email, :avatar_url, :uid)
    end
  end
end
