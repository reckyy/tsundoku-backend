# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'API::Headings', type: :request do
  let(:current_user) { @user_book.user }

  before do
    @user_book = FactoryBot.create(:user_book)
    @heading = FactoryBot.create(:heading, user_book: @user_book)
    authorization_stub
  end

  describe 'API::HeadingsController#create' do
    context 'params is valid' do
      it 'succeeds adding heading' do
        expect(@user_book.headings.length).to eq(1)
        params = { user_book_id: @user_book.id, number: 2 }
        post(api_headings_path, params:)
        expect(response).to have_http_status(:ok)
        @user_book.reload
        expect(@user_book.headings.length).to eq(2)
      end
    end

    context 'params is invalid' do
      it 'returns a bad response' do
        params = { user_book_id: -1, number: 2 }
        post(api_headings_path, params:)
        expect(response).to have_http_status(422)
      end
    end
  end

  describe 'API::HeadingsController#update' do
    context 'params is valid' do
      it 'returns a successful response' do
        params = { id: @heading.id, title: '更新後のタイトル' }
        patch(api_heading_path(@heading.id), params:)
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when update fails' do
      it 'returns a bad response' do
        allow_any_instance_of(Heading).to receive(:update).and_return(false)
        params = { id: @heading.id, title: '更新後のタイトル' }
        patch(api_heading_path(@heading.id), params:)
        expect(response).to have_http_status(422)
      end
    end
  end
end
