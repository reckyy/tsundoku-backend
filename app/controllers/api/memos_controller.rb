# frozen_string_literal: true

module Api
  class MemosController < ApplicationController
    def update
      memo = Memo.find_by(heading_id: params[:heading][:id])
      if memo.update(memo_params)
        head :ok
      else
        render json: { error: '本の登録に失敗しました' }, status: unprocessable_entity
      end
    rescue StandardError => e
      render json: { error: e.message }, status: :internal_server_error
    end

    private

    def memo_params
      params.require(:memo).permit(:body)
    end
  end
end
