# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserBook, type: :model do
  let(:current_user) { @user_book.user }
  let(:book) { FactoryBot.create(:book) }
  let(:user_book) { UserBook.new(user: @user_book.user, book:) }

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

  describe '#save_with_heading' do
    context 'when save is successful' do
      it 'returns true' do
        expect(user_book.save_with_heading).to be_truthy
      end
    end

    context 'when save is failed' do
      it 'returns false and book, user_book and headings are not saved' do
        allow(user_book).to receive(:save_with_heading).and_return(false)
        expect(user_book.save_with_heading).to eq(false)
        expect(UserBook.exists?(user: @user_book.user, book:)).to eq(false)
      end
    end
  end
end
