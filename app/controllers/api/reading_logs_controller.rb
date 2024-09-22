# frozen_string_literal: true

module API
  class ReadingLogsController < ApplicationController
    before_action :authenticate, only: %i[index create]

    def index
      reading_log = current_user.reading_logs.group(:read_date).count
      results = reading_log.map { |date, count| { date: date.to_s, count: } }
      render json: results
    end

    def create
      reading_log = ReadingLog.find_or_create_by!(memo_id: params[:memo_id], read_date: Time.zone.today)
      if reading_log
        head :ok
      else
        render json: { error: 'ログの登録に失敗しました' }, status: :unprocessable_entity
      end
    end
  end
end
