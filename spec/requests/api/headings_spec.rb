# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'API::Headings', type: :request do
  let(:current_user) { @heading.user_book.user }

  before do
    @heading = FactoryBot.create(:heading)
    authorization_stub
  end

  describe 'API::HeadingsController#update' do
    context 'params is valid' do
      it 'return a successful response' do
        params = { id: @heading.id, title: '更新後のタイトル' }
        patch(api_heading_path(@heading.id), params:)
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
