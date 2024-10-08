# frozen_string_literal: true

module API
  class BooksController < ApplicationController
    def index
      render json: UserBooksResource.new(current_user).serialize
    end

    def create
      book = Book.find_or_create_by(book_params)
      if book.persisted?
        head :ok
      else
        render json: { error: '本の登録に失敗しました' }, status: :unprocessable_entity
      end
    end

    private

    def book_params
      params.permit(:title, :author, :cover_image_url)
    end
  end
end
