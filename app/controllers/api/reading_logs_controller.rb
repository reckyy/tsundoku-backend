# frozen_string_literal: true

module Api
  class ReadingLogsController < ApplicationController
    before_action :authenticate, only: [:index]

    def index
      reading_log = current_user.reading_logs.group(:read_date).count
      results = reading_log.map { |date, count| { date: date.to_s, count: } }
      render json: results
    end
  end
end
