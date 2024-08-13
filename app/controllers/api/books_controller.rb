# frozen_string_literal: true

module Api
  class BooksController < ApplicationController
    before_action :authenticate

    def index
      render json: current_user.nil? ? [] : current_user.books.position_order
    end

    def create
      title = params[:title]
      author = params[:author]
      cover_image_url = params[:cover_image_url]
      book = Book.find_or_initialize_by(title:, author:, cover_image_url:)
      if book.save_with_user_book(current_user, params[:heading_number]&.to_i)
        head :ok
      else
        render json: { error: '本の登録に失敗しました' }, status: :unprocessable_entity
      end
    end
  end
end
