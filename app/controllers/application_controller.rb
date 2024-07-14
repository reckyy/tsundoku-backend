# frozen_string_literal: true

class ApplicationController < ActionController::API
  before_action :camel2snake_params
  before_action :authenticate

  attr_reader :current_user

  private

  def authenticate
    @current_user = User.find_or_create_user(user_params)
  end

  def camel2snake_params
    params.deep_transform_keys!(&:underscore)
  end

  def user_params
    params.require(:user).permit(:id, :name, :email, :avatar_url)
  end
end
