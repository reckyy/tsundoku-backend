# frozen_string_literal: true

module API
  class HeadingsController < ApplicationController
    before_action :authenticate, only: [:update]

    def update
      heading = Heading.find(params[:id])
      if heading.update(title: params[:title])
        head :ok
      else
        render json: { error: '章の更新に失敗しました' }, status: :unprocessable_entity
      end
    end
  end
end
