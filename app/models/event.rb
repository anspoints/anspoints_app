# frozen_string_literal: true

require 'date'
require 'date_validator'

class Event < ApplicationRecord
  validates :name, presence: true
  validates :date, presence: true
  validates :endTime, date: { after: proc { :startTime }, allow_blank: true }

  attribute :eventCode, :string, default: -> { generate_code }

  def self.generate_code(length = 5)
    # Ambiguous characters l and i are excluded from inclusion in a code
    valid_characters = [*('a'..'z')] - %w[i l]
    code = nil
    # Create a unique random code
    code = length.times.map { valid_characters.sample }.join until code && !Event.exists?(eventCode: code)
    code
  end
end
