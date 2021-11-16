# frozen_string_literal: true

class EventTypes < ApplicationRecord
  attribute :name, :string
  attribute :pointValue, :integer
  attribute :color, :string

  validates :name, presence: true

  validates :pointValue, presence: true
  validates_numericality_of(:pointValue, greater_than_or_equal_to: 0)

  validates :color, presence: true,
                    format: { with: /\A\#{1}[0-9a-fA-F]{6}\z/ }
end
