# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Book, type: :model do
  before do
    @user = FactoryBot.create(:user)
  end

  let(:book) { Book.find_or_initialize_by(title: 'テストのタイトル', author: 'テストの著者', cover_image_url: 'テストの表紙URL') }

  describe '#save_with_user_book' do
    context 'when save is successful' do
      it 'returns true' do
        expect(book.save_with_user_book(@user, 7)).to be_truthy
      end
    end

    context 'when save is failed' do
      it 'returns false and book, user_book and chapters are not saved' do
        allow(book).to receive(:save_user_book).and_raise('bookの保存中にエラー発生')
        expect(book.save_with_user_book(@user, 5)).to eq(false)
        expect(Book.exists?(title: 'テストのタイトル', author: 'テストの著者', cover_image_url: 'テストの表紙URL')).to eq(false)
      end
    end
  end
end
