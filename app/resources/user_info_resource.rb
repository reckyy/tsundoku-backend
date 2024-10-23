# frozen_string_literal: true

class UserInfoResource < BaseResource
  attribute :user_books do
    UserBooksResource.new(object).serializable_hash['user_books']
  end

  attribute :logs do
    DailyReadingLogResource.new(object).serializable_hash['logs']
  end
end
