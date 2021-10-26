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
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  devise :omniauthable, omniauth_providers: [:google_oauth2]

  def self.from_google(options)
    # return nil unless options[:email] =~ /@tamu.edu\z/

    create_with(uid: options[:uid], first_name: 'admin',
                last_name: 'lastAdmin').find_or_create_by!(email: options[:email])
  rescue StandardError
    nil
  end
end
