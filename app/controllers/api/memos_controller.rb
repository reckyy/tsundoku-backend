# frozen_string_literal: true

module Api
  class MemosController < ApplicationController
    before_action :authenticate, only: [:index]

    def index
      user_book = UserBook.preload(headings: :memo).find_by(user: current_user, book_id: params[:book_id])
      book_with_memos = { book: user_book.book, headings: user_book.headings.order(:id).as_json(include: :memo) }
      render json: book_with_memos
    end

    def update
      memo = Memo.find(params[:memo][:id])
      if memo.update(memo_params)
        head :ok
      else
        render json: { error: 'メモの登録に失敗しました' }, status: :unprocessable_entity
      end
    rescue StandardError => e
      render json: { error: e.message }, status: :internal_server_error
    end

    private

    def memo_params
      params.require(:memo).permit(:id, :body)
    end
  end
end
