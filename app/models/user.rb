# frozen_string_literal: true

class User < ApplicationRecord
  attribute :isAdmin, :boolean, default: false
  attribute :email, :string
  attribute :first_name, :string
  attribute :last_name, :string

  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :isAdmin, inclusion: { in: [true, false] }
end
