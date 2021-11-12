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

  def name
    # Expected by RailsAdmin for its views
    "#{first_name} #{last_name}"
  end

  def count_attended
    events.size
  end

  def self.count_points(user_id)
    current_event_types = EventTypes.all
    point_hash = {}
    current_event_types.each do |event_type|
      point_hash[event_type.id] = event_type.pointValue
    end
    this_users_events = Event.joins(:events_users)
                             .where('"events_users"."user_id" = ?', user_id)
    this_users_points = 0
    this_users_events.each do |event|
      this_users_points += point_hash[event.event_types_id]
    end
    this_users_points
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
