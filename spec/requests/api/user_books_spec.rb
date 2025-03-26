# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'API::UserBooks', type: :request do
  let(:current_user) { FactoryBot.create(:user) }
  let(:second_book) { FactoryBot.create(:book) }
  let(:second_user_book) { UserBook.create(user: current_user, book: second_book) }

  before do
    @book = FactoryBot.create(:book)
    @user_book = UserBook.create(user: current_user, book: @book)
    authorization_stub
  end

  describe 'API::BooksController#index' do
    context 'params is valid' do
      it 'returns a successful response' do
        get(api_user_books_path)
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'API::UserBooksController#create' do
    context 'params is valid' do
      it 'returns a successful response' do
        book = FactoryBot.create(:book)
        params = { title: book.title, author: book.author, coverImageUrl: book.cover_image_url }
        expect { post(api_user_books_path, params:) }.to change { UserBook.count }.by(1)
        expect(response).to have_http_status(:ok)
      end
    end

    context 'params is invalid' do
      it 'returns a bad response' do
        allow_any_instance_of(UserBook).to receive(:save_with_heading).and_return(false)
        params = { title: @book.title, author: @book.author, coverImageUrl: @book.cover_image_url }
        post(api_user_books_path, params:)
        expect(response).to have_http_status(422)
      end
    end
  end

  describe 'API::UserBooksController#position' do
    context 'params is valid' do
      it 'succeeds in swaping the position' do
        expect(@user_book.position).to eq(1)
        expect(second_user_book.position).to eq(2)
        params = { user_book_id: @user_book.id, destination_book_id: second_user_book.id }
        patch(position_api_user_book_path(@user_book.id), params:)
        @user_book.reload
        expect(@user_book.position).to eq(2)
        expect(response).to have_http_status(:ok)
      end
    end

    context 'params is invalid' do
      it 'fails in swaping the position' do
        allow_any_instance_of(UserBook).to receive(:swap_positions_with).and_return(false)
        params = { user_book_id: @user_book.id, destination_book_id: second_user_book.id }
        patch(position_api_user_book_path(@user_book.id), params:)
        expect(response).to have_http_status(422)
      end
    end
  end

  describe 'API::UserBooksController#update' do
    context 'params is valid' do
      it 'returns a successful response' do
        params = { user_book_id: @user_book.id, status: 'reading' }
        patch(api_user_book_path(@user_book.id), params:)
        expect(response).to have_http_status(:ok)
        @user_book.reload
        expect(@user_book.status).to eq('reading')
      end
    end

    context 'when update fails' do
      it 'returns a bad response' do
        allow_any_instance_of(UserBook).to receive(:update).and_return(false)
        params = { user_book_id: @user_book.id, status: 'reading' }
        patch(api_user_book_path(@user_book.id), params:)
        expect(response).to have_http_status(422)
      end
    end
  end

  describe 'API::UserBooksController#destroy' do
    context 'params is valid' do
      it 'returns a nocontent response' do
        params = { user_book_id: @user_book.id }
        expect { delete(api_user_book_path(@user_book.id), params:) }.to change { UserBook.count }.by(-1)
        expect(response).to have_http_status(:no_content)
      end
    end

    context 'when destroy fails' do
      it 'returns a bad response' do
        allow_any_instance_of(UserBook).to receive(:destroy).and_return(false)
        params = { user_book_id: @user_book.id }
        expect { delete(api_user_book_path(@user_book.id), params:) }.not_to(change { UserBook.count })
        expect(response).to have_http_status(422)
      end
    end
  end
end
