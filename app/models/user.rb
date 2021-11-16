# frozen_string_literal: true

class User < ApplicationRecord
  attribute :isAdmin, :boolean, default: false
  attribute :email, :string
  attribute :first_name, :string
  attribute :last_name, :string
  attribute :dues_paid, :boolean, default: false

  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :isAdmin, inclusion: { in: [true, false] }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  has_many :events_users, class_name: 'EventsUsers', inverse_of: :user, dependent: :destroy
  has_many :events, through: :events_users, inverse_of: :users

  devise :omniauthable, omniauth_providers: [:google_oauth2]

  # def total_points
  #   events.sum { |e| e.point_value }
  # end

  def self.from_google(options)
    # return nil unless options[:email] =~ /@tamu.edu\z/

    create_with(uid: options[:uid], first_name: 'admin',
                last_name: 'lastAdmin').find_or_create_by!(email: options[:email])
  rescue StandardError
    nil
  end

  def self.from_csv(file); end

  def name
    # Expected by RailsAdmin for its views
    "#{first_name} #{last_name}"
  end

  def count_attended
    events.size
  end

  # Enter in a query such as user.count_points(Event.where(...)) to see a user's points from those events
  def count_points(limited_to_events = Event)
    limited_to_events.includes(:events_users).where(events_users: { user: self })
                     .includes(:event_types).sum('"event_types"."pointValue"')
  end

  rails_admin do
    configure :isAdmin do
      label 'Admin'
    end

    configure :events_users do
      label 'Check-ins'
      hide
    end

    configure :events do
      label 'Attended'
    end

    configure :count_attended do
      formatted_value { bindings[:object].count_attended }
      read_only true
      help ''
    end

    list do
      fields :id, :email, :first_name, :last_name, :count_attended
    end
  end
end
