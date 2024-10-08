# frozen_string_literal: true

module API
  class UserBooksController < ApplicationController
    def create
      title = params[:title]
      author = params[:author]
      cover_image_url = params[:cover_image_url]
      book_id = Book.find_by!(title:, author:, cover_image_url:).id
      user_book = UserBook.new(book_id:, user: current_user)
      if user_book.save_with_heading(params[:heading_number]&.to_i)
        head :ok
      else
        render json: { error: '本の登録に失敗しました。' }, status: :unprocessable_entity
      end
    end

    def move_position
      user_book = UserBook.find_by!(book_id: params[:book_id], user: current_user)
      destination_user_book = UserBook.find_by!(book_id: params[:destination_book_id], user: current_user)
      if user_book.swap_positions_with(destination_user_book)
        head :ok
      else
        head :unprocessable_entity
      end
    end

    def destroy
      user_book = UserBook.find_by!(book_id: params[:book_id], user_id: current_user.id)
      if user_book.destroy
        head :no_content
      else
        render json: { error: '本の削除に失敗しました。' }, status: :unprocessable_entity
      end
    end
  end
end
