# frozen_string_literal: true

module Api
  class MemosController < ApplicationController
    before_action :authenticate, only: [:index]

    def index
      user_book = UserBook.find_by(user: current_user, book_id: params[:book_id])
      book_with_memos = build_book_with_memos(user_book)
      render json: book_with_memos
    end

    def update
      memo = Memo.find(params[:memo][:id])
      if memo.update(memo_params)
        head :ok
      else
        render json: { error: 'メモの登録に失敗しました' }, status: :unprocessable_entity
      end
    rescue StandardError => e
      Rails.logger.error(e)
      render json: { error: e.message }, status: :internal_server_error
    end

    private

    def memo_params
      params.require(:memo).permit(:id, :body)
    end

    def build_book_with_memos(user_book)
      {
        book: {
          title: user_book.book.title,
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
  end
end
