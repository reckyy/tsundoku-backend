# frozen_string_literal: true

class UserInfoResource < BaseResource
  attribute :books do
    UserBooksResource.new(object).serializable_hash['books']
  end

  attribute :logs do
    DailyReadingLogResource.new(object).serializable_hash['logs']
  end
end
