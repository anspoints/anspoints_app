# frozen_string_literal: true

class Contact < ApplicationRecord
  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  def name
    "#{firstname} #{lastname}"
  end
end
