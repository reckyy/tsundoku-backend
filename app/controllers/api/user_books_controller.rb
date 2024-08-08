# frozen_string_literal: true

module Api
  class UserBooksController < ApplicationController
    before_action :authenticate, only: %i[bulk_update destroy]

    def bulk_update
      succeeded = true
      UserBook.transaction do
        params[:books].each do |book|
          user_book = UserBook.find_by(book_id: book[:id], user: current_user)

          unless user_book&.update(position: book[:position])
            succeeded = false
            raise ActiveRecord::Rollback
          end
        end
      end

      if succeeded
        head :ok
      else
        render json: { error: '本棚の更新に失敗しました。' }, status: :unprocessable_entity
      end
    end

    def destroy
      user_book = UserBook.find_by(book_id: params[:book_id], user_id: current_user.id)
      if user_book.destroy
        head :no_content
      else
        render json: { error: '本の削除に失敗しました。' }, status: :unprocessable_entity
      end
    end
  end
end
