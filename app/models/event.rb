require 'date'
require 'date_validator'

class Event < ApplicationRecord
    validates :name, presence: true
    validates :date, presence: true
    validates :endTime, date: { after: Proc.new { :startTime }, allow_blank: true }
end