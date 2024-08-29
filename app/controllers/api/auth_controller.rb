# frozen_string_literal: true

module Api
  class AuthController < ApplicationController
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
