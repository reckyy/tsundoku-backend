# frozen_string_literal: true

class ApplicationController < ActionController::API
  before_action :camel2snake_params

  attr_reader :current_user

  private

  def authenticate
    @current_user = User.find_by(uid: params[:uid])
  end

  def camel2snake_params
    params.deep_transform_keys!(&:underscore)
  end
end
