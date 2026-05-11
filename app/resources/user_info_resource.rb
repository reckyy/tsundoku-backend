# frozen_string_literal: true

class UserInfoResource < BaseResource
  attributes :name

  attribute :user_books do
    grouped = object.user_books.includes(:book).group_by(&:status)
    categorized_user_books = CategorizedUserBooks.new(
      grouped['unread'] || [],
      grouped['reading'] || [],
      grouped['finished'] || []
    )
    UserBooksResource.new(categorized_user_books).serializable_hash
  end

  attribute :logs do
    DailyReadingLogResource.new(object).serializable_hash['logs']
  end
end
