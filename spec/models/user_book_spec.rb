# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserBook, type: :model do
  let(:current_user) { @user_book.user }

  before do
    @user_book = FactoryBot.create(:user_book)
    @second_user_book = FactoryBot.create(:user_book, user: @user_book.user)
    authorization_stub
  end

  describe '#swap_positions_with' do
    it 'succeeds in swapping the position of the book' do
      expect(@user_book.position).to eq(1)
      expect(@second_user_book.position).to eq(2)
      @user_book.swap_positions_with(@second_user_book)
      expect(@second_user_book.position).to eq(1)
      expect(@user_book.position).to eq(2)
    end
  end
end
