# frozen_string_literal: true

class UserInfoResource < BaseResource
  attributes :name

  attribute :user_books do
    categorized_user_books = CategorizedUserBooks.new(
      object.user_books.status_unread,
      object.user_books.status_reading,
      object.user_books.status_finished
    )
    UserBooksResource.new(categorized_user_books).serializable_hash
  end

  attribute :logs do
    DailyReadingLogResource.new(object).serializable_hash['logs']
  end
end
