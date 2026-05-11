# frozen_string_literal: true

module API
  class MemosController < ApplicationController
    def index
      user_book = UserBook
                  .includes(:book, headings: :memo)
                  .find_by!(user: current_user, book_id: params[:book_id])
      render json: UserBookWithMemosResource.new(user_book).serializable_hash
    end

    def update
      memo = current_user.memos.find(params[:id])
      if memo.update(body: params[:body])
        head :ok
      else
        head :unprocessable_entity
      end
    end
  end
end
