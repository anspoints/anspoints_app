require 'date'
require 'date_validator'

class Event < ApplicationRecord
    validate :validDateRange
    validates :name, presence: true
    validates :startTime, date: { before: Proc.new { Time.now }, allow_blank: true }
    validates :endTime, date: { before: Proc.new { Time.now }, allow_blank: true }

    def validDateRange
        if !endTime.blank? && !startTime.blank?
            start_time = DateTime.parse(startTime.to_s)
            end_time = DateTime.parse(endTime.to_s)
            if !start_time.before?(end_time)
                errors.add(:endTime, "start time is after end time")
            end
        end
    end
end