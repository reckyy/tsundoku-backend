# frozen_string_literal: true

module API
  class UsersController < ApplicationController
    skip_before_action :authenticate, only: %i[show create]

    def show
      user = User.find_by(id: params[:id])
      user_info_json = UserInfoResource.new(user).serialize
      render json: user_info_json
    end

    def create
      user = User.find_or_create_by(user_params)

      if user.persisted?
        token = create_token(user.id)
        render json: { id: user.id, token: }
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
  end
end
