# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validation' do
    it 'is valid with name, email and avatar_url' do
      user = FactoryBot.build(:user)
      expect(user).to be_valid
    end

    it 'is invalid without name' do
      user = FactoryBot.build(:user, name: nil)
      expect(user).to be_invalid
    end

    it 'is invalid without email' do
      user = FactoryBot.build(:user, email: nil)
      expect(user).to be_invalid
    end

    it 'is invalid without avatar_url' do
      user = FactoryBot.build(:user, avatar_url: nil)
      expect(user).to be_invalid
    end

    it 'is invalid with a duplicate email' do
      FactoryBot.create(:user, email: 'test@example.com')
      user = FactoryBot.build(:user, email: 'test@example.com')
      expect(user).to be_invalid
    end
  end

  describe 'User#info' do
    before do
      user_book = FactoryBot.create(:user_book)
      heading = FactoryBot.create(:heading, user_book:)
      memo = FactoryBot.create(:memo, heading:)
      @reading_log = FactoryBot.create(:reading_log, memo:)
      @user = user_book.user
    end

    it 'returns user books and logs' do
      expected_logs = [{ date: @reading_log.read_date.to_s.to_s, count: 1 }]
      expected_result = { books: @user.books, logs: expected_logs }

      expect(@user.info).to eq(expected_result)
    end
  end
end
