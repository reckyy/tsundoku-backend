# frozen_string_literal: true

module Api
  class BooksController < ApplicationController
    def create
      book = Book.find_or_create_by!(book_params)
      if book && create_user_book(book, params[:email])
        head :ok
      else
        render json: { error: '本の登録に失敗しました' }, status: unprocessable_entity
      end
    rescue StandardError => e
      render json: { error: e.message }, status: :internal_server_error
    end

    private

    def book_params
      params.require(:book).permit(:title, :author, :cover_image_url, :email)
    end

    def create_user_book(book, email)
      user = User.find_by(email:)
      UserBook.new(user:, book:)
    end
  end
end
