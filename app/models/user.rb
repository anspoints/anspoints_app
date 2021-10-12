# frozen_string_literal: true

class User < ApplicationRecord
  attribute :isAdmin, :boolean, default: false
  validates :email, presence: true
  validates :isAdmin, inclusion: { in: [true, false] }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
end
