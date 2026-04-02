# frozen_string_literal: true

module API
  class HeadingsController < ApplicationController
    def create
      user_book = current_user.user_books.find(params[:user_book_id])
      heading = Heading.new(user_book:, number: params[:number].to_i, title: '', memo_attributes: {})
      if heading.save
        render json: HeadingResource.new(heading).serializable_hash
      else
        render json: { error: '章の追加に失敗しました。' }, status: :unprocessable_entity
      end
    end

    def update
      heading = current_user.headings.find(params[:id])
      if heading.update(title: params[:title])
        head :ok
      else
        render json: { error: '章の更新に失敗しました' }, status: :unprocessable_entity
      end
    end
  end
end
