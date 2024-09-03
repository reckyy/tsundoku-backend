# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::Headings', type: :request do
  before do
    @heading = FactoryBot.create(:heading)
  end

  describe 'Api::HeadingsController#update' do
    context 'params is valid' do
      it 'return a successful response' do
        params = { user_id: @heading.user_book.user.id, id: @heading.id, title: '更新後のタイトル' }
        patch(api_heading_path(@heading.id), params:)
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
