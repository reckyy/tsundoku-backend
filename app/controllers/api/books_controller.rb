# frozen_string_literal: true

module Api
  class BooksController < ApplicationController
    def index
      user = User.find_by(email: params[:email])
      render json: user.nil? ? [] : user.books
    end

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
      params.permit(:title, :author, :cover_image_url)
    end

    def create_user_book(book, email)
      user = User.find_by(email:)
      user_book = UserBook.find_or_create_by!(user:, book:)
      heading_number = params[:heading_number]&.to_i
      return false if heading_number.nil?

      insert_chapter(user_book, heading_number)
    end

    def insert_chapter(user_book, heading_number)
      (1..heading_number).map do |n|
        user_book.headings.create!(number: n, title: "Chapter #{n}", memo_attributes: {})
      end
      true
    end
  end
end
