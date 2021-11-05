# frozen_string_literal: true

require 'date'
require 'date_validator'

class Event < ApplicationRecord
  attribute :name, :string
  attribute :eventCode, :string
  attribute :description, :string
  attribute :date, :date
  attribute :startTime, :time
  attribute :endTime, :time

  validates :name, presence: true
  validates :date, presence: true
  validates :eventCode, presence: true
  validates :endTime, date: { after: :startTime, allow_blank: true }

  has_many :events_users, class_name: "EventsUsers", inverse_of: :event, dependent: :destroy
  has_many :users, through: :events_users, inverse_of: :events
  
  belongs_to :event_types, class_name: "EventTypes"

  attribute :eventCode, :string, default: -> { generate_code }

  # def point_value
  #   1
  # end

  def self.naive_now
    # Conversion to a naive time since the database stores local times for events without timezone info
    # RailsAdmin breaks if you try to use real Ruby/Rails timezone support
    Time.now.in_time_zone('Central Time (US & Canada)').change(offset: 0)
  end

  def self.ongoing
    now = naive_now
    today = now.to_date
    # (now..) means in the range [now, infinity). You can interpret it as now-or-after (while (..now) is before-to-now)
    where(date: today, startTime: [nil, (..now)], endTime: [nil, (now..)])
      .order(date: :desc, startTime: :desc)
  end

  def self.upcoming
    now = naive_now
    today = now.to_date
    tomorrow = today + 1
    where(date: today, startTime: (now..)).or(where(date: (tomorrow..)))
                                          .order(date: :asc, startTime: :asc)
  end

  def self.past
    now = naive_now
    today = now.to_date
    yesterday = today - 1
    where(date: today, endTime: (..now)).or(where(date: (..yesterday)))
                                        .order(date: :desc, startTime: :desc)
  end

  def self.from_code(code)
    # Retrieves the most relevant event matching the code
    # Each of these categories is sorted to where the elements closest to the present come first
    ongoing.where(eventCode: code).first \
    || past.where(eventCode: code).first \
    || upcoming.where(eventCode: code).first
  end

  def self.generate_code(length = 5)
    # Ambiguous characters l and i are excluded from inclusion in a code
    valid_characters = [*('a'..'z')] - %w[i l]
    code = nil
    # Create a unique random code
    code = length.times.map { valid_characters.sample }.join until code && !Event.exists?(eventCode: code)
    code
  end
end
