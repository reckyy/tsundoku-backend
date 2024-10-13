# frozen_string_literal: true

module API
  class UserBooksController < ApplicationController
    before_action :set_user_book, only: %i[position destroy]

    def index
      render json: UserBooksResource.new(current_user).serialize
    end

    def create
      book = Book.find_by!(book_params)
      user_book = UserBook.new(book:, user: current_user)
      if user_book.save_with_heading(params[:heading_number]&.to_i)
        head :ok
      else
        render json: { error: '本の登録に失敗しました。' }, status: :unprocessable_entity
      end
    end

    def position
      destination_user_book = UserBook.find_by!(book_id: params[:destination_book_id], user: current_user)
      if @user_book.swap_positions_with(destination_user_book)
        head :ok
      else
        head :unprocessable_entity
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
      @user_book = UserBook.find_by!(book_id: params[:user_book_id], user: current_user)
    end
  end
end
