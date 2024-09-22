# frozen_string_literal: true

module API
  class AuthController < ApplicationController
    def add_session_user_data
      user = User.find_by(email: params[:email])

      render json: { id: user.id.to_s }
    end
  end
end
