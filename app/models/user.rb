# frozen_string_literal: true

class User < ApplicationRecord
  attribute :isAdmin, :boolean, default: false
  validates :email, presence: true
  validates :isAdmin, inclusion: { in: [true, false] }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  devise :omniauthable, omniauth_providers: [:google_oauth2]

  def self.from_google(options)
    # return nil unless options[:email] =~ /@tamu.edu\z/
    create_with(uid: options[:uid]).find_or_create_by!(email: options[:email])
  end
end
