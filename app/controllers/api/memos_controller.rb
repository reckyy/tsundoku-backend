# frozen_string_literal: true

module API
  class MemosController < ApplicationController
    def index
      user_book = UserBook.find_by!(user: current_user, book_id: params[:book_id])
      user_book_with_memos = UserBookWithMemosResource.new(user_book).serialize
      render json: user_book_with_memos
    end

    def update
      memo = Memo.find(params[:id])
      if memo.update(body: params[:body])
        head :ok
      else
        render json: { error: 'メモの登録に失敗しました' }, status: :unprocessable_entity
      end
    end
  end
end
