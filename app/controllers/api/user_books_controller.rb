# frozen_string_literal: true

module Api
  class UserBooksController < ApplicationController
    before_action :authenticate, only: [:destroy]

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
