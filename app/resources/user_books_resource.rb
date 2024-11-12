# frozen_string_literal: true

class UserBooksResource < BaseResource
  attribute :unread do
    UnreadUserBooksResource.new(object).serializable_hash['user_books']
  end

  attribute :reading do
    ReadingUserBooksResource.new(object).serializable_hash['user_books']
  end

  attribute :finished do
    FinishedUserBooksResource.new(object).serializable_hash['user_books']
  end
end
