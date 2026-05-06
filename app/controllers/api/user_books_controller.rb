# frozen_string_literal: true

module API
  class UserBooksController < ApplicationController
    before_action :set_user_book, only: %i[update position destroy]

    def index
      user_books = current_user.user_books
      categorized_user_books = CategorizedUserBooks.new(
        user_books.status_unread_ordered,
        user_books.status_reading_ordered,
        user_books.status_finished_ordered
      )
      render json: UserBooksResource.new(categorized_user_books).serializable_hash
    end

    def create
      book = Book.find_or_create_by(book_params)
      return head :unprocessable_entity unless book.persisted?

      user_book = UserBook.new(book:, user: current_user)
      if user_book.save_with_heading
        head :created
      else
        head :unprocessable_entity
      end
    end

    def position
      destination_user_book = current_user.user_books.find(params[:destination_book_id])
      if @user_book.swap_positions_with(destination_user_book)
        head :ok
      else
        head :unprocessable_entity
      end
    end

    def update
      if @user_book.update(status: params[:status])
        head :ok
      else
        head :unprocessable_entity
      end
    end

    def destroy
      if @user_book.destroy
        head :no_content
      else
        head :unprocessable_entity
      end
    end

    private

    def book_params
      params.permit(:title, :author, :cover_image_url)
    end

    def set_user_book
      @user_book = current_user.user_books.find(params[:id])
    end
  end
end
