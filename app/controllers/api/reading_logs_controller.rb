# frozen_string_literal: true

module API
  class ReadingLogsController < ApplicationController
    def index
      render json: DailyReadingLogResource.new(current_user).serializable_hash
    end

    def create
      reading_log = ReadingLog.find_or_create_by(memo_id: params[:memo_id], read_date: Time.zone.today)
      if reading_log.persisted?
        head :ok
      else
        render json: { error: 'ログの登録に失敗しました' }, status: :unprocessable_entity
      end
    end
  end
end
