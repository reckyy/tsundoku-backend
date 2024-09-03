# frozen_string_literal: true

module Api
  class AuthController < ApplicationController
    def add_session_user_data
      user = User.find_by(email: params[:email])

      render json: { id: user.id.to_s, handle_name: user.handle_name }
    end
  end
end
