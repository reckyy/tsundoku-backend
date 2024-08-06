# frozen_string_literal: true

module Api
  class UsersController < ApplicationController
    before_action :authenticate, only: %i[show destroy]

    def show
      user_info = current_user.info
      render json: user_info
    end

    def create
      user = User.find_or_create_by(user_params)
      if user.persisted?
        head :ok
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
      params.permit(:name, :email, :avatar_url, :uid)
    end
  end
end
