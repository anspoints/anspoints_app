require 'date'
require 'date_validator'

class Event < ApplicationRecord
    validates :name, presence: true
    validates :date, presence: true
    validates :endTime, date: { after: Proc.new { :startTime }, allow_blank: true }

    attribute :eventCode, :string, default: -> { generate_code }

    def Event.generate_code(length=5)
        # Ambiguous characters l and i are excluded from inclusion in a code
        valid_characters = [*('a'..'z')] - %w[i l]
        code = nil
        # Create a unique random code
        until code && !Event.exists?(eventCode: code)
            code = length.times.map { valid_characters.sample }.join
        end
        code
    end
end