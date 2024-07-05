# frozen_string_literal: true

module Api
  class BooksController < ApplicationController
    def index
      user = User.find_by(email: params[:email])
      if user.nil?
        render json: []
      else
        user_books_with_headings = user.user_books.includes(:book, :headings).map do |user_book|
          {
            book: {
              id: user_book.book.id,
              title: user_book.book.title,
              author: user_book.book.author,
              cover_image_url: user_book.book.cover_image_url
            },
            headings: user_book.headings.map do |heading|
              {
                id: heading.id,
                number: heading.number,
                title: heading.title,
                memo: {
                  id: heading.memo.id,
                  body: heading.memo.body
                }
              }
            end
          }
        end
        render json: user_books_with_headings
      end
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
      params.require(:book).permit(:title, :author, :cover_image_url)
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
