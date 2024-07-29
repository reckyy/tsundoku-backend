# frozen_string_literal: true

module Api
  class HeadingsController < ApplicationController
    def update
      heading = Heading.find(params[:heading][:id])
      if heading.update(title: params[:heading][:title])
        head :ok
      else
        render json: { error: '章の更新に失敗しました' }, status: :unprocessable_entity
      end
    end
  end
end
