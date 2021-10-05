# frozen_string_literal: true

class Contact < ApplicationRecord
  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
end
