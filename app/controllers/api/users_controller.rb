# frozen_string_literal: true

module Api
  class UsersController < ApplicationController
    def create
      render json: current_user.id if current_user
    end
  end
end
