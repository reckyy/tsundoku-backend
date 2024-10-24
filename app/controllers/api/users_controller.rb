# frozen_string_literal: true

module API
  class UsersController < ApplicationController
    skip_before_action :verify_google_id_token, only: %i[show create]

    def show
      user = User.find(params[:id])
      user_info_json = UserInfoResource.new(user).serialize
      render json: user_info_json
    end

    def create
      user = User.find_or_create_by(user_params)

      if user.persisted?
        render json: { id: user.id }
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
