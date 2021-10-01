require 'date'

class Event < ApplicationRecord
    validate :validDateRange
    validates :eventId, presence: true
    validates :name, presence: true

    def validDateRange
        return if endTime.blank? && startTime.blank?
        start_time = DateTime.parse(startTime.to_s)
        if !start_time.before?(DateTime.now)
            errors.add(:startTime, "must be in the future")
        end
        end_time = DateTime.parse(endTime.to_s)
        if !end_time.before?(DateTime.now)
            errors.add(:endTime, "must be in the future")
        end
        if !start_time.before?(end_time)
            errors.add(:endTime, "start time is after end time")
        end
    end
end