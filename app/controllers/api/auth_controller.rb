# frozen_string_literal: true

module Api
  class AuthController < ApplicationController
    def add_session_user_data
      user = User.find_by(email: params[:email])

      render json: { id: user.id.to_s, handle_name: user.handle_name }
    end

    def login
      user = User.find_by(uid: params[:uid])

      if user
        head :ok
      else
        head :no_content
      end
    end
  end
end
