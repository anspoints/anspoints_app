# frozen_string_literal: true

class EventTypes < ApplicationRecord
    attribute :name, :string
    attribute :pointValue, :integer
    attribute :color, :string
  
    validates :name, presence: true
  
    validates :pointValue, presence: true,
                         :inclusion => 1..100
    validates :color, presence: true,
                         format: { with: /\A\#{1}[0-9a-fA-F]{6}\z/ }
end