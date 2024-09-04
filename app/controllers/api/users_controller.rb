# frozen_string_literal: true

module Api
  class UsersController < ApplicationController
    before_action :authenticate, only: %i[update destroy]

    def show
      user_info = User.find_by(handle_name: params[:handle_name]).info
      render json: user_info
    end

    def create
      user = User.find_or_initialize_by(user_params)
      user.handle_name = "User_#{SecureRandom.uuid}" if user.new_record?

      if user.persisted?
        head :ok
      elsif user.save
        head :created
      else
        render json: { error: 'ログインに失敗しました' }, status: :unprocessable_entity
      end
    end

    def update
      Rails.logger.debug current_user
      if current_user.update(handle_name: params[:handle_name])
        head :ok
      else
        render json: { error: current_user.errors.full_messages.join(', ') }, status: :unprocessable_entity
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
      params.permit(:id, :name, :email, :avatar_url, :uid, :handle_name)
    end
  end
end
