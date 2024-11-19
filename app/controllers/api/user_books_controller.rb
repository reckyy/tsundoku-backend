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
      render json: UserBooksResource.new(categorized_user_books).serialize
    end

    def create
      book = Book.find_by!(book_params)
      user_book = UserBook.new(book:, user: current_user)
      if user_book.save_with_heading
        head :ok
      else
        render json: { error: '本の登録に失敗しました。' }, status: :unprocessable_entity
      end
    end

    def position
      destination_user_book = UserBook.find(params[:destination_book_id])
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
        render json: { error: '本の情報の更新に失敗しました。' }, status: :unprocessable_entity
      end
    end

    def destroy
      if @user_book.destroy
        head :no_content
      else
        render json: { error: '本の削除に失敗しました。' }, status: :unprocessable_entity
      end
    end

    private

    def book_params
      params.permit(:title, :author, :cover_image_url)
    end

    def set_user_book
      @user_book = UserBook.find(params[:user_book_id])
    end
  end
end
