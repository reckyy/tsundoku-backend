# frozen_string_literal: true

module API
  class UserBooksController < ApplicationController
    before_action :authenticate, only: %i[move_position destroy]

    def move_position
      user_book = UserBook.find_by(book_id: params[:book_id], user: current_user)
      destination_user_book = UserBook.find_by(book_id: params[:destination_book_id], user: current_user)
      if user_book.swap_positions_with(destination_user_book)
        head :ok
      else
        head :unprocessable_entity
      end
    end

    def destroy
      user_book = UserBook.find_by(book_id: params[:book_id], user_id: current_user.id)
      if user_book.destroy
        head :no_content
      else
        render json: { error: '本の削除に失敗しました。' }, status: :unprocessable_entity
      end
    end
  end
end
