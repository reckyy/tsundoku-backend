# frozen_string_literal: true

class ApplicationController < ActionController::API
  before_action :camel2snake_params

  private

  def camel2snake_params
    params.deep_transform_keys!(&:underscore)
  end
end
