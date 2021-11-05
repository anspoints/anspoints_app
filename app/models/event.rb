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

  has_many :events_users, class_name: 'EventsUsers', inverse_of: :event, dependent: :destroy
  has_many :users, through: :events_users, inverse_of: :events

  belongs_to :event_types, class_name: 'EventTypes'

  attribute :eventCode, :string, default: -> { generate_code }

  def self.naive_time(time)
    # Conversion to a "naive" time since the database stores local times for events without timezone info
    # RailsAdmin breaks if you try to use real Ruby/Rails timezone support
    # Rationale:
    # This lets users continue to enter in their local times, which are stored in the database with no known offset
    # So this method removes the offset from Ruby's time classes to become comparable with records in the database
    # See Event::ongoing, Event::upcoming, and Event::past for examples
    # NOTE: this is only relevant for the :date, :startTime, and :endTime attributes of Event
    time.in_time_zone('Central Time (US & Canada)').change(offset: 0)
  end

  def self.corrected_time(time)
    # Restores the timezone from a "naive" time stored in the database by imbuing the correct offset
    # This is the inverse operation of Event::naive_time, located above
    # Use this in e.g. `if Event.corrected_time(event.startTime) > Time.now`
    # or generally when doing time calculations in Ruby, as opposed to directly in the database

    # Reflects the UTC offset for the particular date associated with `time`, respecting daylight savings time
    # Normally -6 or -5 for CST and CDT respectively, so `time + 5.hour` approximates an accurate timestamp
    # to roughly ensure the correct day is being considered when retrieving the actual offset
    true_offset = (time + 5.hour).in_time_zone('Central Time (US & Canada)').utc_offset / 1.hour
    # After changing the offset, the in_time_zone call mainly just provides the remaining timezone locale info for Ruby
    time.change(offset: true_offset).in_time_zone('Central Time (US & Canada)')
  end

  def self.naive_now
    naive_time(Time.now)
  end

  def self.ongoing
    now = naive_now
    today = now.to_date
    # (now..) means in the range [now, infinity). You can interpret it as now-or-after (while (..now) is before-to-now)
    where(date: today, startTime: [nil, (..now)], endTime: [nil, (now..)])
      .order(date: :desc, startTime: :desc)
      .joins(:event_types)
  end

  def self.upcoming
    now = naive_now
    today = now.to_date
    tomorrow = today + 1
    where(date: today, startTime: (now..)).or(where(date: (tomorrow..)))
                                          .order(date: :asc, startTime: :asc)
                                          .joins(:event_types)
  end

  def self.past
    now = naive_now
    today = now.to_date
    yesterday = today - 1
    where(date: today, endTime: (..now)).or(where(date: (..yesterday)))
                                        .order(date: :desc, startTime: :desc)
                                        .joins(:event_types)
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

  def attendance
    users.size
  end

  rails_admin do
    configure :startTime do
      label 'Start time'
    end

    configure :endTime do
      label 'End time'
    end

    configure :eventCode do
      label 'Event code'
    end

    configure :events_users do
      label 'Check-ins'
      hide
    end

    configure :users do
      label 'Attendees'
    end

    configure :attendance do
      formatted_value { bindings[:object].attendance }
      read_only true
      help ''
    end

    list do
      fields :id, :name, :eventCode, :date, :startTime, :attendance
    end
  end
end
